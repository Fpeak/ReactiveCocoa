//
//  TableViewCell.m
//  WebTable
//
//  Created by 高山峰 on 2017/5/20.
//  Copyright © 2017年 高山峰. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSLog(@"%@",NSStringFromCGRect(self.contentView.bounds));
        
        // 高度必须提前赋一个值 >0
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.userInteractionEnabled = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.delegate = self;
        self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
        self.webView.scalesPageToFit = YES;
        [self.contentView addSubview:self.webView];
    }
    return self;
}

// contentStr 用于更新值
-(void)setContentStr:(NSString *)contentStr
{
    _contentStr = contentStr;
    
    [self.webView loadHTMLString:contentStr baseURL:[NSURL URLWithString:@"http://www.baidu.com"]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 方法一
    CGSize fittingSize = [self.webView sizeThatFits:CGSizeZero];
    // 方法二
    NSLog(@"webView:%@",NSStringFromCGSize(fittingSize));
    self.height = fittingSize.height;
    
    self.webView.frame = CGRectMake(0, 0, fittingSize.width, fittingSize.height);
    
    // 用通知发送加载完成后的高度
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WEBVIEW_HEIGHT" object:self userInfo:nil];
}
@end
