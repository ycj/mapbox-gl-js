#include "_prelude_fog.vertex.glsl"

uniform mat4 u_matrix;
uniform vec2 u_pixel_coord_upper;
uniform vec2 u_pixel_coord_lower;
uniform float u_tile_units_to_pixels;

attribute vec2 a_pos;

varying vec2 v_pos;

#pragma mapbox: define lowp float opacity
#pragma mapbox: define lowp vec4 pattern
#pragma mapbox: define lowp float pixel_ratio

void main() {
    #pragma mapbox: initialize lowp float opacity
    #pragma mapbox: initialize mediump vec4 pattern
    #pragma mapbox: initialize lowp float pixel_ratio

    vec2 pattern_tl = pattern.xy;
    vec2 pattern_br = pattern.zw;

    vec2 display_size = (pattern_br - pattern_tl) / pixel_ratio;
    gl_Position = u_matrix * vec4(a_pos, 0, 1);

    v_pos = get_pattern_pos(u_pixel_coord_upper, u_pixel_coord_lower, display_size, u_tile_units_to_pixels, a_pos);

#ifdef FOG
    v_fog_pos = fog_position(a_pos);
#endif
}
