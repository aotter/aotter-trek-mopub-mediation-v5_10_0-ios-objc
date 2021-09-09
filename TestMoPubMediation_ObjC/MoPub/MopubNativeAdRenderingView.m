//
//  YourNativeAdView.m
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/7.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import "MopubNativeAdRenderingView.h"
#import "MPNativeAdRendering.h"
#import "MPNativeAdRenderingImageLoader.h"
//#import "DeviceFontSize.h"
//#import "UIImageView+WebCache.h"

@interface MopubNativeAdRenderingView()<MPNativeAdRendering>

@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelSummary;
@property (strong, nonatomic) UILabel *labelInfo;
@property (strong, nonatomic) UIImageView *iconImageView;

@property UIImageView *imageViewBackground;
@property UIView *seperator;

@end

// YourNativeAdView.m

@implementation MopubNativeAdRenderingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initialUI];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initialUI];
    }
    
    return self;
}

-(void)initialUI{
    self.imageViewBackground = [[UIImageView alloc] init];
    //[self.imageViewBackground setImage:[UIImage imageNamed:@"box_02_news"]];

    self.seperator = [[UIView alloc] init];
    
    self.labelTitle = [[UILabel alloc] init];
    self.labelSummary = [[UILabel alloc] init];
    self.labelInfo = [[UILabel alloc] init];
    self.iconImageView = [[UIImageView alloc] init];
    
//    self.iconImageView.layer.masksToBounds = YES;
//    self.iconImageView.layer.cornerRadius = 8.0;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.labelTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelSummary setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelInfo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageViewBackground setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.seperator setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.labelTitle setTextColor:[UIColor colorWithRed:63/255.0f
                                                  green:63/255.0f
                                                   blue:63/255.0f
                                                  alpha:1.0f]];
    [self.labelSummary setFont:[UIFont systemFontOfSize:12]];
    [self.labelSummary setTextColor:[UIColor colorWithRed:170/255.0f
                                                    green:170/255.0f
                                                     blue:170/255.0f
                                                    alpha:1.0f]];
    
    
    [self.labelInfo setTextColor:[UIColor colorWithRed:150/255.0f
                                                 green:150/255.0f
                                                  blue:150/255.0f
                                                 alpha:1.0f]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [self.seperator setBackgroundColor:UIColor.whiteColor];
    }else {
        [self.seperator setBackgroundColor:[UIColor colorWithRed:171/255.0f
                                                           green:171/255.0f
                                                            blue:171/255.0f
                                                           alpha:0.4f]];
    }
    
    [self.labelTitle setNumberOfLines:2];
    [self.labelSummary setNumberOfLines:2];
    [self.imageViewBackground setBackgroundColor:UIColor.whiteColor];
        
    [self addSubview:self.imageViewBackground];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSummary];
    [self addSubview:self.labelInfo];
    [self addSubview:self.iconImageView];
    [self addSubview:self.seperator];
    
    
    NSDictionary *views = @{@"labelTitle": self.labelTitle,
                            @"labelSummary": self.labelSummary,
                            @"labelInfo": self.labelInfo,
                            @"iconImageView": self.iconImageView,
                            @"imageViewBackground": self.imageViewBackground,
                            @"seperator": self.seperator};
    
    NSArray *constraits = @[];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageViewBackground]-0-|" options:0 metrics:nil views:views]];
        constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[iconImageView(100@500)]" options:0 metrics:nil views:views]];
    }else {
        constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[imageViewBackground]-3-|" options:0 metrics:nil views:views]];
        constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[iconImageView(100)]" options:0 metrics:nil views:views]];
    }
    
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageViewBackground]-0-|" options:0 metrics:nil views:views]];
//    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageViewBackground]-0-|" options:0 metrics:nil views:views]];
//    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[iconImageView(100@500)]" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[iconImageView]-5-|" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[iconImageView]-6-[labelTitle]-11-|" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[labelTitle]" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[labelTitle]-4-[labelSummary]-(>=2)-[labelInfo]-2-[seperator(1)]-0-|" options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing metrics:nil views:views]];
    constraits = [constraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[iconImageView]-(>=0)-[seperator]" options:0 metrics:nil views:views]];
    constraits = [constraits arrayByAddingObject:[NSLayoutConstraint constraintWithItem:self.iconImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.iconImageView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
    
    [NSLayoutConstraint activateConstraints:constraits];
    
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
    return nil;
}


-(void)layoutCustomAssetsWithProperties:(NSDictionary *)customProperties imageLoader:(MPNativeAdRenderingImageLoader *)imageLoader{
    
//    NSLog(@"[RenderingView TableViewCell for MopubNativeAd] layoutCustomAssetsWithProperties: %@", customProperties);
//    NSString *iconImage = customProperties[@"iconimage"];
//    [imageLoader loadImageForURL:[NSURL URLWithString:iconImage] intoImageView:self.iconImageView];
    
    
    //Add parameter sponser
    //NSString *callToActionString = customProperties[@"ctatext"];
    //NSString *iconImage = customProperties[@"img_icon"];        // 82x82
    //NSString *mainImage = customProperties[@"mainimage"];       // 1200x628
    NSString *titleString = customProperties[@"title"];
    NSString *textString = customProperties[@"text"];
    NSString *iconHDImage  = customProperties[@"iconimage"];    // 300x300
    NSString *advertiserName = customProperties[@"advertiserName"];
    NSString *sponsored = customProperties[@"sponser"];
    
    self.labelTitle.text = titleString;
    self.labelSummary.text = textString;
    if(advertiserName && [advertiserName length]>0){
        self.labelInfo.text = [NSString stringWithFormat:@"%@ | %@",sponsored,advertiserName];
    }
    else{
        self.labelInfo.text = [NSString stringWithFormat:@"%@",sponsored];
    }
    
    [imageLoader loadImageForURL:[NSURL URLWithString:iconHDImage] intoImageView:self.iconImageView];
    
}

@end
