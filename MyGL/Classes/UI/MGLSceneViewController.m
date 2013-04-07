//
//  MGLSceneViewController.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#import "MGLSceneViewController.h"

#import "MGLAppleScene.h"
#import "MGLWenderlichScene.h"

#import "MGLView.h"

@interface MGLSceneViewController ()

@property (weak, nonatomic) IBOutlet MGLView *glView;
@property (strong, nonatomic) id<MGLScene> scene;

@end

@implementation MGLSceneViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//	self.scene = [[MGLWenderlichScene alloc] init];
	self.scene = [[MGLAppleScene alloc] init];
	[self.scene setup];
	
	self.glView.scene = self.scene;
	[self setupDisplayLink];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

// Add new method before init
- (void)setupDisplayLink {
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)render:(CADisplayLink*)displayLink {

	[_glView render: displayLink];
}

@end
