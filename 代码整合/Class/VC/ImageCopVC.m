//
//  ImageCopVC.m
//  代码整合
//
//  Created by greatRong on 2017/3/3.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#import "ImageCopVC.h"
#import "TOCropViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface ImageCopVC () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, TOCropViewControllerDelegate>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@property (nonatomic, strong) UIPopoverController *activityPopoverController;
#pragma clang diagnostic pop

- (void)showCropViewController;
- (void)sharePhoto;

- (void)layoutImageView;
- (void)didTapImageView;


@end

@implementation ImageCopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图片裁剪";
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCropViewController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(sharePhoto)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView)];
    [self.imageView addGestureRecognizer:tapRecognizer];

    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}

- (void)layoutImageView
{
    
    if (self.imageView.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= ((padding * 2.0f));
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.imageView.image.size;
    
    CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
    imageFrame.size.width *= scale;
    imageFrame.size.height *= scale;
    imageFrame.origin.x = (CGRectGetWidth(self.view.bounds) - imageFrame.size.width) * 0.5f;
    imageFrame.origin.y = (CGRectGetHeight(self.view.bounds) - imageFrame.size.height) * 0.5f;
    self.imageView.frame = imageFrame;
    
}

#pragma mark - Bar Button Items -
- (void)showCropViewController
{
    UIImagePickerController *photoPickerController = [[UIImagePickerController alloc] init];
    photoPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPickerController.allowsEditing = NO;
    photoPickerController.delegate = self;
    [self presentViewController:photoPickerController animated:YES completion:nil];
}

- (void)sharePhoto
{
    if (self.imageView.image == nil)
        return;
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image] applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityController animated:YES completion:nil];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self.activityPopoverController dismissPopoverAnimated:NO];
        self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityController];
        [self.activityPopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#pragma clang diagnostic pop
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
//    [lib writeImageToSavedPhotosAlbum:self.imageView.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        
//        NSLog(@"assetURL = %@, error = %@", assetURL, error);
//        lib = nil;
//        
//    }];
    
    __block NSString *createdAssetID =nil;//唯一标识，可以用于图片资源获取
    NSError *error =nil;
    [[PHPhotoLibrary sharedPhotoLibrary]performChangesAndWait:^{
        createdAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];

}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    //图片剪裁之后获取的图片
    self.imageView.image = image;
    [self layoutImageView];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    CGRect viewFrame = [self.view convertRect:self.imageView.frame toView:self.navigationController.view];
    self.imageView.hidden = YES;
    [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
        self.imageView.hidden = NO;
    }];
}

#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //进入图片裁剪
    [self dismissViewControllerAnimated:YES completion:^{
        self.image = image;
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:image];
        cropController.delegate = self;
        
        // Uncomment this to test out locked aspect ratio sizes
         cropController.defaultAspectRatio = TOCropViewControllerAspectRatio4x3;
         cropController.aspectRatioLocked = NO;
        
        cropController.rotateButtonsHidden = NO;
        cropController.aspectRatioLocked = NO;
        
        // Uncomment this to place the toolbar at the top of the view controller
         cropController.toolbarPosition = TOCropViewControllerToolbarPositionBottom;
        
        [self presentViewController:cropController animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //返回阿牛cancel
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gesture Recognizer -  对图片进行编辑
- (void)didTapImageView
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:self.image];
    cropController.delegate = self;
    
    // Uncomment this to place the toolbar at the top of the view controller
    // cropController.toolbarPosition = TOCropViewControllerToolbarPositionTop;
    
    [self presentViewController:cropController animated:YES completion:nil];
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
