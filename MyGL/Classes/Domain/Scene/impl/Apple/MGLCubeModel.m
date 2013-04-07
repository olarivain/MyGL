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

#define TEX_COORD_MAX 4

GLfloat vertices[432] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,		red, green, blue, alpha,	texCoordX, texCoord,Y
	
	// right face
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, TEX_COORD_MAX,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, 0,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, 0,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    0.5f, 0.5f, 0.5f,          1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0,
    
	// top face
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, TEX_COORD_MAX,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, TEX_COORD_MAX,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, 0,
    
	// left face
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0, TEX_COORD_MAX,
    
	// bottom facce
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, TEX_COORD_MAX,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0,
    
	// front face
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, TEX_COORD_MAX,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, TEX_COORD_MAX,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0.0f,
    
	// back face
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, 0.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		TEX_COORD_MAX, TEX_COORD_MAX,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f,		1.0f, 1.0f, 1.0f, 1.0f,		0.0f, TEX_COORD_MAX
};

GLushort indices[36];

static MGLShaderProgram *shader;

static GLuint _vertexBuffer;
static GLuint _indexBuffer;
static GLuint _floorTexture;
static GLuint _fishTexture;

static GLuint _mvpMatrixSlot;
static GLuint _normalMatrixSlot;
static GLuint _texCoordSlot;
static GLuint _textureUniform;

@interface MGLCubeModel () {
}

@end

@implementation MGLCubeModel

#pragma mark - cleanup
- (void) destroy {
	glDeleteBuffers(1, &_vertexBuffer);
	glDeleteBuffers(1, &_indexBuffer);
}

#pragma mark - Setup
- (void) setup {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self loadProgram];
		[self loadTextures];
		[self loadModel];
	});
}

#pragma mark Shader
- (void) loadProgram {
	shader = [MGLShaderProgram programWithVertex: @"Shader"
								  fragmentShader: @"Shader"];
	[shader compile];
	
	_mvpMatrixSlot = glGetUniformLocation(shader.program, "mvpMatrix");
	_normalMatrixSlot = glGetUniformLocation(shader.program, "normalMatrix");
	_texCoordSlot = glGetAttribLocation(shader.program, "texCoordIn");
	_textureUniform = glGetUniformLocation(shader.program, "texture");

}

#pragma mark Textures
- (void) loadTextures {
	_floorTexture = [self setupTexture:@"tile_floor"];
	_fishTexture = [self setupTexture:@"item_powerup_fish"];
}

#pragma mark Model
- (void) loadModel {
	
	glGenBuffers(1, &_vertexBuffer);
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
	
	
	glEnableVertexAttribArray(GLKVertexAttribPosition);
	glEnableVertexAttribArray(GLKVertexAttribNormal);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glEnableVertexAttribArray(_texCoordSlot);
	
	GLsizei stride = (GLsizei) (12 * sizeof(float));
	glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, stride, 0);
	glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, stride, (GLvoid *) (3 * sizeof(GLfloat)));
	glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, stride, (GLvoid *) (6 * sizeof(GLfloat)));
	glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, stride, (GLvoid *) (10 * sizeof(GLfloat)));
	glActiveTexture(GL_TEXTURE0);
	
	for(int i = 0; i < sizeof(indices) / sizeof(indices[0]); i++) {
		indices[i] = (GLuint) i;
	}
	
	glGenBuffers(1, &_indexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
	
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
}

#pragma mark Texture
- (GLuint)setupTexture:(NSString *)fileName {
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
	
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
	
    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
	
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
													   CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
	
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    CGContextRelease(spriteContext);
	
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);
	glUniform1i(_textureUniform, 0);
	
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
	
    free(spriteData);
    return texName;
}

#pragma mark - Drawing
- (void) draw {
	glUseProgram(shader.program);
	GLKMatrix4 mvpMatrix = GLKMatrix4Multiply(_projectionMatrix, _modelMatrix);
    glUniformMatrix4fv(_mvpMatrixSlot, 1, 0, mvpMatrix.m);
	glUniformMatrix3fv(_normalMatrixSlot, 1, 0, _normalMatrix.m);

	
	glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
	glBindTexture(GL_TEXTURE_2D, _floorTexture);
	
	glDrawElements(GL_TRIANGLES,  sizeof(indices) / sizeof(indices[0]), GL_UNSIGNED_SHORT, 0);
	
	glBindTexture(GL_TEXTURE_2D, 0);
	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	
	glUseProgram(0);
}

@end
