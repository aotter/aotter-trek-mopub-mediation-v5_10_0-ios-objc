//
//  AotterTrekNativeCustomEvent.m
//  Aotter_test_mopub_mediation
//
//  Created by Aotter on 2016/12/9.
//  Copyright © 2016年 aotter. All rights reserved.
//

#import "AotterTrekNativeCustomEvent.h"
#import "AotterTrekNativeAdAdapter.h"

@interface AotterTrekNativeCustomEvent() <TKAdNativeDelegate, TKAdSuprAdDelegate>

@property TKAdNative *adNative;
@property TKAdSuprAd *suprAd;
@property AotterTrekNativeAdAdapter *adapter;

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
        
        if ([self topViewController] == nil) {
            NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"topViewController is nil"}];
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
            return;
        }
        
        self.suprAd = [[TKAdSuprAd alloc] initWithPlace:placeName category:categoryName];
        self.suprAd.delegate = self;
        
        [self.suprAd registerPresentingViewController:[self topViewController]];
        [self.suprAd fetchAd];
    }else if([type isEqualToString:@"NATIVE"]) {
        self.adNative = [[TKAdNative alloc] initWithPlace:placeName category:categoryName];
        self.adNative.delegate = self;
        [self.adNative fetchAd];
    }
    
}

#pragma mark - Life cycle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)TKAdNativeWillLogImpression:(TKAdNative *)ad{
    if(self.adapter){
        [self.adapter onLogImression];
    }
}

- (void)TKAdNativeWillLogClicked:(TKAdNative *)ad {
    if(self.adapter){
        [self.adapter onLogClick];
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
        
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(getNotification:)
                                                    name:@"SuprAdScrolled"
                                                  object:nil];
        
        MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:self.adapter];
        [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
    }
    else{
        NSError *error = [NSError errorWithDomain:@"com.aotter.aotterTrek" code:100 userInfo:@{@"message": @"fetch no ad"}];
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
    }
}

- (void)TKAdSuprAdWillLogImpression:(TKAdSuprAd *)ad {
    if(self.adapter){
        [self.adapter onLogImression];
    }
}

- (void)TKAdSuprAdWillLogClick:(TKAdSuprAd *)ad {
    if(self.adapter){
        [self.adapter onLogClick];
    }
}

#pragma mark - PrivateMethod

-(void)getNotification:(NSNotification *)notification{
    if (_suprAd != nil) {
        [_suprAd notifyAdScrolled];
        NSLog(@"getNotification:%@",self);
    }
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
 
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}

@end
