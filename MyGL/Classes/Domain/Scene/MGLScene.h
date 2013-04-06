//
//  MGLScene.h
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGLScene <NSObject>

- (void) setup;
- (void) update;
- (void) draw;
- (void) destroy;

- (void) setViewportFrame: (CGRect *) frame;

@end
