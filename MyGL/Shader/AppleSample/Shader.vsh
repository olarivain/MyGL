//
//  Shader.vsh
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec4 color;
attribute vec2 texCoordIn;

uniform mat4 mvpMatrix;
uniform mat3 normalMatrix;

varying lowp vec4 colorVarying;
varying vec2 texCoordOut;

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    vec4 diffuseColor = vec4(1.0, 1.0, 1.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = diffuseColor * nDotVP * color;
    gl_Position = mvpMatrix * position;
	
	texCoordOut = texCoordIn;
	
	
}
