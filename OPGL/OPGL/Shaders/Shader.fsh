//
//  Shader.fsh
//  OPGL
//
//  Created by sfwan on 14-8-21.
//  Copyright (c) 2014年 sfwan. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
