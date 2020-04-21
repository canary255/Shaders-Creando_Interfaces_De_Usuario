#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.x/u_resolution;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 color = vec3(2.5);
    color = vec3(st.x,st.y,abs(sin(u_time)));
    color.r;

    gl_FragColor = vec4(color,1.0);
}