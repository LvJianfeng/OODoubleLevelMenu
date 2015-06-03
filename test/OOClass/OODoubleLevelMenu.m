//
//  OODoubleLevelMenu.m
//  test
//
//  Created by LvJianfeng on 15/6/3.
//  Copyright (c) 2015年 famnotes. All rights reserved.
//
//  https://github.com/LvJianfeng
//  http://weibo.com/aaalizzwell

#import "OODoubleLevelMenu.h"

#define AreaCellIdentifier @"AreaCell"
#define SpaceCellIdentifier @"SpaceCell"

@interface OODoubleLevelMenu()
{
@private NSArray* dataArray;
}
@property (nonatomic, strong) UITableView* leftTableView;
@property (nonatomic, strong) UITableView* rightTableView;
@end

@implementation OODoubleLevelMenu
- (id)initWithFrame:(CGRect)frame WithData:(NSArray *)data withSelectIndex:(void (^)(NSInteger, NSInteger, id))selectIndex
{
    if (self == [super initWithFrame:CGRectMake(0, 70, OOScreenWidth, OOScreenHeight-70)]) {
        if (data.count==0) {
            return nil;
        }
        
        _block = selectIndex;

        self.leftSelectColor = JFCovertColor(128, 189, 232);
        self.leftSelectBackgroundColor = [UIColor whiteColor];
        self.leftBackgroundColor = JFCovertColor(221, 224, 228);
        self.leftUnSelectColor = JFCovertColor(99, 119, 132);
        self.leftUnSelectBackgroundColor = JFCovertColor(221, 224, 228);

        _selectIndex = 0;
        
        dataArray = data;
        
        /*
         * leftTableView
         */
        self.leftTableView = [[UITableView alloc] initWithFrame:frame];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
        self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.leftTableView.showsVerticalScrollIndicator = NO;
        [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OOAreaTableCell class]) bundle:nil] forCellReuseIdentifier:AreaCellIdentifier];
        [self addSubview:self.leftTableView];
        UIView *view =[ [UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        [self.leftTableView setTableFooterView:view];
        [self.leftTableView setTableHeaderView:view];
        
        /*
         * reightTableView
         */
        self.rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width, frame.origin.y, OOScreenWidth-frame.size.width, frame.size.height)];
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([OOSpaceTableCell class]) bundle:nil] forCellReuseIdentifier:SpaceCellIdentifier];
        
        [self addSubview:self.rightTableView];
        if ([self.rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            self.rightTableView.layoutMargins=UIEdgeInsetsZero;
        }
        if ([self.rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            self.rightTableView.separatorInset=UIEdgeInsetsZero;
        }
        [self.rightTableView setTableFooterView:view];
        [self.rightTableView setTableHeaderView:view];
        
        if (dataArray.count>0) {
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
    return self;
}

#pragma mark--deleagte
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return dataArray.count;
    }
    return 20;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        OOAreaTableCell *leftCell=[self.leftTableView dequeueReusableCellWithIdentifier:AreaCellIdentifier forIndexPath:indexPath];
        leftCell.selectionStyle=UITableViewCellSelectionStyleNone;
        leftCell.areaNameLabel.text = dataArray[indexPath.row];
        
        if (indexPath.row == self.selectIndex) {
            leftCell.areaNameLabel.textColor = self.leftSelectColor;
            leftCell.backgroundColor = self.leftSelectBackgroundColor;
        }else{
            leftCell.areaNameLabel.textColor = self.leftUnSelectColor;
            leftCell.backgroundColor = self.leftUnSelectBackgroundColor;
        }
        return leftCell;
    }
    
    if (tableView == self.rightTableView) {
        OOSpaceTableCell *rightCell = [self.rightTableView dequeueReusableCellWithIdentifier:SpaceCellIdentifier forIndexPath:indexPath];
        rightCell.spaceNameLabel.text = @"选中了在刷新这边";
        
        if ([rightCell respondsToSelector:@selector(setLayoutMargins:)]) {
            [rightCell setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([rightCell respondsToSelector:@selector(setSeparatorInset:)]) {
            [rightCell setSeparatorInset:UIEdgeInsetsZero];
        }
        return rightCell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        OOAreaTableCell *areaCell = (OOAreaTableCell*)[self.leftTableView cellForRowAtIndexPath:indexPath];
        areaCell.areaNameLabel.textColor = self.leftSelectColor;
        areaCell.backgroundColor = self.leftSelectBackgroundColor;
        _selectIndex = indexPath.row;
        
        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        OOAreaTableCell *areaCell = (OOAreaTableCell*)[self.leftTableView cellForRowAtIndexPath:indexPath];
        areaCell.areaNameLabel.textColor = self.leftUnSelectColor;
        areaCell.backgroundColor = self.leftUnSelectBackgroundColor;
    }
}

#pragma mark setter
- (void)setLeftBackgroundColor:(UIColor *)leftBackgroundColor
{
    _leftBackgroundColor = leftBackgroundColor;
    self.leftTableView.backgroundColor = leftBackgroundColor;
}

- (void)setLeftSelectBackgroundColor:(UIColor *)leftSelectBackgroundColor
{
    _leftSelectBackgroundColor = leftSelectBackgroundColor;
    self.backgroundColor = leftSelectBackgroundColor;
}
@end
