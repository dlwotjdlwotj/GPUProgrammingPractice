#version 410 core

layout(location=0) in vec3 in_Position;
layout(location=1) in vec2 in_TexCoord;
layout(location=2) in vec3 in_Normal;

out vec2 texCoord;
out vec3 normal;
flat out vec3 color;

uniform mat4 viewMat = mat4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,-3,1);
uniform mat4 projMat = mat4(1.299038, 0, 0, 0, 0, 1.732051, 0, 0, 0, 0, -1.002002, -1.0, 0, 0, -0.2002, 0);
uniform mat4 modelMat = mat4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1);

uniform mat3 transform;

vec3 lightDir = {1, 2, 3};

vec2 p2;

// transform matrix에 기존 벡터 p2를 곱해 transform(resize, rotate 등)을 함
void transformByMatrix(){
	vec3 p = transform*vec3(p2, 1.0);
	p2=p.xy;
}

vec4 getWorldPos(vec4 p4){
	return projMat*viewMat*modelMat*p4;
}

vec3 getNormal(){
	return (modelMat * vec4(in_Normal, 0.0)).xyz;
}

void main(void) {
	gl_Position = getWorldPos(vec4(in_Position, 1.0));
	texCoord = in_TexCoord;
	normal = getNormal();

	color = vec3(0.7f, 1.0f, 0.0f);
	color *= dot(lightDir, normal);
}