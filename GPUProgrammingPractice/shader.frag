#version 150 core

in vec2 texCoord;
in vec3 normal;
in vec3 color;

out vec4 out_Color;

const float scale = 20.0;

void main(void)
{
	out_Color = vec4(color, 1.0);
}