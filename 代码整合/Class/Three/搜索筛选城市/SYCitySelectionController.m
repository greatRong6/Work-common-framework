//
//  SYCitySelectionController.m
//  SYCitySelectExample
//
//  Created by bcmac3 on 2016/11/22.
//  Copyright © 2016年 ShenYang. All rights reserved.
//

#import "SYCitySelectionController.h"
#import <CoreLocation/CoreLocation.h>
#import "SYChineseToPinyin.h"

#define SYColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]
#define SYBackgroundColor SYColor(232, 232, 232)
#define SYIndexColor SYColor(0, 188, 165)

// 最近访问城市存储路径
#define SYHistoryCitysPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"SYHistoryCitys.plist"]

#pragma mark - SYHeaderView
@interface SYHeaderView : UITableViewHeaderFooterView
@property (nonatomic, assign) BOOL isShowLine;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@end
@implementation SYHeaderView {
    UIView *_lineView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SYBackgroundColor;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = SYColor(156, 156, 156);
    [self.contentView addSubview:_titleLabel];
    _lineView = [[UIView alloc] init];
    _lineColor = SYColor(156, 156, 156);
    _lineView.backgroundColor = _lineColor;
    [self.contentView addSubview:_lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(16, 0, self.frame.size.width - 32, self.frame.size.height);
    _lineView.frame = CGRectMake(0, 0, self.frame.size.width - 16, .5);
}

- (void)setIsShowLine:(BOOL)isShowLine {
    if (_isShowLine == isShowLine) return;
    _isShowLine = isShowLine;
    _lineView.hidden = !_isShowLine;
}

- (void)setLineColor:(UIColor *)lineColor {
    if (_lineColor == lineColor) return;
    _lineColor = lineColor;
    _lineView.backgroundColor = lineColor;
}
@end

#pragma mark - SYTableViewCell
@interface SYTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isShowSeparator;
@property (nonatomic, strong) UIColor *separatorColor;

@end

@implementation SYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isShowSeparator = YES;
        _separatorColor = [UIColor lightGrayColor];
        [self setNeedsDisplay];
    }
    return self;
}

- (void)setIsShowSeparator:(BOOL)isShowSeparator {
    if (_isShowSeparator == isShowSeparator) return;
    _isShowSeparator = isShowSeparator;
    [self setNeedsDisplay];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    if (_separatorColor == separatorColor) return;
    _separatorColor = separatorColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if (!_isShowSeparator) return;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(14, rect.size.height - 0.5, rect.size.width - 14, 0.5)];
    [_separatorColor setFill];
    [bezierPath fillWithBlendMode:kCGBlendModeNormal alpha:1];
    [bezierPath closePath];
}

@end

#pragma mark - SYCitysCell
@interface SYCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SYCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
    _textLabel.layer.cornerRadius = 5.f;
    _textLabel.layer.borderWidth = .5;
    _textLabel.layer.borderColor = SYColor(156, 156, 156).CGColor;
    _textLabel.layer.masksToBounds = YES;
    _textLabel.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.contentView.bounds;
}

@end

@interface SYCitysCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) void(^selectCity)(NSString *cityName);

@property (nonatomic, strong) UICollectionView *collectionView;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat)heightForCitys:(NSArray *)citys;
@end
@implementation SYCitysCell
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(0, 16, 10, 16);
    CGFloat itemW = ([[UIScreen mainScreen] bounds].size.width - 16 * 3 - 10 * 2) / 3;
    layout.itemSize = CGSizeMake(itemW, 40);

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = SYBackgroundColor;
    [_collectionView registerClass:[SYCollectionCell class] forCellWithReuseIdentifier:@"SYCollectionCell"];
    [self.contentView addSubview:_collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.contentView.bounds;
}

- (void)setCitys:(NSArray *)citys {
    if (_citys == citys) return;
    _citys = citys;
    [_collectionView reloadData];
}

+ (CGFloat)heightForCitys:(NSArray *)citys {
    CGFloat h = 10;

    NSInteger row = (citys.count % 3 == 0) ? citys.count / 3 - 1 : citys.count / 3;

    h += row * 10 + (row + 1) * 40;
    return h;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.citys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCollectionCell" forIndexPath:indexPath];
    cell.textLabel.text = self.citys[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.selectCity) {
        _selectCity(self.citys[indexPath.row]);
    }
}

