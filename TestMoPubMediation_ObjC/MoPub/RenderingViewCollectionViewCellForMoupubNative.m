//
//  RenderingViewCollectionViewCellForMoupubNative.m
//  Aotter_pnn6ios
//
//  Created by Aotter on 2016/12/23.
//  Copyright © 2016年 Aotter. All rights reserved.
//

#import "RenderingViewCollectionViewCellForMoupubNative.h"
#import "MPNativeAdRendering.h"
#import "MPNativeAdRenderingImageLoader.h"
#import "DeviceFontSize.h"

@interface RenderingViewCollectionViewCellForMoupubNative()<MPNativeAdRendering>

@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelSummary;
@property (strong, nonatomic) UILabel *labelInfo;
@property (strong, nonatomic) UIImageView *iconImageView;

@end


@implementation RenderingViewCollectionViewCellForMoupubNative

- (void)layoutSubviews
{
    [super layoutSubviews];
    // layout your views
}

- (UILabel *)nativeMainTextLabel
{
    return self.labelSummary;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.labelTitle;
}

- (UILabel *)nativeCallToActionTextLabel
{
    return nil;
}

- (UIImageView *)nativeIconImageView
{
    return self.iconImageView;
}

- (UIImageView *)nativeMainImageView
{
    return nil;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return  nil;
}


-(void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader{
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelSummary = [[UILabel alloc] init];
    self.labelInfo = [[UILabel alloc] init];
    self.iconImageView = [[UIImageView alloc] init];
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelSummary setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelInfo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    [self.labelTitle setTextColor:[UIColor colorWithRed:63/255.0f
                                                  green:63/255.0f
                                                   blue:63/255.0f
                                                  alpha:1.0f]];
    
    [self.labelSummary setTextColor:[UIColor colorWithRed:170/255.0f
                                                    green:170/255.0f
                                                     blue:170/255.0f
                                                    alpha:1.0f]];
    
    [self.labelInfo setTextColor:[UIColor colorWithRed:150/255.0f
                                                 green:150/255.0f
                                                  blue:150/255.0f
                                                 alpha:1.0f]];
    
    [self.labelTitle setNumberOfLines:2];
    [self.labelSummary setNumberOfLines:2];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        self.labelTitle.font = [DeviceFontSize setPostTitleFontForiPad];
        self.labelSummary.font = [DeviceFontSize setPostSummaryFontForiPad];
        self.labelInfo.font = [DeviceFontSize setPostInfoFontForiPad];
    }
    else{
        self.labelTitle.font = [DeviceFontSize setPostTitleFontForiPhone];
        self.labelSummary.font = [DeviceFontSize setPostSummaryFontForiPhone];
        self.labelInfo.font = [DeviceFontSize setPostInfoFontForiPhone];
    }
    
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSummary];
    [self addSubview:self.labelInfo];
    [self addSubview:self.iconImageView];

    NSDictionary *views = @{@"labelTitle": self.labelTitle,
                            @"labelSummary": self.labelSummary,
                            @"labelInfo": self.labelInfo,
                            @"iconImageView": self.iconImageView
                            };
    NSArray *constraits = @[];
    constraits = [constraits arrayByAddingObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[iconImageView]-4-|" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[iconImageView]-6-[labelTitle]-6-[labelSummary]-(>=0)-[labelInfo]-5-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:constraits];
    
    NSLog(@"[RenderingView CollectionViewCell for MopubNativeAd] layoutCustomAssetsWithProperties: %@", customProperties);
    NSString *titleString = customProperties[@"title"];
    NSString *textString = customProperties[@"text"];
    NSString *iconImage = customProperties[@"iconimage"];
    NSString *advertiserName = customProperties[@"advertiserName"];
    
    self.backgroundColor = [UIColor whiteColor];
    self.labelTitle.text = titleString;
    self.labelSummary.text = textString;
    if(advertiserName && [advertiserName length]>0){
        self.labelInfo.text = [NSString stringWithFormat:@"Sponsored | %@", advertiserName];
    }
    else{
        self.labelInfo.text = [NSString stringWithFormat:@"Sponsored"];
    }
    [imageLoader loadImageForURL:[NSURL URLWithString:iconImage] intoImageView:self.iconImageView];
}


@end
