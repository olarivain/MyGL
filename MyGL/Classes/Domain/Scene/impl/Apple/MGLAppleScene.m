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
	GLKMatrix4 _projectionMatrix;
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
	self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
	self.effect.light0.ambientColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
	
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
	float aspect = fabsf(_viewportFrame.size.width / _viewportFrame.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
	
	self.effect.transform.projectionMatrix = _projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
	
	_rotation += timeSinceLastUpdate * 0.5f;
}

- (void) draw {

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	// Render the object with GLKit
    [self.effect prepareToDraw];
	
	for(id<MGLModel> model in _models) {
		[model draw];
//		glUseProgram(0);
	}

}

@end
