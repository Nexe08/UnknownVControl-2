shader_type canvas_item;

uniform float shake_power = 0.03;
uniform float shake_rate: hint_range(0f, 1f) = .2;
uniform float shake_speed = 5f;
uniform float shake_block_size = 30.5;
uniform float shake_color_rate: hint_range(0f, 1f) = .01;

float random(float seed) {
	return fract(543.2543 * sin(dot(vec2(seed, seed), vec2(3525.46, -54.3425))));
}


void fragment() {
	float enable_shift = float(random(trunc(TIME*shake_speed)) < shake_rate);
	
	vec2 fixed_uv = SCREEN_UV;
	fixed_uv.x += (
		random(
			(trunc(SCREEN_UV.y*shake_block_size) / shake_block_size)+TIME) -.5
	) * shake_power*enable_shift;
	
	vec4 pixel_color = textureLod(SCREEN_TEXTURE, fixed_uv, 0f);
	pixel_color.r = mix(pixel_color.r,textureLod(SCREEN_TEXTURE,fixed_uv+vec2(shake_color_rate,0f),0f).r,enable_shift);
	pixel_color.b = mix(
		pixel_color.b,
		textureLod(SCREEN_TEXTURE, fixed_uv+vec2(-shake_color_rate,0f),0f).b,enable_shift
	);
	COLOR = pixel_color;
}
