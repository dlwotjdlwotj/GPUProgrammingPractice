#version 410 core

layout(location=0) in vec3 in_Position;
layout(location=1) in vec2 in_TexCoord;
layout(location=2) in vec3 in_Normal;

out vec2 texCoord;
out vec3 normal;
out vec3 color;

uniform mat4 viewMat = mat4(1,0,0,0,0,1,0,0,0,0,1,0,0,0,-3,1);
uniform mat4 projMat = mat4(1.299038, 0, 0, 0, 0, 1.732051, 0, 0, 0, 0, -1.002002, -1.0, 0, 0, -0.2002, 0);
uniform mat4 modelMat = mat4(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1);

uniform mat3 transform;

uniform vec3 cameraPos;

vec3 lightDir = {1, 2, 3};

//light intensity
vec3 La = vec3(0.3, 0.3, 0.1);
vec3 Ld = vec3(1.0, 1.0, 0.3);
vec3 Ls = vec3(1.0, 1.0, 0.5);

//reflectivity
vec3 Ka = vec3(1.0, 1.0, 0.6);
vec3 Kd = vec3(1.0, 1.0, 0.3);
vec3 Ks = vec3(0.4, 0.4, 0.2);

//shininess
float shininess = 32.0;

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
	return normalize((modelMat * vec4(in_Normal, 0.0)).xyz);
}

//gouraud shading
vec3 ambient(){
	return La * Ka;
}

vec3 diffuse(){
	return dot(lightDir, normal) * Ld * Kd;
}

vec3 specular(){
	vec3 fragPos = (modelMat * vec4(in_Position, 1.0)).xyz;
	vec3 viewDir = normalize(cameraPos - fragPos);
	vec3 r = reflect(-lightDir, normal);
	float f = pow(max(dot(r, viewDir), 0), shininess);
	return f * Ls * Ks;
}

vec3 gouraud(){
	return ambient() + diffuse() + specular();
}

void main(void) {
	gl_Position = getWorldPos(vec4(in_Position, 1.0));
	texCoord = in_TexCoord;
	normal = getNormal();

	//gouraud shading
	lightDir = normalize(lightDir);
	vec3 I = gouraud();
	color = I * vec3(1.0f, 1.0f, 0.0f);
}