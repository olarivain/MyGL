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
	GLuint _vertexArray;
    GLuint _vertexBuffer;
	
	GLuint _modelViewProjectionMatrixSlot;
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
	_modelViewProjectionMatrixSlot = glGetUniformLocation(self.program.program, "modelViewProjectionMatrix");
	_normalMatrixSlot = glGetUniformLocation(self.program.program, "normalMatrix");
	glUseProgram(0);
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
	
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), 0);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (3 * sizeof(GLfloat)));
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, (GLsizei) (10 * sizeof(float)), (GLvoid *) (6 * sizeof(GLfloat)));
    
    glBindVertexArrayOES(0);

}

- (void) destroy {
	glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
}

- (void) update {
}

- (void) draw {
	glUseProgram(self.program.program);
	
	glBindVertexArrayOES(_vertexArray);
	
	GLKMatrix4 modelViewProjection = GLKMatrix4Multiply(_projectionMatrix, _modelMatrix);
	glUniformMatrix4fv(_modelViewProjectionMatrixSlot, 1, 0, modelViewProjection.m);
    glUniformMatrix3fv(_normalMatrixSlot, 1, 0, _normalMatrix.m);

    glDrawArrays(GL_TRIANGLES, 0, 36);
	
	glBindVertexArrayOES(0);
}

@end
