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
//	vec4(colorVarying.r, colorVarying.g, colorVarying.b, 1.0);
//	if (colorVarying.a < 0.7) {
//		gl_FragColor.a = 0.5;	
//	}
	
}
