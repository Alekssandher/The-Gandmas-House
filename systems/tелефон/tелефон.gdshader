shader_type spatial;

uniform sampler2D my_texture;

void fragment() {
    vec2 uv = FRAGCOORD.xy / VIEWPORT_SIZE;
    vec4 tex_color = texture(my_texture, uv);
    ALBEDO = tex_color.rgb;
    ALPHA = tex_color.a;
}