@end

#pragma mark - search
@class SYSearchController;
@protocol SYSearchControllerDelegate <NSObject>
- (void)resultViewController:(SYSearchController *)resultVC didSelectFollowCity:(NSString*)cityName;
@end
@interface SYSearchController : UISearchController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *results;
@property (nonatomic, weak) id<SYSearchControllerDelegate>resultDelegate;
@property (nonatomic, strong) UIView *maskView;


@end
@implementation SYSearchController
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard)]];
        _maskView.hidden = YES;
    }
    return _maskView;
}

- (void)cancelKeyboard {
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.hidden = YES;
    }];
}

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    if (self = [super initWithSearchResultsController:searchResultsController]) {
        self.hidesNavigationBarDuringPresentation = YES;
        self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, self.searchBar.frame.size.width, 44.0);
        self.searchBar.placeholder = @"输入城市名或者拼音查询";
        self.searchBar.returnKeyType = UIReturnKeyDone;
        
//        self.searchBar.layer.cornerRadius = 15;
//        self.searchBar.layer.masksToBounds = YES;
//        [self.searchBar.layer setBorderWidth:8];
//        UITextField *tf = [[self.searchBar.subviews.firstObject subviews] lastObject];
//        tf.backgroundColor = SYBackgroundColor;
//        [self.searchBar.layer setBorderColor:SYBackgroundColor.CGColor];
//        self.searchBar.returnKeyType = UIReturnKeyDone;
        
        self.searchResultsController.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
        if ([searchResultsController isKindOfClass:[UITableViewController class]]) {
            UITableViewController *tb = (UITableViewController *)searchResultsController;
            tb.tableView.delegate = self;
            tb.tableView.dataSource = self;
        }
        
        [self.view addSubview:self.maskView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *resultId = @"SYResultID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:resultId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resultId];
    }
    cell.textLabel.text = self.results[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.resultDelegate respondsToSelector:@selector(resultViewController:didSelectFollowCity:)]) {
        [self.resultDelegate resultViewController:self didSelectFollowCity:self.results[indexPath.row]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

@end

#pragma mark - SYCitySelectionController
@interface SYCitySelectionController () <UITableViewDelegate, UITableViewDataSource, SYSearchControllerDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) SYSearchController *searchVc;
@property (nonatomic, strong) UITableViewController *resultVc;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) NSArray *indexArray;
@property (nonatomic, copy) NSArray *currentCity;
@property (nonatomic, copy) NSArray *historyCitys;
@property (nonatomic, copy) NSMutableDictionary *cityDicts;
@property (nonatomic, copy) NSArray *cityNames;
@property (nonatomic, assign) NSInteger kCount;

@end

@implementation SYCitySelectionController {
    NSArray *_hotCitys;
}

- (void)dealloc {
    _searchVc.delegate = nil;
    _searchVc.searchResultsUpdater = nil;
    _searchVc.searchBar.delegate = nil;
    _searchVc.resultDelegate = nil;

    _indexArray = nil;
    _historyCitys = nil;
    _cityDicts = nil;

    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
        _locationManager = nil;
        _locationManager.delegate = nil;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = SYBackgroundColor;

    [self setNavigation];
    [self setTableView];
    [self setSearchController];
    [self prepareData];

    if (_openLocation) {
        [self locate];
    }
}

- (void)setSearchController {
    
    self.resultVc = [[UITableViewController alloc]init];
    _searchVc = [[SYSearchController alloc]initWithSearchResultsController:self.resultVc];
    _searchVc.delegate = self;
    _searchVc.searchResultsUpdater = self;
    _searchVc.searchBar.delegate = self;
    _searchVc.resultDelegate = self;

    //设置UISearchController的显示属性，以下3个属性默认为YES
    //搜索时，背景变暗色
    _searchVc.dimsBackgroundDuringPresentation = NO;
    //搜索时，背景变模糊
    _searchVc.obscuresBackgroundDuringPresentation = NO;
    //隐藏导航栏
    _searchVc.hidesNavigationBarDuringPresentation = NO;

    _tableView.tableHeaderView = self.searchVc.searchBar;
    
}

