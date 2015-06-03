//
//  OODoubleLevelMenu.h
//  test
//
//  Created by LvJianfeng on 15/6/3.
//  Copyright (c) 2015年 famnotes. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell

#import <UIKit/UIKit.h>
#import "OOCellheader.h"

@interface OODoubleLevelMenu : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy, readonly) id block;

@property(assign,nonatomic,readonly) NSInteger selectIndex;

/**
 *  左边背景颜色
 */
@property(strong,nonatomic) UIColor * leftBackgroundColor;
/**
 *  左边点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftSelectColor;
/**
 *  左边点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftSelectBackgroundColor;
/**
 *  左边未点中文字颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectColor;
/**
 *  左边未点中背景颜色
 */
@property(strong,nonatomic) UIColor * leftUnSelectBackgroundColor;
/**
 *  tablew 的分割线
 */
@property(strong,nonatomic) UIColor * leftSeparatorColor;




-(id)initWithFrame:(CGRect)frame WithData:(NSArray*)data withSelectIndex:(void(^)(NSInteger left,NSInteger right,id info))selectIndex;

@end
