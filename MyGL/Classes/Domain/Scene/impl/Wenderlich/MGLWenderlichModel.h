//
//  MGLWenderlichModel.h
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MGLModel.h"

@interface MGLWenderlichModel : NSObject<MGLModel>

@property GLKMatrix4 projectionMatrix;
@property GLKMatrix4 modelMatrix;

@end
