//
//  MGLWenderlichModel.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLWenderlichModel.h"


#import "MGLShaderProgram.h"

typedef struct {
    float Position[3];
    float Color[4];
} Vertex;

const Vertex Vertices[] = {
    {{1, -1, 0}, {1, 0, 0, 1}},
    {{1, 1, 0}, {0, 1, 0, 1}},
    {{-1, 1, 0}, {0, 0, 1, 1}},
    {{-1, -1, 0}, {0, 0, 0, 1}}
};

const GLubyte Indices[] = {
	0, 1, 2,
	2, 3, 0
};

@interface MGLWenderlichModel ()
@property (nonatomic) MGLShaderProgram *shader;
@property (nonatomic) GLuint positionSlot;
@property (nonatomic) GLuint colorSlot;
@property (nonatomic) GLuint projectionUniform;
@property (nonatomic) GLuint modelViewUniform;
@end

@implementation MGLWenderlichModel

- (void) setup {
	self.shader = [MGLShaderProgram programWithVertex: @"Simple" fragmentShader: @"Simple"];
	[self.shader compile];
	
    glUseProgram(self.shader.program);
//	self.positionSlot = glGetAttribLocation(self.shader.program, "Position");
//    self.colorSlot = glGetAttribLocation(self.shader.program, "SourceColor");
	self.projectionUniform = glGetUniformLocation(self.shader.program, "Projection");
	self.modelViewUniform = glGetUniformLocation(self.shader.program, "Modelview");
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribColor);
	
    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
	
    GLuint indexBuffer;
    glGenBuffers(1, &indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
}

- (void) destroy {
}

- (void) update {
	
}

- (void) draw {
	glUseProgram(self.shader.program);
	glUniformMatrix4fv(_projectionUniform, 1, 0, self.projectionMatrix.m);
	glUniformMatrix4fv(_modelViewUniform, 1, 0, self.modelMatrix.m);
	
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
	
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
}

@end
