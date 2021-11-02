shader_type canvas_item;
render_mode blend_mix;

uniform float speed = 1f;
uniform float minStrength: hint_range(0f, 1f) = .05;
uniform float maxStrength: hint_range(0f, 1f) = .01;
uniform float strengthScale = 100f;
uniform float interval = 3.5;
uniform float detail = 1f;
uniform float distortion: hint_range(0f, 1f);
uniform float hightOffset: hint_range(0f, 1f);

uniform float offset = 0f;

float getWind(vec2 vertex, vec2 uv, float time) {
    float diff = pow(maxStrength - minStrength, 2f);
    float strength = clamp(minStrength + diff + sin(time / interval) * diff, minStrength, maxStrength) * strengthScale;
    float wind = (sin(time) + cos(time * detail)) * strength * max(0f, (1f-uv.y) - hightOffset);
    
    return wind;
   }

void vertex() {
    vec4 pos = WORLD_MATRIX * vec4(0f, 0f, 0f, 1f);
    float time = TIME * speed + offset;
    VERTEX.x += getWind(VERTEX.xy, UV, time);
   }
