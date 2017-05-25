//
//  NameViewController.m
//  WebTable
//
//  Created by 高山峰 on 2017/5/25.
//  Copyright © 2017年 高山峰. All rights reserved.
//

#import "NameViewController.h"
#import <Speech/Speech.h>
@interface NameViewController ()

@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开始";
    //创建本地化标识符
    NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    //创建一个语音识别对象
    SFSpeechRecognizer *sf =[[SFSpeechRecognizer alloc] initWithLocale:local];
        //3.将bundle 中的资源文件加载出来返回一个url
    NSURL *url =[[NSBundle mainBundle] URLForResource:@"游子吟.mp3" withExtension:nil];
    //4.将资源包中获取的url 传递给 request 对象
    SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    //5.发送一个请求
    [sf recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error!=nil) {
            NSLog(@"语音识别解析失败,%@",error);
        }
        else
        {
            //解析正确
            NSLog(@"---%@",result.bestTranscription.formattedString);
        }
    }];
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
