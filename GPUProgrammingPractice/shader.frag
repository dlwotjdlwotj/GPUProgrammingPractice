#version 150 core

in vec3 normal;
in vec3 color;

out vec4 out_Color;

void main(void)
{
	out_Color = vec4(color, 1.0);
}
