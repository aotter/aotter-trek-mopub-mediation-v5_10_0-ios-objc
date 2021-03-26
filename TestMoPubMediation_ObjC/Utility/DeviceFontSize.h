//
//  DeviceFontSize.h
//  Aotter_pnn6ios
//
//  Created by 鄒明智 on 2019/11/29.
//  Copyright © 2019 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceFontSize : NSObject
+(UIFont *)setPostTitleFontForiPad;
+(UIFont *)setPostTitleFontForiPhone;

+(UIFont *)setPostSummaryFontForiPad;
+(UIFont *)setPostSummaryFontForiPhone;

+(UIFont *)setPostInfoFontForiPad;
+(UIFont *)setPostInfoFontForiPhone;

+(UIFont *)setPostInfoDateFontForiPad;
+(UIFont *)setPostInfoDateFontForiPhone;
@end

NS_ASSUME_NONNULL_END