- (void)setNavigation {
    self.title = @"选择城市";

    if (self.backView) {
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setImage:[UIImage imageNamed:@"SYCity.bundle/close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)setTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = SYBackgroundColor;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionIndexColor = SYIndexColor; //设置默认时索引值颜色
}

- (void)prepareData {
    _historyCitys = [NSKeyedUnarchiver unarchiveObjectWithFile:SYHistoryCitysPath];
    _currentCityName = _currentCityName ? _currentCityName : @"北京市";
    _currentCity = @[_currentCityName];

    NSArray *tempIndex = @[];

    if (!_cityDict) {
        if (!_citys) {
            NSArray *citys = [self arrayWithPathName:@"city"];
            //    NSArray *citydatas = [self arrayWithPathName:@"citydata"];

            __block NSMutableArray *city = @[].mutableCopy;
            [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [city addObject:obj[@"name"]];
            }];
            _citys = city.copy;
        }
        _cityNames = [SYPinyinSort sortWithChineses:_citys];
        tempIndex = [[SYPinyinSort defaultPinyinSort] indexArray];
        
    } else {

        NSArray *index = [_cityDict allKeys];
        tempIndex = [index sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];

        NSMutableArray *mArr = @[].mutableCopy;
        [tempIndex enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mArr addObject:_cityDict[obj]];
        }];

        _cityNames = mArr.copy;
    }

    NSMutableArray *sortCitys = @[].mutableCopy;
    NSMutableArray *sortIndex = @[].mutableCopy;

    [sortIndex addObject:@"#"];
    [sortCitys addObject:_currentCity];
    _kCount++;

    if (_historyCitys && _historyCitys.count > 0) {
        [sortIndex addObject:@"$"];
        [sortCitys addObject:_historyCitys];
        _kCount++;
    }

    [sortIndex addObject:@"*"];
    [sortCitys addObject:self.hotCitys];
    _kCount++;

    [sortIndex addObjectsFromArray:tempIndex];
    [sortCitys addObjectsFromArray:_cityNames];

    _indexArray = sortIndex.copy;
    _cityDicts = [NSMutableDictionary dictionaryWithObjects:sortCitys forKeys:sortIndex];
}

- (void)saveHistoryCitys:(NSString *)cityName {
    NSMutableArray *marr = @[].mutableCopy;
    [marr addObjectsFromArray:self.historyCitys];
    [marr removeObject:cityName];
    [marr insertObject:cityName atIndex:0];

    if (marr.count > 3) [marr removeObjectsInRange:NSMakeRange(3, marr.count - 3)];
    self.historyCitys = [marr copy];

    [NSKeyedArchiver archiveRootObject:self.historyCitys toFile:SYHistoryCitysPath];
    if (!_selectCity) return;
    _selectCity(cityName);
    [self cancelDidClick];
}

#pragma mark - events
- (void)cancelDidClick {
    if (_searchVc.presentingViewController) {
        [self.navigationController.view addSubview:self.navigationController.navigationBar];
        [_searchVc dismissViewControllerAnimated:NO completion:nil];
    }
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Delegate
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [searchController.searchBar text];
    NSMutableArray *dataArray = @[].mutableCopy;
    //过滤数据
    for (NSArray *arr in self.cityNames) {
        for (NSString *city in arr) {
            if ([city rangeOfString:searchString].location != NSNotFound) {
                [dataArray addObject:city];
                continue;
            }
            NSString *pinyin = [[SYChineseToPinyin pinyinFromChiniseString:city] lowercaseString];
            if ([pinyin hasPrefix:[searchString lowercaseString]]) {
                [dataArray addObject:city];
                continue;
            }
        }
    }

    if (dataArray.count <= 0) {
        [dataArray addObject:@"抱歉，未找到相关位置，可尝试修改后重试"];
    }

    //刷新表格
    _searchVc.maskView.hidden = YES;
    if ([searchController.searchBar.text isEqualToString:@""]) _searchVc.maskView.hidden = NO;
    self.searchVc.results = dataArray;
    self.resultVc.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    self.resultVc.tableView.scrollIndicatorInsets = self.resultVc.tableView.contentInset;
    [self.resultVc.tableView reloadData];
}

#pragma mark - SYSearchResultControllerDelegate
- (void)resultViewController:(SYSearchController *)resultVC didSelectFollowCity:(NSString *)cityName {
    self.searchVc.searchBar.text = @"";
    [self saveHistoryCitys:cityName];
}

