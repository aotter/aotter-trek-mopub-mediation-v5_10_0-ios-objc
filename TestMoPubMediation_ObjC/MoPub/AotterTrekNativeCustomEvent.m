//
//  AotterTrekNativeCustomEvent.m
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/9.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import "AotterTrekNativeCustomEvent.h"
#import "AotterTrekNativeAdAdapter.h"

#import "ViewController.h"


@interface AotterTrekNativeCustomEvent()<TKAdNativeDelegate, TKAdSuprAdDelegate>
@property TKAdNative *adNative;
@property TKAdSuprAd *suprAd;
@property AotterTrekNativeAdAdapter *adapter;
@end

@interface AotterTrekNativeCustomEvent()<ViewControllerDelegate> {
    // CustomViewController 隨著自己定義的 ViewController 來決定
    // EX: SomeViewController (Your Custom ViewController)
    // declared: SomeViewController *_customViewController;
    ViewController *_customViewController;
}
@end

@implementation AotterTrekNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    
    NSString *placeName = info[@"place_name"];
    NSString *type = [NSString stringWithFormat:@"%@", info[@"adType"]];
    NSString *categoryName = @"";
    
    if(self.localExtras && [self.localExtras.allKeys containsObject:@"category"]){
        categoryName = [NSString stringWithFormat:@"%@", self.localExtras[@"category"]];
    }
    
    if([type isEqualToString:@"NATIVE_SUPRAD"]) {
        self.suprAd = [[TKAdSuprAd alloc] initWithPlace:placeName category:categoryName];
        self.suprAd.delegate = self;
        
        [self.suprAd fetchAd];
    }else if([type isEqualToString:@"NATIVE"]) {
        self.adNative = [[TKAdNative alloc] initWithPlace:placeName category:categoryName];
        self.adNative.delegate = self;
        [self.adNative fetchAd];
    }
    
}


#pragma mark - TKAdNative delegates

-(void)TKAdNative:(TKAdNative *)ad fetchError:(TKAdError *)error{
    if([self.delegate respondsToSelector:@selector(nativeCustomEvent:didFailToLoadAdWithError:)]){
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        NSLog(@"TKAdNative fetchError:%@",error.description);
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

-(void)TKAdNative:(TKAdNative *)ad didReceivedAdWithData:(NSDictionary *)adData{
    if(adData){
        self.adapter = [[AotterTrekNativeAdAdapter alloc] initWithTKNativeAd:self.adNative adProperties:nil];
        MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
        [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
    }
    else{
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

-(void)TKAdNativeOnImpression:(TKAdNative *)ad{
    if(self.adapter){
        [self.adapter onLogImression];
    }
}

#pragma mark - TKAdSuprAd delegates

-(void)TKAdSuprAd:(TKAdSuprAd *)suprAd adError:(TKAdError *)error{
    NSError *nerror = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": error.message}];
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:nerror];
    
}


- (void)TKAdSuprAd:(TKAdSuprAd *)suprAd didReceivedAdWithAdData:(NSDictionary *)adData preferedMediaViewSize:(CGSize)size isVideoAd:(BOOL)isVideoAd{
    if(adData){
        self.adapter = [[AotterTrekNativeAdAdapter alloc] initWithTKSuprAd:self.suprAd adProperties:nil];
        
        // Handle rootViewController delegate, need to transfer your custom ViewController
        // EX:
        // _customViewController = (SomeViewController *) rootViewController;
        // This delegate is your rootViewController delegate
        
        _customViewController = (ViewController *) [self.adapter topViewController];
        _customViewController.delegate = self;
        
        MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
        [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
    }
    else{
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

#pragma mark - ViewControllerDelegate

- (void)rootViewControllerScrollViewDidScroll:(UIScrollView *)scrollView {
    if (_suprAd != nil) {
        [_suprAd notifyAdScrolled];
    }
}

@end
