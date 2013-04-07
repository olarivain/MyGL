//
//  MGLWenderlichScene.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLWenderlichScene.h"

#import "MGLWenderlichModel.h"

@interface MGLWenderlichScene () {
	float _rotation;
	GLKMatrix4 _projectionMatrix;
	GLKMatrix4 _modelMatrix;
}

@property (nonatomic) NSMutableArray *models;

@end

@implementation MGLWenderlichScene

- (id) init {
	self = [super init];
	if(self) {
		self.models = [NSMutableArray arrayWithCapacity: 5];
	}
	return self;
}

#pragma mark - setup
- (void) setup {
	[self createModels];
	
	for(id<MGLModel> model in _models) {
		[model setup];
	}
	
	glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
}

- (void) createModels {
	MGLWenderlichModel *model = [[MGLWenderlichModel alloc] init];
	[self.models addObject: model];
}

#pragma mark - scene destruction
- (void) destroy {
	for(id<MGLModel> model in self.models) {
		[model destroy];
	}
}

#pragma mark - updating the scene
- (void) update: (NSTimeInterval) timeSinceLastUpdate {
	float aspect = fabsf(_viewportFrame.size.width / _viewportFrame.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
	
	GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
//    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
	
	// Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -7.0f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
	
	for(id<MGLModel> model in _models) {
		[model setProjectionMatrix: _projectionMatrix];
		[model setModelMatrix: modelViewMatrix];
		[model update];
	}
	
	_rotation += timeSinceLastUpdate * 0.5f;
}

#pragma mark - drawing
- (void) draw {
	
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	for(id<MGLModel> model in _models) {
		[model draw];
		glUseProgram(0);
	}
	
}

@end