#pragma mark - UISearchBarDelegate
// 修改SearchBar的Cancel Button 的Title
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar; {
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn = [searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchVc.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cityDicts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < _kCount) return 1;
    NSArray *categoryCitys = _cityDicts[_indexArray[section]];
    return categoryCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
    if (indexPath.section < _kCount) {
        SYCitysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCitysCell"];
        if (!cell) {
            __weak typeof(self) weakSelf = self;
            cell = [[SYCitysCell alloc] initWithReuseIdentifier:@"SYCitysCell"];
            cell.selectCity = ^(NSString *cityName) {
                __strong typeof(weakSelf) strongSelf = self;
                [strongSelf saveHistoryCitys:cityName];
            };
        }
        cell.citys = categoryCitys;
        return cell;
    }

    SYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYTableViewCell"];
    if (!cell) {
        cell = [[SYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYTableViewCell"];
    }
    cell.isShowSeparator = YES;
    if (indexPath.row >= [categoryCitys count] - 1) cell.isShowSeparator = NO;
    cell.textLabel.text = categoryCitys[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _kCount) {
        NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
        CGFloat h = [SYCitysCell heightForCitys:categoryCitys];
        return indexPath.section == _kCount - 1 ? h + 10 : h;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerViewId = @"SYHeaderViewId";
    SYHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (!headerView) {
        headerView = [[SYHeaderView alloc] initWithReuseIdentifier:headerViewId];
    }
    headerView.isShowLine = YES;
    NSString *title = self.indexArray[section];
    if ([title isEqualToString:@"#"]) {
        title = @"当前城市";
    } else if ([title isEqualToString:@"$"]) {
        title = @"最近访问城市";
    } else if ([title isEqualToString:@"*"]) {
        title = @"热门城市";
    }
    if (section < _kCount) {
        headerView.isShowLine = NO;
    }
    headerView.titleLabel.text = title;
    return headerView;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < _kCount) return;
    NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
    [self saveHistoryCitys:categoryCitys[indexPath.row]];
}

//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - lazy load
- (NSArray *)arrayWithPathName:(NSString *)pathName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SYCity" ofType:@"bundle"];
    NSBundle *syBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [syBundle pathForResource:pathName ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

#pragma mark - locate
- (void)locate {
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        [_locationManager startUpdatingLocation]; //开启定位
        _currentCity = @[@"定位中..."];
        [_cityDicts setObject:_currentCity forKey:@"#"];
        [_tableView reloadData];
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error) {
         if (array.count > 0) {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             _currentCity = @[city];
             [_cityDicts setObject:_currentCity forKey:@"#"];
             [_tableView reloadData];

             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }
//         else if (error == nil && [array count] == 0) {
//             NSLog(@"No results were returned.");
//         } else if (error != nil) {
//             NSLog(@"An error occurred = %@", error);
//         }
     }];
}

#pragma mark - Setter
- (void)setCurrentCityName:(NSString *)currentCityName {
    if ([_currentCityName isEqualToString:currentCityName]) return;
    _currentCityName = currentCityName;
}

- (void)setOpenLocation:(BOOL)openLocation {
    if (_openLocation == openLocation) return;
    _openLocation = openLocation;
    if (_openLocation) {
        [self locate];
        return;
    }
    [_locationManager stopUpdatingHeading];
}

- (void)setBackView:(UIView *)backView {
    if (_backView == backView) return;
    _backView = backView;
    if ([backView isKindOfClass:[UIButton class]]) {
        [(UIButton *)backView addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    }else {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelDidClick)];
        [backView addGestureRecognizer:tapGes];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
}

- (void)setBackImageName:(NSString *)backImageName {
    if ([_backImageName isEqualToString:backImageName]) return;
    _backImageName = backImageName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:backImageName] style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
}



- (void)setHotCitys:(NSArray *)hotCitys {
    if (_hotCitys == hotCitys) return;
    _hotCitys = hotCitys;
    if (_cityDicts) {
        [_cityDicts setObject:hotCitys forKey:@"*"];
    }
}

- (NSArray *)hotCitys {
    if (!_hotCitys) {
        _hotCitys = @[@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市"];
    }
    return _hotCitys;
}

- (void)setCitys:(NSArray *)citys {
    if (_citys == citys) return;
    _citys = citys;
}

@end
