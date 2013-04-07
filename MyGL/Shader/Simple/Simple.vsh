//attribute vec4 Position;
//attribute vec4 SourceColor;

varying vec4 DestinationColor;

uniform mat4 Projection;
uniform mat4 Modelview;

void main(void) {
    DestinationColor = gl_Color;
    gl_Position = Projection * Modelview * gl_Vertex;
}