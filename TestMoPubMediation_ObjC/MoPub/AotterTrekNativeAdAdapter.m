//
//  AotterTrekNativeAdAdapter.m
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/8.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import "AotterTrekNativeAdAdapter.h"
#import "MPNativeAdConstants.h"
#import "MPNativeAdRendererSettings.h"
#import "MPNativeAdRendererConfiguration.h"

@interface AotterTrekNativeAdAdapter()
@property UIView *mediaView;
@end

@implementation AotterTrekNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithTKNativeAd:(TKAdNative *)nativeAd adProperties:(NSDictionary *)adProps{
    if (self = [super init]) {
        _adNative = nativeAd;

        NSMutableDictionary *properties;
        if (adProps) {
            properties = [NSMutableDictionary dictionaryWithDictionary:adProps];
        } else {
            properties = [NSMutableDictionary dictionary];
        }
        [properties setObject:@"NATIVE" forKey:@"TREK_AD_TYPE"];
        
        if (nativeAd.AdData[@"title"]) {
            [properties setObject:nativeAd.AdData[@"title"] forKey:kAdTitleKey];
        }
        
        if (nativeAd.AdData[@"text"]) {
            [properties setObject:nativeAd.AdData[@"text"] forKey:kAdTextKey];
        }
        
        if(nativeAd.AdData[@"img_main"]){
            [properties setObject:nativeAd.AdData[@"img_main"] forKey:kAdMainImageKey];
        }
        
        if(nativeAd.AdData[@"img_icon_hd"]){
            [properties setObject:nativeAd.AdData[@"img_icon_hd"] forKey:kAdIconImageKey];
        }
        
        if(nativeAd.AdData[@"callToAction"]){
            [properties setObject:nativeAd.AdData[@"callToAction"] forKey:kAdCTATextKey];
        }
        
        if (nativeAd.AdData[@"uuid"]) {
            [properties setObject:nativeAd.AdData[@"uuid"] forKey:@"placementID"];
        }
        
        if(nativeAd.AdData[@"advertiserName"]){
            [properties setObject:nativeAd.AdData[@"advertiserName"] forKey:@"advertiserName"];
        }
        
        //Add sponser to dictionary
        if(nativeAd.AdData[@"sponser"]){
            [properties setObject:nativeAd.AdData[@"sponser"] forKey:@"sponser"];
        }
        
        _properties = properties;

    }

    return self;
}

- (instancetype)initWithTKSuprAd:(TKAdSuprAd *)suprAd adProperties:(NSDictionary *)adProps{
    if (self = [super init]) {
        _suprAd = suprAd;
        _mediaView = [[UIView alloc] init];
        
        NSMutableDictionary *properties;
        if (adProps) {
            properties = [NSMutableDictionary dictionaryWithDictionary:adProps];
        } else {
            properties = [NSMutableDictionary dictionary];
        }
        
        [properties setObject:@"SUPRAD" forKey:@"TREK_AD_TYPE"];
        
        
        if (suprAd.adData[@"title"]) {
            [properties setObject:suprAd.adData[@"title"] forKey:kAdTitleKey];
        }
        
        if (suprAd.adData[@"text"]) {
            [properties setObject:suprAd.adData[@"text"] forKey:kAdTextKey];
        }
        
        if(suprAd.adData[@"img_main"]){
            [properties setObject:suprAd.adData[@"img_main"] forKey:kAdMainImageKey];
        }
        
        if(suprAd.adData[@"img_icon_hd"]){
            [properties setObject:suprAd.adData[@"img_icon_hd"] forKey:kAdIconImageKey];
        }
        
        if(suprAd.adData[@"callToAction"]){
            [properties setObject:suprAd.adData[@"callToAction"] forKey:kAdCTATextKey];
        }
        
        if (suprAd.adData[@"uuid"]) {
            [properties setObject:suprAd.adData[@"uuid"] forKey:@"placementID"];
        }
        
        if(suprAd.adData[@"advertiserName"]){
            [properties setObject:suprAd.adData[@"advertiserName"] forKey:@"advertiserName"];
        }
        
        _properties = properties;
        
    }
    
    return self;
}

-(UIView *)mainMediaView{
    return _mediaView;
}

-(UIView *)iconMediaView{
    return nil;
}

-(NSURL*)defaultActionURL{
    if(self.adNative){
        NSString *url_origin = self.adNative.AdData[@"url_original"];
        return [NSURL URLWithString:url_origin];
    }
    else if (self.suprAd){
        NSString *url_origin = self.suprAd.adData[@"url_original"];
        return [NSURL URLWithString:url_origin];
    }
    else{
        return nil;
    }
}

-(void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller{
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
}

-(void)willAttachToView:(UIView *)view{
    if(self.adNative){
        [self.adNative registerAdView:view];
        [self.adNative registerPresentingViewController:[self topViewController]];
    }
    if(self.suprAd){
        [self.suprAd registerAdView:view];
        [self.suprAd registerPresentingViewController:[self topViewController]];
        [_suprAd registerTKMediaView:self.mediaView];
    }
}

- (void)onLogImression{
    if([self.delegate respondsToSelector:@selector(nativeAdWillLogImpression:)]){
        [self.delegate nativeAdWillLogImpression:self];
    }
}


- (UIViewController *)topViewController{
    UIWindow* window = nil;
    if (@available(iOS 13.0, *))
    {
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
        {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                window = windowScene.windows.firstObject;
                
                break;
            }
        }
    }else{
        window = [UIApplication sharedApplication].keyWindow;
    }
  return [self topViewController:window.rootViewController];
}


- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
  if ([rootViewController isKindOfClass:[UINavigationController class]]) {
    UINavigationController *navigationController = (UINavigationController *)rootViewController;
    return [self topViewController:[navigationController.viewControllers lastObject]];
  }
  if ([rootViewController isKindOfClass:[UITabBarController class]]) {
    UITabBarController *tabController = (UITabBarController *)rootViewController;
    return [self topViewController:tabController.selectedViewController];
  }
  if (rootViewController.presentedViewController) {
    return [self topViewController:rootViewController];
  }
  return rootViewController;
}


@end
