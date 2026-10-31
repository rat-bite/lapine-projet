#version 330
#extension GL_ARB_separate_shader_objects : require

#include <minecraft:fog.glsl>

layout(location = 0) in float sphericalVertexDistance;
layout(location = 1) in float cylindricalVertexDistance;
layout(location = 2) flat in vec4 vertexColor;

layout(location = 0) out vec4 fragColor;

void main() {
    // La corde de laisse est dessinee avec une couleur marron codee en dur
    // (0.5, 0.4, 0.3), sans texture. On garde l'ombrage du lightmap mais on
    // ramene la teinte vers le noir pour coller au noeud et a l'objet.
    float l = dot(vertexColor.rgb, vec3(0.299, 0.587, 0.114));
    float k = mix(0.035, 0.115, clamp(l * 2.5, 0.0, 1.0));
    vec4 color = vec4(vec3(k), vertexColor.a);

    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
