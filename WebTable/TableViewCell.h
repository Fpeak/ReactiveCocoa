//
//  TableViewCell.h
//  WebTable
//
//  Created by 高山峰 on 2017/5/20.
//  Copyright © 2017年 高山峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell<UIWebViewDelegate>

@property (nonatomic,strong) NSString *contentStr;
@property (nonatomic,assign) CGFloat height;
@property (strong, nonatomic) UIWebView *webView;
@end
