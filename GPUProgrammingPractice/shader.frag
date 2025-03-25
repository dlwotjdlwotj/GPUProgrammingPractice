#version 150 core

in vec3 normal;

in vec3 viewDir;

out vec4 out_Color;

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

//Blinn-Phong shading
vec3 ambient(){
	return La * Ka;
}

vec3 diffuse(){
	return dot(lightDir, normal) * Ld * Kd;
}

vec3 specular(){
	vec3 h = normalize(lightDir + viewDir);
	float f = pow(max(dot(h, normal), 0), shininess);
	return f * Ls * Ks;
}

vec3 blinnPhong(){
	return ambient() + diffuse() + specular();
}

void main(void)
{
	lightDir = normalize(lightDir);
	vec3 I = blinnPhong();
	vec3 color = I * vec3(1.0f, 1.0f, 0.0f);

	out_Color = vec4(color, 1.0);
}
