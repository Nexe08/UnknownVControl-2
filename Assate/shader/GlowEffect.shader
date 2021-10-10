shader_type canvas_item;

uniform sampler2D emmition_texture;
uniform vec4 glow_color: hint_color = vec4(1f);

void fragment() {
	vec4 color = textureLod(SCREEN_TEXTURE, UV, 2f);
	vec4 current_color = texture(TEXTURE, UV);
	vec4 emmition_color = texture(emmition_texture, UV);
	
	if (emmition_color.r > 0f) {
		COLOR = (emmition_color + glow_color);
	} 
	else {
		COLOR = current_color;
	}
}
