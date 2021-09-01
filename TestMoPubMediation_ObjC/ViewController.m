//
//  ViewController.m
//  TestMoPubMediation_ObjC
//
//  Created by JustinTsou on 2021/2/8.
//

#import "ViewController.h"
#import "MopubNativeAdViewController.h"
#import "MopubSuprAdViewController.h"

typedef NS_ENUM(NSInteger, AdEnum) {
    MoPubNativeAd = 0,
    MoPubSuprAd = 1,
};

@interface ViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_dataList;
}

@property (weak, nonatomic) IBOutlet UITableView *adTableView;
@property AdEnum adEnum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:@"Mopub Ad"];
    
    _dataList = @[@"Mopub Native Ad",@"Mopub Supr Ad"];
    
    [self setupTableVie];
}

#pragma mark : Setup TableView

- (void)setupTableVie {
    
    self.adTableView.dataSource = self;
    self.adTableView.delegate = self;
    
    [self.adTableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataList[indexPath.row];
    return  cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == MoPubNativeAd) {
        MopubNativeAdViewController *mopubNativeAdViewController = [[MopubNativeAdViewController alloc]init];
        [self.navigationController pushViewController:mopubNativeAdViewController animated:YES];
    }else if (indexPath.row == MoPubSuprAd) {
        MopubSuprAdViewController *mopubSuprAdViewController = [[MopubSuprAdViewController alloc]init];
        [self.navigationController pushViewController:mopubSuprAdViewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
