//
//  Shader.fsh
//  ittgame
//
//  Created by shaofa on 14-1-8.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
