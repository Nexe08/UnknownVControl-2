shader_type canvas_item;
// https://godotforums.org/discussion/20251/how-to-attach-brightness-shader-to-root-viewport

uniform float brightness = 1f;
uniform float contrast = 1f;
uniform float seturation = 1f;

void fragment() {
    vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0f).rgb;
    c.rgb = mix(vec3(0f), c.rgb, brightness);
    c.rgb = mix(vec3(.5), c.rgb, contrast);
    c.rgb = mix(vec3(dot(vec3(1f), c.rgb)*.3333), c.rgb, seturation);
    
    COLOR.rgb = c;
}
