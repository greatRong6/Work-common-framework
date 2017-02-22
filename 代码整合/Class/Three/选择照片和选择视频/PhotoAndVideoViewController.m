//
//  PhotoAndVideoViewController.m
//  HX_ImagePickerController
//
//  Created by 洪欣 on 16/8/31.
//  Copyright © 2016年 洪欣. All rights reserved.
//

#import "PhotoAndVideoViewController.h"
#import "HX_AddPhotoView.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface PhotoAndVideoViewController ()<HX_AddPhotoViewDelegate>

@end

@implementation PhotoAndVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    self.view.backgroundColor = [UIColor brownColor];
    
    // 选择照片和视频
    HX_AddPhotoView *addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:8 WithSelectType:SelectPhotoAndVideo];
    addPhotoView.lineNum = 4;
    addPhotoView.delegate = self;
    addPhotoView.backgroundColor = [UIColor whiteColor];
    addPhotoView.frame = CGRectMake(5, 150, width - 10, 0);
    [self.view addSubview:addPhotoView];
    
    [addPhotoView setSelectPhotos:^(NSArray *photos, BOOL iforiginal) {
        NSLog(@"photo - %@",photos);
        [photos enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 缩略图
            //            UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
            
            // 原图
            //            CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
            
            // url
            //            NSURL *url = [[asset defaultRepresentation] url];
            
        }];
    }];
    
    // 只选择视频
    HX_AddPhotoView *addVideoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:1 WithSelectType:SelectVideo];
    addVideoView.delegate = self;
    addVideoView.frame = CGRectMake(5, 400, width - 10, 0);
    addVideoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:addVideoView];
    
    [addVideoView setSelectVideo:^(NSArray *video) {
        NSLog(@"video - %@",video);
        [video enumerateObjectsUsingBlock:^(ALAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
            
            // 缩略图
            //            UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
            
            // 原图
            //            CGImageRef fullImage = [[asset defaultRepresentation] fullResolutionImage];
            
            // url
            //            NSURL *url = [[asset defaultRepresentation] url];
            
        }];
    }];
}

- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    [self.view layoutSubviews];
}


@end
