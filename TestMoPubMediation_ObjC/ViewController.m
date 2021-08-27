//
//  ViewController.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/2/8.
//

#import "ViewController.h"
#import "MoPub.h"
#import "MopubNativeAdRenderingView.h"
#import "AotterTrekNativeAdRenderer.h"
#import "MopubSuprAdRenderingView.h"

#import "MopubNativeAdTableViewCell.h"
#import "MopubSuprAdTableViewCell.h"

static NSInteger nativeAdPosition = 2;
static NSInteger suprAdPosition = 7;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    CGFloat _viewWidth;
    CGFloat _viewHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *adTableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) MPNativeAd *nativeAd;
@property (strong, nonatomic) MPNativeAd *suprAd;
@property (strong, nonatomic) UIView *nativeAdView;
@property (strong, nonatomic) UIView *suprAdView;
@property (strong, nonatomic) MPNativeAdRequest *nativeAdRequest;
@property (strong, nonatomic) MPNativeAdRequest *suprAdRequest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewWidth = UIScreen.mainScreen.bounds.size.width;
    _viewHeight = _viewWidth * 9/16;
    
    
    [self setupTableVie];
    [self setupRefreshControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self configuareMoPubNativeAd];
    [self configuareMoPubSuprAd];
}

#pragma mark : Setup TableView

- (void)setupTableVie {
    
    self.adTableView.dataSource = self;
    self.adTableView.delegate = self;
    
    [self.adTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    
    [self.adTableView registerNib:[UINib nibWithNibName:@"MopubNativeAdTableViewCell" bundle:nil] forCellReuseIdentifier:@"MopubNativeAdTableViewCell"];
    
    [self.adTableView registerNib:[UINib nibWithNibName:@"MopubSuprAdTableViewCell" bundle:nil] forCellReuseIdentifier:@"MopubSuprAdTableViewCell"];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc]init];
    
    [self.refreshControl addTarget:self action:@selector(onRefreshTable) forControlEvents:UIControlEventValueChanged];
    [self.adTableView addSubview:self.refreshControl];
}

-(void) configuareMoPubNativeAd {
    
    // Native Ad Test adUnit: ba6faf5f94eb49d69b7a02ace99ad5dd
    
    NSString *nativeAdUnitId = @"ba6faf5f94eb49d69b7a02ace99ad5dd";
    
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [MopubNativeAdRenderingView class];
    
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, 103.0f);
    };
    
    //MPNativeAdRendererConfiguration *config_mpNative = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
    //config_mpNative.supportedCustomEvents = @[@"MPMoPubNativeCustomEvent"];
    
    MPNativeAdRendererConfiguration *config_trek = [AotterTrekNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
  
    
    _nativeAdRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:nativeAdUnitId
                                                           rendererConfigurations:@[config_trek]];
    

    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdMainImageKey, kAdIconImageKey, kAdCTATextKey, nil];
    //targeting.keywords = @"Hello World! Trek";
    //targeting.userDataKeywords = @"USER_DATA_KEYWORDS";
    targeting.localExtras = @{@"category": @""}; //@{@"category": self.category.name};
    
    _nativeAdRequest.targeting = targeting;
    
    
    [_nativeAdRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        
        self->_nativeAd = response;
        self->_nativeAdView = [response retrieveAdViewWithError:nil];
        self.nativeAd = response;
        //self.nativeAd.delegate = self;
        self->_nativeAdView.frame = CGRectMake(0,self.view.center.y, UIScreen.mainScreen.bounds.size.width,120);
        
        NSLog(@"start Load MPadReuest finished, retrieved View class: %@", [self->_nativeAdView class]);
        NSLog(@"response.properties: %@", response.properties);
        NSLog(@"error: %@", error.description);
        
        [self.adTableView reloadData];

    }];
}

-(void) configuareMoPubSuprAd {
    
    // Supr Ad Test adUnit: 5e585f39d79942f88f58519070db28bf
    
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
    targeting.localExtras = @{@"category": @""}; //@{@"category": self.category.name};
    
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
    
    if (_nativeAd != nil) {
        _nativeAd = nil;
    }
    
    if (_suprAd != nil) {
        _suprAd = nil;
    }
    
    [self configuareMoPubNativeAd];
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
    
    if (indexPath.row == nativeAdPosition) {
        if (_nativeAd != nil && _nativeAdView != nil) {
            MopubNativeAdTableViewCell *mopubNativeAdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"MopubNativeAdTableViewCell" forIndexPath:indexPath];
            [mopubNativeAdTableViewCell setupNativeAdView:_nativeAdView];
            return mopubNativeAdTableViewCell;
        }
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == nativeAdPosition) {
        return _nativeAd == nil ? 0:120;
    }
    
    if (indexPath.row == suprAdPosition) {
        return _suprAd == nil ? 0:_viewHeight;
    }
    
    return 80;
}



@end
