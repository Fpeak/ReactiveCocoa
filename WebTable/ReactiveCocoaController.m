//
//  ReactiveCocoaController.m
//  WebTable
//
//  Created by 高山峰 on 2017/5/22.
//  Copyright © 2017年 高山峰. All rights reserved.
//

#import "ReactiveCocoaController.h"
#import "ReactiveObjC.h"
@interface ReactiveCocoaController ()
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UITextField *userPass;
@property (weak, nonatomic) IBOutlet UITextField *confirmPass;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation ReactiveCocoaController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听输入
    [self.userPass.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"text = %@",x);
    }];
    //只关心超过3个字符长度的用户名
    [[self.userPass.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        NSString *text = value;
        return text.length > 3;
    }]
     subscribeNext:^(NSString * _Nullable x) {
         NSLog(@"---%@",x);
     }];
    
//   [[[self.userPass.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
//       return @(value.length);
//    }]filter:^BOOL(id  _Nullable value) {
//        return [value integerValue] >3;
//    }]subscribeNext:^(id  _Nullable x) {
//        NSLog(@"length = %@",x);
//    }];
    
    //创建一些信号,来表示用户名和密码输入框中的输入内容是否有效
    RACSignal *validUserPassSignal = [self.userPass.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self isValidUsername:value]);
    }];
    RACSignal *validConfirmPassSign = [self.confirmPass.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self isValidPassword:value]);
    }];
    
    //转换信号,从而能为输入框设置不同的背景颜色
    [[validUserPassSignal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }]subscribeNext:^(id  _Nullable x) {
        self.userPass.backgroundColor = x;
    }];
    [[validConfirmPassSign map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor]:[UIColor redColor];
    }]subscribeNext:^(id  _Nullable x) {
        self.confirmPass.backgroundColor = x;
    }];
    // 宏来更好的完成上面的事情
//    RAC(self.passwordTF, backgroundColor) = [validUserPassSignal map:^id _Nullable(id  _Nullable value) {
//        
//        return [value boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//    }];
//    
//    RAC(self.userNameTF, backgroundColor) = [validConfirmPassSign map:^id _Nullable(id  _Nullable value) {
//        return [value boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//    }];
    //聚合信号,登录按钮只有当用户名和密码输入框的输入都有效时才工作
    RACSignal *signUpActionSignal = [RACSignal combineLatest:@[validUserPassSignal,validConfirmPassSign] reduce:^id(NSNumber *userPassValid,NSNumber *comfirmPass){
        return @([userPassValid boolValue] &&[comfirmPass boolValue]);
    }];
    [signUpActionSignal subscribeNext:^(id  _Nullable x) {
        self.sureBtn.enabled = [x boolValue];
    }];
    //点击按钮的触发
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"button click --");
    }];
    
}

-(BOOL)isValidUsername:(NSString *)userPass{
    return userPass.length <3;
}

-(BOOL)isValidPassword:(NSString *)confirmPass{
    return confirmPass.length<3;
}


@end
