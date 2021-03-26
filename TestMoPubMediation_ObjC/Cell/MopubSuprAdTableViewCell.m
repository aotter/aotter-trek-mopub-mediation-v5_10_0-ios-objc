//
//  MopubSuprAdTableViewCell.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/3/26.
//

#import "MopubSuprAdTableViewCell.h"

@implementation MopubSuprAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupSuprAdView:(UIView *)suprAdView {
    [self.contentView addSubview:suprAdView];
    
    [suprAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [suprAdView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [suprAdView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
    [suprAdView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
    [suprAdView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [suprAdView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
}

@end
