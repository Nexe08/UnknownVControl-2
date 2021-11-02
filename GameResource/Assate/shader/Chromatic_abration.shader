shader_type canvas_item;

uniform sampler2D offset_image: hint_white;
uniform vec2 strength = vec2(0, 0);


void fragment() {
    vec4 output = texture(SCREEN_TEXTURE, SCREEN_UV);

    vec2 shift = vec2(strength.x * texture(offset_image, SCREEN_UV).r/100f,
                        strength.y * texture(offset_image, SCREEN_UV).r/100f);

    output.r = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x+shift.x, SCREEN_UV.y+shift.y)).r;
    output.g = texture(SCREEN_TEXTURE, SCREEN_UV).g;
    output.b = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x-shift.x, SCREEN_UV.y-shift.y)).b;
    COLOR = output;
}