//
//  EncryptVC.m
//  代码整合
//
//  Created by greatRong on 2016/12/26.
//  Copyright © 2016年 greatRong. All rights reserved.
//

#import "EncryptVC.h"

#import "CusMD5.h"
#import "GTMBase64.h"
#import "AESCrypt.h"

@interface EncryptVC ()

@end

@implementation EncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加密";
    
    //要加密的字符串
    NSString *strForEn = @"需要加密字符串";
    
    //md5加密
    NSString *strEnRes = [CusMD5 md5String:strForEn];
    NSLog(@"md5 加密: %@",strEnRes);
    
    //base64加密
    NSData *dataEn = [strForEn dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataEnRes = [GTMBase64 encodeData:dataEn];
    //把加密结果转成string
    NSString *base64EnRes = [[NSString alloc] initWithData:dataEnRes encoding:NSUTF8StringEncoding];
    NSLog(@"base64加密: %@",base64EnRes);
    
    //base64解密
    NSData *resDeBase64 = [GTMBase64 decodeData:dataEnRes];
    NSString *strDeBase64 = [[NSString alloc] initWithData:resDeBase64 encoding:NSUTF8StringEncoding];
    NSLog(@"base64解密: %@",strDeBase64);
    
    
    //aes 加密
    NSString *strAESEnRes = [AESCrypt encrypt:strForEn password:@"secret"];
    NSLog(@"aes 加密: %@",strAESEnRes);
    
    //aes 解密
    NSString *strAESDeRes = [AESCrypt decrypt:strAESEnRes password:@"secret"];
    NSLog(@"aes 解密: %@",strAESDeRes);
    
    // Do any additional setup after loading the view.
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
