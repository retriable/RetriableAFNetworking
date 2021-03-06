//
//  ViewController.m
//  RetriableAFNetworking tvOS Example
//
//  Created by retriable on 2018/4/21.
//  Copyright © 2018年 retriable. All rights reserved.
//
@import Retriable;
@import RetriableAFNetworking;

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)AFHTTPSessionManager *sessionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [RetriableOperation setLogEnabled:YES];
    self.sessionManager=[AFHTTPSessionManager manager];
    [self.sessionManager GET:@"https://api.github.com/repos/retriable/RetriableAFNetworking/readme?n=v" headers:@{@"x-retriable-key":@"`1234567890-=\\][';/.~!@#$%^&*()_+|}{\":?><"} parameters:@{@"n1":@"v1"} progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"\nurl:%@\nheaders: %@",task.currentRequest.URL,[[task currentRequest] allHTTPHeaderFields]);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"\nurl:%@\nheaders: %@",task.currentRequest.URL,[[task currentRequest] allHTTPHeaderFields]);
    } retryAfter:^NSTimeInterval(NSInteger currentRetryTime, NSError *latestError) {
        if(![latestError.domain isEqualToString:NSURLErrorDomain]) return 0;
        switch (latestError.code) {
            case NSURLErrorTimedOut:
            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorNetworkConnectionLost: return 5;
            default: return 0;
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
