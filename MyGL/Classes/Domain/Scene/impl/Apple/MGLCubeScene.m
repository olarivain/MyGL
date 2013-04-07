//
//  MGLSampleScene.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLCubeScene.h"

#import "MGLCubeModel.h"

@interface MGLCubeScene () {
	GLKMatrix4 _projectionMatrix;
	GLKMatrix4 _baseModelViewMatrix;
	float _rotation;
}

@property (nonatomic) NSMutableArray *models;

@end

@implementation MGLCubeScene

- (id) init {
	self = [super init];
	if(self) {
		self.models = [NSMutableArray arrayWithCapacity: 5];
	}
	return self;
}

- (void) setViewportFrame:(CGRect)viewportFrame {
	_viewportFrame = viewportFrame;
	// and the projection one
	float aspect = fabsf(_viewportFrame.size.width / _viewportFrame.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 300.0f);
	
	for(id<MGLModel> model in _models) {
		[model setProjectionMatrix: _projectionMatrix];
	}
}

#pragma mark - scene setup
- (void) setup {
	[self createModels];
	
	_baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
	_baseModelViewMatrix = GLKMatrix4Rotate(_baseModelViewMatrix, -M_PI_4 / 2.0f, 1.0f, 0.0f, 0.0f);
	
	for(id<MGLModel> model in _models) {
		[model setup];
	}
	
	glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
}

- (void) createModels {
	for(int i = 0; i < 5; i++) {
		MGLCubeModel *appleModel = [[MGLCubeModel alloc] init];
		[self.models addObject: appleModel];
	}
}

#pragma mark - scene destruction
- (void) destroy {
	for(id<MGLModel> model in self.models) {
		[model destroy];
	}
}

#pragma mark - updating the scene
- (void) update: (NSTimeInterval) timeSinceLastUpdate {
	_baseModelViewMatrix = GLKMatrix4Rotate(_baseModelViewMatrix, -M_PI_4 / 100.0f, 1.0f, 0.0f, 0.0f);
	for(id<MGLModel> model in _models) {
		// Compute the model view matrix for the object rendered with
		GLKMatrix4 modelViewMatrix = GLKMatrix4Rotate(_baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
		modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 0.0f, 0.0f, -1.15f);
		[model setModelMatrix: modelViewMatrix];

		// compute the normal matrix
		GLKMatrix3 normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
		[model setNormalMatrix: normalMatrix];
		
		_rotation += (M_PI_4 / 1000.0f) + (2.0f * M_PI / _models.count);
	}
}

- (void) draw {
	for(id<MGLModel> model in _models) {
		[model draw];
	}
}

@end
