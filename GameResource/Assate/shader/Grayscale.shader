shader_type canvas_item;

uniform bool on = false;

void fragment() {
    vec4 output = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    if(on) {
        output.rgb = vec3(output.r + output.g + output.b) / 3f;
    }
    
    COLOR = output;
}
