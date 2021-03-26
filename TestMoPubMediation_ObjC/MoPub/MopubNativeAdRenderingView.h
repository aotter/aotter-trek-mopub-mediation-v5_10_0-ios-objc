//
//  YourNativeAdView.h
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/7.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MopubNativeAdRenderingView : UIView
- (void)layoutSubviews;
- (UILabel *)nativeMainTextLabel;
- (UILabel *)nativeTitleTextLabel;
- (UILabel *)nativeCallToActionTextLabel;
- (UIImageView *)nativeIconImageView;
- (UIImageView *)nativeMainImageView;
- (UIImageView *)nativePrivacyInformationIconImageView;
@end
