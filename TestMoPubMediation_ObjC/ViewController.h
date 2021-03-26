//
//  ViewController.h
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/2/8.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

- (void)rootViewControllerScrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface ViewController : UIViewController

@property id<ViewControllerDelegate> delegate;

@end

