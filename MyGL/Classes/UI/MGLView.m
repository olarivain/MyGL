//
//  MGLSceneViewController.m
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>

#include <GLKit/GLKit.h>
#import "MGLView.h"

@interface MGLView () {
	CAEAGLLayer* _eaglLayer;
    EAGLContext* _context;
	GLuint _framebuffer;
    GLuint _colorRenderBuffer;
	GLuint _depthRenderBuffer;
	
	//Buffer definitions for the MSAA
	GLuint _msaaFramebuffer;
	GLuint _msaaRenderBuffer;
	GLuint _msaaDepthBuffer;
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
		[self sharedInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder: aDecoder];
    if (self) {
		
		[self sharedInit];
    }
    return self;
}

- (void) sharedInit {
	[self setupLayer];
	[self setupContext];
}

- (void) layoutSubviews {
	[self destroyBuffer];
	[self createBuffer];
	
	[_scene setViewportFrame: self.bounds];
}

#pragma mark - Setting up the context
- (void)setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
	_eaglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @NO};
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

- (void) destroyBuffer {
	glDeleteFramebuffersOES(1, &_framebuffer);
    _framebuffer = 0;
    glDeleteRenderbuffersOES(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
	
    if(_depthRenderBuffer)
    {
        glDeleteRenderbuffersOES(1, &_depthRenderBuffer);
        _depthRenderBuffer = 0;
    }
}


- (void)createBuffer {
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER_OES, _depthRenderBuffer);
//	glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_DEPTH_COMPONENT16, self.bounds.size.width, self.bounds.size.height);
	glRenderbufferStorage(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, self.bounds.size.width, self.bounds.size.height);


	// color
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER_OES, _colorRenderBuffer);
//	glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_RGBA8_OES, self.bounds.size.width, self.bounds.size.height);
	[_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:_eaglLayer];

	
	// framebuffer
    glGenFramebuffers(1, &_framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER_OES, _framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, _colorRenderBuffer);
	glFramebufferRenderbuffer(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, _depthRenderBuffer);
	
//	// msaa
//	glGenRenderbuffers(1, &_msaaDepthBuffer);
//    glBindRenderbuffer(GL_RENDERBUFFER_OES, _msaaDepthBuffer);
//	glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_DEPTH_COMPONENT16, self.bounds.size.width, self.bounds.size.height);
//	//	glRenderbufferStorage(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, self.bounds.size.width, self.bounds.size.height);
//	
//	
//	// color
//    glGenRenderbuffers(1, &_msaaRenderBuffer);
//    glBindRenderbuffer(GL_RENDERBUFFER_OES, _msaaRenderBuffer);
//	glRenderbufferStorageMultisampleAPPLE(GL_RENDERBUFFER, 4, GL_RGBA8_OES, self.bounds.size.width, self.bounds.size.height);
//	//	[_context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:_eaglLayer];
//	
//	
//	// framebuffer
//    glGenFramebuffers(1, &_msaaRenderBuffer);
//    glBindFramebuffer(GL_FRAMEBUFFER_OES, _msaaRenderBuffer);
//    glFramebufferRenderbuffer(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, _msaaRenderBuffer);
//	glFramebufferRenderbuffer(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, _msaaDepthBuffer);
	
	glEnable(GL_DEPTH_TEST);
	glViewport(0, 0, self.bounds.size.width, self.bounds.size.height);
	
	//	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	//	glEnable(GL_BLEND);
}

- (void)render: (CADisplayLink *) displayLink {
	glBindFramebuffer(GL_FRAMEBUFFER, _framebuffer);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	[_scene update: displayLink.duration];
	[_scene draw];
	
//	glBindFramebufferOES(GL_READ_FRAMEBUFFER_APPLE, _msaaFramebuffer);
	glBindFramebufferOES(GL_DRAW_FRAMEBUFFER_APPLE, _framebuffer);
//	glResolveMultisampleFramebufferAPPLE();
	
	const GLenum discards[]  = {GL_DEPTH_ATTACHMENT};
	glDiscardFramebufferEXT(GL_FRAMEBUFFER, 1, discards);
	glDiscardFramebufferEXT(GL_READ_FRAMEBUFFER_APPLE,2,discards);
	
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

@end
