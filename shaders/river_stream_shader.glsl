uniform float uPosition;
uniform float uTime;
uniform vec2 uSize;
uniform vec4 uColorStart;
uniform vec4 uColorEnd;

out vec4 fragColor;

float simplex(vec2 st, float time, float position) {
    float pos1 = position + (0.04 * time) * sin((5 * st.y + (2 * time)) / (3 - 1.4 * time));
    float pos2 = position + 0.06 + (0.02 * time) + (0.05 + (0.05 * time)) * sin((5 * st.y + (2 * time)) / (3 - 1.2 * time));


    if (pos1 > st.x) {
        return 0.0;
    } else if (pos2 > st.x) {
        return (st.x - pos1) / (pos2 - pos1);
    } else {
        return 1.0;
    }
}

void main() {
    vec2 pixel = gl_FragCoord.xy / uSize;

    fragColor = mix(uColorStart, uColorEnd, simplex(pixel, uTime, uPosition));
}