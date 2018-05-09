//
//  TTFloatMenu.m
//  FloatMenuView
//
//  Created by 李曈 on 16/9/13.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "TTFloatMenu.h"
#define kTTScreenWidth [UIScreen mainScreen].bounds.size.width
#define kTTScreenHeight [UIScreen mainScreen].bounds.size.height
#define TTGetWidth(obj) obj.frame.size.width
#define TTGetHeight(obj) obj.frame.size.height
#define TTGetX(obj) obj.frame.origin.x
#define TTGetY(obj) obj.frame.origin.y
#define TTGetXW(obj) obj.frame.origin.x + obj.frame.size.width
#define TTGetYH(obj) obj.frame.origin.y + obj.frame.size.height
@interface TTFloatMenu(){

}
@property (nonatomic,strong) UIImageView * menuView;

@property (nonatomic,strong) UIImageView * rowImg;

@property (nonatomic,assign) BOOL direction;// YES为向右展开  NO为向左展开

@end
@implementation TTFloatMenu

-(instancetype)init{
    self = [super init];
    _direction = YES;//默认为向右侧展开
    [self createBackView];
    return self;
}
/**
 *  布局UI
 */
-(void)createBackView{
    
    {
    self.frame = CGRectMake(0, 0,kTTScreenWidth,kTTScreenHeight);
    self.backgroundColor = [UIColor colorWithRed:0.220 green:1.000 blue:0.467 alpha:0.000];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    }
    
    {
    _menuView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"aleartBg@2x" ofType:@"png"];
    UIImage * backImg = [UIImage imageWithContentsOfFile:path];
    _menuView.image = backImg;
    _menuView.clipsToBounds = YES;
    _menuView.userInteractionEnabled = YES;
    [self addSubview:_menuView];
    _rowImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    NSString * pathrow = [[NSBundle mainBundle] pathForResource:@"sanjiao@2x" ofType:@"png"];
    UIImage * backImgrow = [UIImage imageWithContentsOfFile:pathrow];
    _rowImg.image = backImgrow;
    [self addSubview:_rowImg];
    }
}
/**
 *  创建菜单按钮
 */
-(void)createButtons{
    if ((_icons.count == _titles.count) && (_icons.count != 0)) {
        for (int i = 0; i < _icons.count; i++) {
            UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, i * 45, 120, 45);
            [button setTitle:_titles[i] forState:0];
            [button setTitleColor:[UIColor whiteColor] forState:0];
            [button setImage:[UIImage imageNamed:_icons[i]] forState:0];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            button.tag = 2000 + i;
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-10);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:1<<6];
            [_menuView addSubview:button];
        }
    }else{
        NSAssert(NO, @"必须先传入图片数组和title数组，否则无法创建button");
    }
}
/**
 *  弹出浮层菜单 并且绑定block
 *
 *  @param tagetView 点击的视图
 *  @param ttblock   用来处理点击事件的block
 */
-(void)showFromView:(UIView *)tagetView ttButtonClick:(TTButtonClick)ttblock{
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    CGRect actureRect = [tagetView convertRect:tagetView.bounds toView:window];
    return [self showMenu:actureRect ttButtonClick:ttblock];
}
/**
 *  弹出浮层菜单 并且绑定block
 *
 *  @param actureRect 点击的视图的rect（相对于当前window窗口） 适用于点击导航栏按钮
 *  @param ttblock    用来处理点击事件的block
 */
-(void)showMenu:(CGRect)actureRect ttButtonClick:(TTButtonClick)ttblock{
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    [window addSubview:self];
    _menuView.frame = CGRectMake(actureRect.origin.x,actureRect.origin.y + actureRect.size.height + 10, 0, 0);
    _rowImg.frame = CGRectMake(actureRect.origin.x + actureRect.size.width / 2 - 6,_menuView.frame.origin.y - 7, 12, 7);
    _rowImg.alpha = 0.0;
    [self createButtons];
    CGFloat shoud_x = 0;
    if (actureRect.origin.x + 110 > [UIScreen mainScreen].bounds.size.width) {
        //当右侧空间不够时  动画从右上角开始  向左下方铺开
        shoud_x = actureRect.origin.x + actureRect.size.width - 120;
        _menuView.frame = CGRectMake(actureRect.origin.x + actureRect.size.width, actureRect.origin.y + actureRect.size.height, 0, 0);
        _direction = NO;
    }else{
        _direction = YES;
        shoud_x = actureRect.origin.x;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _menuView.frame = CGRectMake(shoud_x,actureRect.origin.y + actureRect.size.height + 10, 120,_icons.count * 45);
        _rowImg.alpha = 1.0;
    } completion:^(BOOL finished) {
        NSLog(@"complete");
    }];
    _ttButtonClick = ttblock;
}

-(void)tap{
    [self selfDeleteAnimation];
}
/**
 *  按钮点击响应时间
 *
 *  @param sender 按钮
 */
-(void)buttonClick:(UIButton *)sender{
    [self selfDeleteAnimation];
    _ttButtonClick(sender.tag - 2000);
}
/**
 *  视图移除动画
 */
-(void)selfDeleteAnimation{
    CGRect old = _menuView.frame;
    CGFloat originX = 0.0f;
    _direction ? (originX = old.origin.x) : (originX = old.origin.x + old.size.width);
    [UIView animateWithDuration:0.2 animations:^{
        _menuView.frame = CGRectMake(originX,old.origin.y, 0,0);
        _rowImg.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
