//
//  KarVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "KarVC.h"
#import "CCDraggableContainer.h"
#import "CustomCardView.h"

@interface KarVC ()<CCDraggableContainerDataSource,CCDraggableContainerDelegate>

@property (nonatomic, strong) CCDraggableContainer *container;
@property (nonatomic, strong) NSMutableArray *dataSources;

@property (strong, nonatomic) UIButton *disLikeButton;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UIButton *detailBtn;

@end

@implementation KarVC

- (void)loadUI {
    
    self.container = [[CCDraggableContainer alloc] initWithFrame:CGRectMake(0, 64, CCWidth, CCWidth) style:CCDraggableStyleUpOverlay];
    self.container.delegate = self;
    self.container.dataSource = self;
    [self.view addSubview:self.container];
    
    [self.container reloadData];
    
    UIButton *chaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chaBtn.frame = CGRectMake((CCWidth-85*3)/4, CGRectGetMaxY(self.container.frame), 85, 85);
    [chaBtn setImage:[UIImage imageNamed:@"nope"] forState:UIControlStateNormal];
    [chaBtn addTarget:self action:@selector(dislikeEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chaBtn];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake((CCWidth-85*3)/2 + 85, CGRectGetMaxY(self.container.frame), 85, 85);
    [detailBtn setImage:[UIImage imageNamed:@"userInfo"] forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(reloadDataEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailBtn];
    
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake((CCWidth-85*3)/4*3 + 170, CGRectGetMaxY(self.container.frame), 85, 85);
    [collectBtn setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
    [collectBtn addTarget:self action:@selector(likeEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collectBtn];
    
}

- (void)reloadDataEvent{
    if (self.container) {
        [self.container reloadData];
    }
}

- (void)dislikeEvent{
    [self.container removeFormDirection:CCDraggableDirectionLeft];
}

- (void)likeEvent{
    [self.container removeFormDirection:CCDraggableDirectionRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadData];
    [self loadUI];
    
    // Do any additional setup after loading the view.
}

- (void)loadData {
    
    _dataSources = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"image_%d.jpg",i + 1],
                               @"title" : [NSString stringWithFormat:@"Page %d",i + 1]};
        [_dataSources addObject:dict];
    }
}

#pragma mark - CCDraggableContainer DataSource

- (CCDraggableCardView *)draggableContainer:(CCDraggableContainer *)draggableContainer viewForIndex:(NSInteger)index {
    
    CustomCardView *cardView = [[CustomCardView alloc] initWithFrame:draggableContainer.bounds];
    [cardView installData:[_dataSources objectAtIndex:index]];
    return cardView;
}

- (NSInteger)numberOfIndexs {
    return _dataSources.count;
}

#pragma mark - CCDraggableContainer Delegate

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer draggableDirection:(CCDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio {
    
    CGFloat scale = 1 + ((kBoundaryRatio > fabs(widthRatio) ? fabs(widthRatio) : kBoundaryRatio)) / 4;
    if (draggableDirection == CCDraggableDirectionLeft) {
        self.disLikeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
    if (draggableDirection == CCDraggableDirectionRight) {
        self.likeButton.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer cardView:(CCDraggableCardView *)cardView didSelectIndex:(NSInteger)didSelectIndex {
    
    NSLog(@"点击了Tag为%ld的Card", (long)didSelectIndex);
    
}

- (void)draggableContainer:(CCDraggableContainer *)draggableContainer finishedDraggableLastCard:(BOOL)finishedDraggableLastCard {
    
    [draggableContainer reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
