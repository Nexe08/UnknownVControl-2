shader_type canvas_item;

uniform int pixel_size : hint_range(1, 100) = 1;

void fragment() {
	vec2 pos = UV / TEXTURE_PIXEL_SIZE;
	vec2 square = vec2(float(pixel_size), float(pixel_size));
	vec2 top_left = floor(pos / square) * square;
	vec4 totle = vec4(0f, 0f, 0f, 0f);
	for (int x = int(top_left.x); x < int(top_left.x) + pixel_size; x++) {
		for (int y = int(top_left.y); y < int(top_left.y) + pixel_size; y++) {
			totle += texture(TEXTURE, vec2(float(x), float(y)) * TEXTURE_PIXEL_SIZE);
		}
	}
	COLOR = totle / float(pixel_size * pixel_size);
}
