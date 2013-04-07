//
//  MGLAppleSample.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import <GLKit/GLKit.h>

#import "MGLAppleModel.h"

#import "MGLShaderProgram.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

GLfloat gCubeVertexData[360] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 0.0f, 0.5f
};

@interface MGLAppleModel () {
    GLuint _vertexBuffer;
	GLuint _indexBuffer;
	
	GLuint *_indices;
	
	GLuint _projectionMatrixSlot;
	GLuint _modelMatrixSlot;
	GLuint _normalMatrixSlot;
}
@property (strong, nonatomic) MGLShaderProgram *program;
@end

@implementation MGLAppleModel

- (void) setup {
	self.program = [MGLShaderProgram programWithVertex: @"Shader"
									   fragmentShader: @"Shader"];
	[self.program compile];
    
	glUseProgram(self.program.program);
	_projectionMatrixSlot = glGetUniformLocation(self.program.program, "projectionMatrix");
	_modelMatrixSlot = glGetUniformLocation(self.program.program, "modelMatrix");
	_normalMatrixSlot = glGetUniformLocation(self.program.program, "normalMatrix");
	glUseProgram(0);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), 0);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (3 * sizeof(GLfloat)));
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (6 * sizeof(GLfloat)));
	
	_indices = malloc(36 * sizeof(GLuint));

	for(int i = 0; i < 36; i++) {
		_indices[i] = i;
	}
	
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, 36 * sizeof(GLuint), _indices, GL_STATIC_DRAW);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);

}

- (void) destroy {
	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteBuffers(1, &_indexBuffer);
	free(_indices);
}

- (void) update {
}

- (void) draw {
	glUseProgram(self.program.program);
	
	glUniformMatrix4fv(_projectionMatrixSlot, 1, 0, _projectionMatrix.m);
	glUniformMatrix4fv(_modelMatrixSlot, 1, 0, _modelMatrix.m);
    glUniformMatrix3fv(_normalMatrixSlot, 1, 0, _normalMatrix.m);
	
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	
	glDrawElements(GL_TRIANGLES,  36, GL_UNSIGNED_INT, 0);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glUseProgram(0);
}

@end
