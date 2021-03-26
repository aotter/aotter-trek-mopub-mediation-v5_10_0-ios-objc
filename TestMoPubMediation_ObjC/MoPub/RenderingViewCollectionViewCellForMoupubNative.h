//
//  RenderingViewCollectionViewCellForMoupubNative.h
//  Aotter_pnn6ios
//
//  Created by Aotter on 2016/12/23.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RenderingViewCollectionViewCellForMoupubNative : UIView
- (void)layoutSubviews;
- (UILabel *)nativeMainTextLabel;
- (UILabel *)nativeTitleTextLabel;
- (UILabel *)nativeCallToActionTextLabel;
- (UIImageView *)nativeIconImageView;
- (UIImageView *)nativeMainImageView;
- (UIImageView *)nativePrivacyInformationIconImageView;
@end
