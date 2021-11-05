shader_type canvas_item;

uniform vec2 wave_speed = vec2(1, 1);
uniform vec2 wave_length = vec2(.02, .02);

uniform vec4 flash_color: hint_color = vec4(1f);
uniform float flash_modifire: hint_range(0f, 1f) = 0f;

void vertex() {
//	VERTEX.x += 1.5f * sin(TIME * 10f);
//	VERTEX.x *= clamp(sin(TIME * 10f), .8 , 1f);
//	VERTEX.y *= clamp(cos(TIME * 10f), .8 , 1f);
}

void fragment() {
	vec2 uv = UV;
	vec2 wave_uv;
	wave_uv.x = cos(TIME * wave_speed.x + uv.x + uv.y) * wave_length.x;
	wave_uv.y = sin(TIME * wave_speed.y + uv.x + uv.y) * wave_length.y;
	
	vec4 color = texture(TEXTURE, uv + wave_uv);
	color.rgb = mix(color.rgb, flash_color.rgb, flash_modifire);
	COLOR = color;
}