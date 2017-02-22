//
//  WebViewVC.m
//  代码整合
//
//  Created by greatRong on 2017/2/20.
//  Copyright © 2017年 greatRong. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()<NSURLConnectionDelegate,UIWebViewDelegate>

@property (nonatomic,strong)NSURLConnection *connection;

@end

@implementation WebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://res.yunmodel.com/hybrid/group.html"]];
    [self.view addSubview: webView];

    
    NSString *paramURLAsString= @"http://res.yunmodel.com/jump/badgeright.html";
    if ([paramURLAsString length] == 0){
        NSLog(@"Nil or empty URL is given");
        return;
    }
    
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    
    /* 设置缓存的大小为1M*/
    [urlCache setMemoryCapacity:1*1024*1024];
    
    //创建一个nsurl
    NSURL *url = [NSURL URLWithString:paramURLAsString];
    //创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    //从请求中获取缓存输出
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
    //判断是否有缓存
    if (response != nil){
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    [webView loadRequest:request];

    self.connection = nil;
    /* 创建NSURLConnection*/
    NSURLConnection *newConnection = [[NSURLConnection alloc] initWithRequest:request
                                    delegate:self
                            startImmediately:YES];
    self.connection = newConnection;
    
    // Do any additional setup after loading the view.
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"将接收输出");
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse{
    NSLog(@"即将发送请求");
    return(request);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"接受数据");
    NSLog(@"数据长度为 = %lu", (unsigned long)[data length]);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    return (cachedResponse);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"请求完成");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
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
