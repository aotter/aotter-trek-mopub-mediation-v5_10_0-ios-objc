//
//  MopubSuprAdRenderingView.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/3/25.
//

#import "MopubSuprAdRenderingView.h"
#import "MPNativeAdRendering.h"
#import "MPNativeAdRenderingImageLoader.h"

@interface MopubSuprAdRenderingView()<MPNativeAdRendering>
@property (strong, nonatomic) UIImageView *mainImageView;
@end

@implementation MopubSuprAdRenderingView

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
    self.mainImageView = [[UIImageView alloc] init];
}

- (UIImageView *)nativeMainImageView {
    return self.mainImageView;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self addSubview:self.mainImageView];
    
    [self.mainImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.mainImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.mainImageView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.mainImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
}

@end
