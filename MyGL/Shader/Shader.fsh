//
//  Shader.fsh
//  MyGL
//
//  Created by Olivier Larivain on 4/6/13.
//  Copyright (c) 2013 kra. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
