//
//  DeviceFontSize.m
//  Aotter_pnn6ios
//
//  Created by 鄒明智 on 2019/11/29.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import "DeviceFontSize.h"

@implementation DeviceFontSize

+(UIFont *)setPostTitleFontForiPad {
    return [UIFont systemFontOfSize:23];
}

+(UIFont *)setPostTitleFontForiPhone {
    return [UIFont systemFontOfSize:15];
}

+(UIFont *)setPostSummaryFontForiPad {
    return [UIFont systemFontOfSize:18];
}

+(UIFont *)setPostSummaryFontForiPhone {
    return [UIFont systemFontOfSize:12];
}

+(UIFont *)setPostInfoFontForiPad {
    return [UIFont systemFontOfSize:18];
}

+(UIFont *)setPostInfoFontForiPhone {
    return [UIFont systemFontOfSize:12];
}

+(UIFont *)setPostInfoDateFontForiPad {
    return [UIFont systemFontOfSize:18];
}

+(UIFont *)setPostInfoDateFontForiPhone {
    return [UIFont systemFontOfSize:12];
}

@end
