//
//  MopubNativeAdTableViewCell.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/3/26.
//

#import "MopubNativeAdTableViewCell.h"

@implementation MopubNativeAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupNativeAdView:(UIView *)nativeAdView {
    [self.contentView addSubview:nativeAdView];
    
    [nativeAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [nativeAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [nativeAdView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [nativeAdView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [nativeAdView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [nativeAdView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
}

@end
