//
//  SelectPicVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "SelectPicVC.h"

@interface SelectPicVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SelectPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择照片,拍照,视频";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(20, self.view.frame.size.height/2, self.view.frame.size.width/2-40, 50);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    
    // Do any additional setup after loading the view.
}

-(void)click{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self photo];
    }];
    
    UIAlertAction *xiangji = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    UIAlertAction *localvideo = [UIAlertAction actionWithTitle:@"本地视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self locallVideo];
    }];
    UIAlertAction *shotvideo = [UIAlertAction actionWithTitle:@"拍摄视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shotVideo];
    }];
    
    
    [alertController addAction:okAction];
    [alertController addAction:xiangji];
    [alertController addAction:localvideo];
    [alertController addAction:shotvideo];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    

}

//相册
- (void)photo
{
    /**
     
     UIImagePickerControllerSourceTypePhotoLibrary ,//来自图库
     UIImagePickerControllerSourceTypeCamera ,//来自相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //来自相册
     */
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}
//相机
- (void)camera
{
    //判断是否可以打开相机，模拟器此功能无法使用
    if (![UIImagePickerController isSourceTypeAvailable:
          
          UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.allowsEditing = YES;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

//本地视频
- (void)locallVideo
{
    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    
    imgPickerCtrl.delegate = self;
    
    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //自定媒体类型
    imgPickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
    
}

//拍摄视频
- (void)shotVideo
{
    UIImagePickerController *imgPickerCtrl = [[UIImagePickerController alloc] init];
    
    imgPickerCtrl.delegate = self;
    
    imgPickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imgPickerCtrl.mediaTypes = @[@"public.movie"];
    
    [self presentViewController:imgPickerCtrl animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    /**
     
     选取的信息都在info中，info 是一个字典。
     字典中的键：
     NSString *const  UIImagePickerControllerMediaType ;指定用户选择的媒体类型（文章最后进行扩展）
     NSString *const  UIImagePickerControllerOriginalImage ;原始图片
     NSString *const  UIImagePickerControllerEditedImage ;修改后的图片
     NSString *const  UIImagePickerControllerCropRect ;裁剪尺寸
     NSString *const  UIImagePickerControllerMediaURL ;媒体的URL
     NSString *const  UIImagePickerControllerReferenceURL ;原件的URL
     NSString *const  UIImagePickerControllerMediaMetadata;当来数据来源是照相机的时候这个值才有效
     
     
     */
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        //如果是拍摄的照片
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //保存在相册
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
        
        //添加imgView点击事件
        //        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xuanze)];
        
        //        [imgView addGestureRecognizer:tap];
        
        //        imgView.userInteractionEnabled = YES;
        
        imgView.image = image;
        
        imgView.layer.cornerRadius = imgView.frame.size.width / 2;
        
        imgView.clipsToBounds = YES;
        
        [self.view addSubview:imgView];
        
    }
    else if ([mediaType isEqualToString:@"public.movie"])
    {
        //获取视图的url
        NSURL *url = [info objectForKey:UIImagePickerControllerReferenceURL];
        //播放视频
        NSLog(@"%@",url);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
