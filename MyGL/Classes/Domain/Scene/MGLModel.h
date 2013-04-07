//
//  MGLModel.h
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GLKit/GLKit.h>

@protocol MGLModel <NSObject>

- (void) setup;
- (void) draw;
- (void) destroy;

- (void) setProjectionMatrix: (GLKMatrix4) matrix;
- (void) setModelMatrix: (GLKMatrix4) matrix;
- (void) setNormalMatrix: (GLKMatrix3) matrix;

@end
