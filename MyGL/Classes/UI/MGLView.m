//
//  MGLSceneViewController.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>

#import "MGLView.h"

@interface MGLView () {
	CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
	GLuint _framebuffer;
    GLuint _colorRenderBuffer;
	GLuint _depthRenderBuffer;
}

@end

@implementation MGLView

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
		[self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder: aDecoder];
    if (self) {
        [self setupLayer];
        [self setupContext];
		[self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
    }
    return self;
}

- (void) layoutSubviews {

	[_scene setViewportFrame: self.bounds];
}

#pragma mark - Setting up the context
- (void)setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

- (void)setupContext {
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
	
    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupDepthBuffer {
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
}

- (void)setupFrameBuffer {
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
	
	glEnable(GL_DEPTH_TEST);
	glViewport(0, 0, self.bounds.size.width, self.bounds.size.height);
	
//	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
//	glEnable(GL_BLEND);
}

- (void)render: (CADisplayLink *) displayLink {
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	[_scene update: displayLink.duration];
	[_scene draw];
	
	const GLenum discards[]  = {GL_DEPTH_ATTACHMENT};
	glDiscardFramebufferEXT(GL_FRAMEBUFFER, 1, discards);

    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
