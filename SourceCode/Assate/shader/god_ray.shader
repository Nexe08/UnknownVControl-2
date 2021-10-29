shader_type canvas_item;

uniform float angle = -0.3;
uniform float position = -0.2;
uniform float spread: hint_range(-1f, 1f) = 0.5;
uniform float cutoff: hint_range(-1f, 1f) = 0.1;
uniform float falloff: hint_range(0f, 1f) = .2;
uniform float edge_fade: hint_range(0f, 1f) = .15;

uniform float speed = 1f;
uniform float ray1_density = 8f;
uniform float ray2_density = 30f;
uniform float ray2_intencity: hint_range(0f, 1f) = .3;

uniform vec4 color: hint_color = vec4(1f, .9, .65, .8);

uniform bool hdr = false;
uniform float seed = 5f;


float random(vec2 _uv) {
	return fract(sin(dot(_uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}


float noise(in vec2 uv) {
	vec2 i = floor(uv);
	vec2 f = floor(uv);
	
	float a = random(i);
	float b = random(i + vec2(1f, 0f));
	float c = random(i + vec2(0f, 1f));
	float d = random(i + vec2(1f, 1f));
	
	vec2 u = f * f * (3f - 2f * f);
	
	return mix(a, b, u.x) + (c - a) * u.y * (1f - u.x) + (d - b) * u.x * u.y;
}

mat2 rotate(float _angle) {
	return mat2(vec2(cos(_angle), -sin(_angle)), vec2(sin(_angle), cos(_angle)));
}

vec4 screen(vec4 base, vec4 blend) {
	return 1f - (1f - base) * (1f - blend);
}

void fragment() {
	vec2 transformed_uv = (rotate(angle) * (UV - position)) / (UV.y + spread) - (UV.y * spread);
	
	vec2 ray1 = vec2(transformed_uv.x * ray1_density + sin(TIME * .1 * speed) * (ray1_density * .2) + seed, 1f);
	vec2 ray2 = vec2(transformed_uv.x * ray2_density + sin(TIME * .2 * speed) * (ray1_density * .2) + seed, 1f);
	
	float cut = step(cutoff, transformed_uv.x) * step(cutoff, 1f - transformed_uv.x);
	ray1 *= cut;
	ray2 *= cut;
	
	float rays;
	
	if (hdr) {
		rays = noise(ray1) + (noise(ray2) * ray2_intencity);
	}
	else {
		rays = clamp(noise(ray1) + (noise(ray2) * ray2_intencity), 0f, 1f);
	}
	
	rays *= smoothstep(0f, falloff, (1f - UV.y));
	rays *= smoothstep(0f + cutoff, edge_fade + cutoff, transformed_uv.x);
	rays *= smoothstep(0f + cutoff, edge_fade + cutoff, 1f - transformed_uv.x);
	
	vec3 shine = vec3(rays) * color.rgb;
	
	shine = screen(texture(SCREEN_TEXTURE, SCREEN_UV), vec4(color)).rgb;
	
	COLOR = vec4(shine, rays * color.a);
}








