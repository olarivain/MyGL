//
//  MGLSceneViewController.h
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MGLScene.h"

@interface MGLView : UIView

@property (nonatomic) id<MGLScene> scene;

- (void)render: (CADisplayLink *) displayLink;

@end
