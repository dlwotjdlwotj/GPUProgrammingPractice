#version 150 core

in vec2 texCoord;
in vec3 normal;
in vec3 color;

out vec4 out_Color;

const float scale = 20.0;

void main(void)
{
	bvec2 toDiscard = greaterThan(fract(texCoord * scale), vec2(0.1, 0.1));
	if(all(toDiscard)){
		discard;
	}
	else
		out_Color = vec4(color, 1.0);
}