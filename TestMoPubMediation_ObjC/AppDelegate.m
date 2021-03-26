//
//  AppDelegate.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/2/8.
//

#import "AppDelegate.h"
#import <AotterTrek-iOS-SDK/AotterTrek-iOS-SDK.h>
#import "MoPub.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Test adUnit: ba6faf5f94eb49d69b7a02ace99ad5dd
    // prod adUnit: 3ead998035f14abab3f2fcfa3f95e167
    
    MPMoPubConfiguration *sdkConfig = [[MPMoPubConfiguration alloc] initWithAdUnitIdForAppInitialization:@"ba6faf5f94eb49d69b7a02ace99ad5dd"];

    sdkConfig.loggingLevel = MPBLogLevelInfo;
    sdkConfig.globalMediationSettings = @[];

    
    [[MoPub sharedInstance] initializeSdkWithConfiguration:sdkConfig completion:^{
        NSLog(@"MoPub init completion");
    }];
    
    //AotterTrek key: production
//    [[AotterTrek sharedAPI] initTrekServiceWithClientId:@"c4Xhe7Kbm84GN5XP+/+A" secret:@"xawJPwQ4F9Gt+cntJ1jNdAL2XGrrZU7y8y96RYPR8iT1m1y0AoN3ficBeV6ZeDKi+FeaV8nJ"];
    //AotterTrek key: test
    [[AotterTrek sharedAPI] initTrekServiceWithClientId:@"21tgwWwuzFYiD4ko5Klr" secret:@"fD8P20gzWYrlbuwWklRkicYcNwlWZSZwV+iHj3TzGSzzyfgTWmVR5trs5F1Dp+x9tX2jxq44"];
    
    [[AotterTrek sharedAPI] performSelector:@selector(enableLoggerLevelDevDetail)];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
