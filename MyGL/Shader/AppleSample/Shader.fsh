//
//  Shader.fsh
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

varying lowp vec4 colorVarying;
varying lowp vec2 texCoordOut;

uniform sampler2D texture;

void main(void) {
    gl_FragColor = colorVarying * texture2D(texture, texCoordOut);
}
