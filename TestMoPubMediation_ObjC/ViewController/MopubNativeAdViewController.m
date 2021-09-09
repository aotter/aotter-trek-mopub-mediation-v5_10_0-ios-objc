//
//  MopubAdViewController.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/8/6.
//

#import "MopubNativeAdViewController.h"
#import "MoPubSDK/MoPub.h"
#import "MopubNativeAdRenderingView.h"
#import "AotterTrekNativeAdRenderer.h"
#import "MopubNativeAdTableViewCell.h"

static NSInteger nativeAdPosition = 2;

@interface MopubNativeAdViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *adTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MPNativeAd *nativeAd;
@property (strong, nonatomic) UIView *nativeAdView;
@property (strong, nonatomic) MPNativeAdRequest *nativeAdRequest;

@end

@implementation MopubNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupTableVie];
    [self setupRefreshControl];
    
    [self configuareMoPubNativeAd];
}

#pragma mark : Setup TableView

- (void)setupTableVie {
    
    self.adTableView.dataSource = self;
    self.adTableView.delegate = self;
    
    [self.adTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    [self.adTableView registerNib:[UINib nibWithNibName:@"MopubNativeAdTableViewCell" bundle:nil] forCellReuseIdentifier:@"MopubNativeAdTableViewCell"];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    
    [self.refreshControl addTarget:self action:@selector(onRefreshTable) forControlEvents:UIControlEventValueChanged];
    [self.adTableView addSubview:self.refreshControl];
}

#pragma mark : Configuare MoPub NativeAd

-(void) configuareMoPubNativeAd {
    
    NSString *nativeAdUnitId = @"ba6faf5f94eb49d69b7a02ace99ad5dd";
    
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [MopubNativeAdRenderingView class];
    
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, 103.0f);
    };
        
    MPNativeAdRendererConfiguration *config_trek = [AotterTrekNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
  
    
    _nativeAdRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:nativeAdUnitId
                                                           rendererConfigurations:@[config_trek]];
    

    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdMainImageKey, kAdIconImageKey, kAdCTATextKey, nil];
    targeting.localExtras = @{@"category": @"NativeAd"}; //@{@"category": self.category.name};
    
    _nativeAdRequest.targeting = targeting;
    
    
    [_nativeAdRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        
        self->_nativeAd = response;
        self->_nativeAdView = [response retrieveAdViewWithError:nil];
        
        self->_nativeAdView.frame = CGRectMake(0,self.view.center.y, UIScreen.mainScreen.bounds.size.width,120);
        
        NSLog(@"start Load MPadReuest finished, retrieved View class: %@", [self->_nativeAdView class]);
        NSLog(@"response.properties: %@", response.properties);
        NSLog(@"error: %@", error.description);
        
        [self.adTableView reloadData];

    }];
}

#pragma mark - Action

- (void)onRefreshTable {
    
    [self.refreshControl beginRefreshing];
    
    if (_nativeAd != nil) {
        _nativeAd = nil;
    }
    
    [self configuareMoPubNativeAd];

    [self.refreshControl endRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == nativeAdPosition) {
        if (_nativeAd != nil && _nativeAdView != nil) {
            MopubNativeAdTableViewCell *mopubNativeAdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MopubNativeAdTableViewCell" forIndexPath:indexPath];
            [mopubNativeAdTableViewCell setupNativeAdView:_nativeAdView];
            return mopubNativeAdTableViewCell;
        }
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"index:%ld",(long)indexPath.row];
    return  cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == nativeAdPosition) {
        return _nativeAd == nil ? 0:120;
    }

    return 80;
}



@end
