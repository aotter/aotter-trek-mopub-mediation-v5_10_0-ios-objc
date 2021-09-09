//
//  MopubSuprAdViewController.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/9/1.
//

#import "MopubSuprAdViewController.h"
#import "MoPubSDK/MoPub.h"
#import "AotterTrekNativeAdRenderer.h"
#import "MopubSuprAdRenderingView.h"
#import "MopubSuprAdTableViewCell.h"

static NSInteger suprAdPosition = 7;

@interface MopubSuprAdViewController () <UITableViewDataSource, UITableViewDelegate> {
    CGFloat _viewWidth;
    CGFloat _viewHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *adTableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MPNativeAd *suprAd;
@property (strong, nonatomic) UIView *suprAdView;
@property (strong, nonatomic) MPNativeAdRequest *suprAdRequest;

@end

@implementation MopubSuprAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewWidth = UIScreen.mainScreen.bounds.size.width;
    _viewHeight = _viewWidth * 9/16;
    
    
    [self setupTableVie];
    [self setupRefreshControl];

    [self configuareMoPubSuprAd];
}

#pragma mark : Setup TableView

- (void)setupTableVie {
    
    self.adTableView.dataSource = self;
    self.adTableView.delegate = self;
    
    [self.adTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    [self.adTableView registerNib:[UINib nibWithNibName:@"MopubSuprAdTableViewCell" bundle:nil] forCellReuseIdentifier:@"MopubSuprAdTableViewCell"];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    
    [self.refreshControl addTarget:self action:@selector(onRefreshTable) forControlEvents:UIControlEventValueChanged];
    [self.adTableView addSubview:self.refreshControl];
}


#pragma mark : Configuare MoPub SuprAd

-(void) configuareMoPubSuprAd {
    
    NSString *suprAdUnitId = @"5e585f39d79942f88f58519070db28bf";
    
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [MopubSuprAdRenderingView class];
    
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, 103.0f);
    };
    
    MPNativeAdRendererConfiguration *config_trek = [AotterTrekNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
  
    
    _suprAdRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:suprAdUnitId
                                                           rendererConfigurations:@[config_trek]];
    

    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdMainImageKey, kAdIconImageKey, kAdCTATextKey, nil];
    targeting.localExtras = @{@"category": @"SuprAd"}; //@{@"category": self.category.name};
    
    _suprAdRequest.targeting = targeting;
    
    [_suprAdRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        
        self->_suprAd = response;
        self->_suprAdView = [response retrieveAdViewWithError:nil];
        
        self->_suprAdView.frame = CGRectMake(0,self.view.center.y, UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.width * 9/16);
        
        NSLog(@"start Load MPadReuest finished, retrieved View class: %@", [self->_suprAdView class]);
        NSLog(@"response.properties: %@", response.properties);
        NSLog(@"error: %@", error.description);
        
        [self.adTableView reloadData];

    }];
}


#pragma mark - Action

- (void)onRefreshTable {
    [self.refreshControl beginRefreshing];
    
    if (_suprAd != nil) {
        _suprAd = nil;
    }
    
    [self configuareMoPubSuprAd];

    [self.refreshControl endRefreshing];
}

#pragma mark : ScrlloView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_suprAd != nil) {
        // The postNotificationName please fill in "SuprAdScrolled"
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SuprAdScrolled"
                                                           object:self
                                                         userInfo:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == suprAdPosition) {
        if(_suprAd != nil && _suprAdView != nil) {
            MopubSuprAdTableViewCell *mopubSuprAdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MopubSuprAdTableViewCell" forIndexPath:indexPath];
            [mopubSuprAdTableViewCell setupSuprAdView:_suprAdView];
            return mopubSuprAdTableViewCell;
        }
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"index:%ld",(long)indexPath.row];
    return  cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == suprAdPosition) {
        return _suprAd == nil ? 0:_viewHeight;
    }
    
    return 80;
}



@end

