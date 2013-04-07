//
//  MGLAppleSample.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import <GLKit/GLKit.h>

#import "MGLCubeModel.h"

#import "MGLShaderProgram.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

GLfloat vertices[360] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 0.0f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 1.0f
};

GLubyte indices[36];

static MGLShaderProgram *shader;

static GLuint _vertexBuffer;
static GLuint _indexBuffer;
static GLuint _mvpMatrixSlot;
static GLuint _normalMatrixSlot;

@interface MGLCubeModel () {
}

@end

@implementation MGLCubeModel

- (void) setup {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self loadProgram];
		[self loadModel];
	});
}

- (void) loadProgram {
	shader = [MGLShaderProgram programWithVertex: @"Shader"
								  fragmentShader: @"Shader"];
	[shader compile];
	
	_mvpMatrixSlot = glGetUniformLocation(shader.program, "mvpMatrix");
	_normalMatrixSlot = glGetUniformLocation(shader.program, "normalMatrix");

}

- (void) loadModel {
	
	glGenBuffers(1, &_vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glEnableVertexAttribArray(GLKVertexAttribNormal);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), 0);
	glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (3 * sizeof(GLfloat)));
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (6 * sizeof(GLfloat)));
	
	for(int i = 0; i < sizeof(indices); i++) {
		indices[i] = (GLubyte) i;
	}
	
	glGenBuffers(1, &_indexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
}

- (void) destroy {
	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteBuffers(1, &_indexBuffer);
}

- (void) draw {
	
	glUseProgram(shader.program);
	GLKMatrix4 mvpMatrix = GLKMatrix4Multiply(_projectionMatrix, _modelMatrix);
    glUniformMatrix4fv(_mvpMatrixSlot, 1, 0, mvpMatrix.m);
	glUniformMatrix3fv(_normalMatrixSlot, 1, 0, _normalMatrix.m);
	
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	
	glDrawElements(GL_TRIANGLES,  sizeof(indices) / sizeof(indices[0]), GL_UNSIGNED_BYTE, 0);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glUseProgram(0);
}

@end
