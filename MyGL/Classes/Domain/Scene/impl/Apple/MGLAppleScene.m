//
//  MGLSampleScene.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLAppleScene.h"

#import "MGLAppleModel.h"

@interface MGLAppleScene () {
	float _rotation;
}

@property (strong, nonatomic) GLKBaseEffect *effect;
@property (nonatomic) NSMutableArray *models;

@end

@implementation MGLAppleScene

- (id) init {
	self = [super init];
	if(self) {
		self.models = [NSMutableArray arrayWithCapacity: 5];
	}
	return self;
}

#pragma mark - scene setup
- (void) setup {
	[self createModels];
	
	for(id<MGLModel> model in _models) {
		[model setup];
	}
	
	glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
}

- (void) createModels {
	MGLAppleModel *appleModel = [[MGLAppleModel alloc] init];
	[self.models addObject: appleModel];
}

#pragma mark - scene destruction
- (void) destroy {
	for(id<MGLModel> model in self.models) {
		[model destroy];
	}
}

#pragma mark - updating the scene
- (void) update: (NSTimeInterval) timeSinceLastUpdate {
	// camera position: slightly in, by 4
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    
    // Compute the model view matrix for the object rendered with
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
	
	self.effect.transform.modelviewMatrix = modelViewMatrix;
	
	// compute the normal matrix
    GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);

	// and the projection one
	float aspect = fabsf(_viewportFrame.size.width / _viewportFrame.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
	self.effect.transform.projectionMatrix = projectionMatrix;
	
	for(id<MGLModel> model in _models) {
		[model setProjectionMatrix: projectionMatrix];
		[model setModelMatrix: modelViewMatrix];
		[model setNormalMatrix: normalMatrix];
	}
	

	
	_rotation += timeSinceLastUpdate * 1.0f;
}

- (void) draw {
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	// Render the object with GLKit
//    [self.effect prepareToDraw];
	
	for(id<MGLModel> model in _models) {
		[model draw];
		glUseProgram(0);
	}

	const GLenum discards[]  = {GL_DEPTH_ATTACHMENT, GL_COLOR_ATTACHMENT0};
	
	glDiscardFramebufferEXT(GL_FRAMEBUFFER, 2, discards);
}

@end
