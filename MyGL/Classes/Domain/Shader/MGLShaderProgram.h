//
//  MGLShaderProgram.h
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGLShaderProgram : NSObject

@property (nonatomic, readonly) GLuint program;

+ (MGLShaderProgram *) programWithVertex: (NSString *) vertexShader fragmentShader: (NSString *) fragmentShader;
- (BOOL) compile;

- (void) tearDown;

@end
