//
//  MGLViewController.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import "MGLViewController.h"

#import "MGLAppleScene.h"
#import "MGLWenderlichScene.h"

@interface MGLViewController () {
}

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;
@property (strong, nonatomic) id<MGLScene> scene;

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation MGLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
//	self.scene = [[MGLWenderlichScene alloc] init];
	self.scene = [[MGLAppleScene alloc] init];
	[self.scene setup];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];

    self.effect = nil;
	[self.scene destroy];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
	[self.scene setViewportFrame: self.view.bounds];
	[self.scene update: self.timeSinceLastUpdate];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
	[self.scene draw];
}

@end
