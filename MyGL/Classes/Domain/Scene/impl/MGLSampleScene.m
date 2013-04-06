//
//  MGLSampleScene.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLSampleScene.h"

#import "MGLAppleModel.h"

@interface MGLSampleScene () {
	float _rotation;
	GLKMatrix4 _projectionMatrix;
}
@property (nonatomic) NSMutableArray *models;
@end

@implementation MGLSampleScene

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
- (void) update {
	float aspect = fabsf(_viewportFrame.size.width / _viewportFrame.size.height);
    _projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
	
	for(id<MGLModel> model in _models) {
		[model setProjectionMatrix: _projectionMatrix];
	}
}


@end
