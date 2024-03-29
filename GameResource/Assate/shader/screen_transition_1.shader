shader_type canvas_item;

uniform float progress: hint_range(0, 1);
uniform float dimoundPixelSize = 10f;

void fragment() {
	float xFraction = fract(FRAGCOORD.x / dimoundPixelSize);
	float yFraction = fract(FRAGCOORD.y / dimoundPixelSize);
	
	float xDistance = abs(xFraction - 0.5);
	float yDistance = abs(yFraction - 0.5);
	
	if (xDistance + yDistance + UV.x + UV.y > progress * 4f) {
		discard;
	}
}