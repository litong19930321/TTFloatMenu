//
//  TTFloatMenu.h
//  FloatMenuView
//
//  Created by 李曈 on 16/9/13.
//  Copyright © 2016年 lt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TTButtonClick)(NSInteger tag);


@interface TTFloatMenu : UIView
/**
 *  图标数组
 */
@property (nonatomic,strong) NSArray * icons;
/**
 *  按钮的title数组
 */
@property (nonatomic,strong) NSArray * titles;
/**
 *  按钮点击的block
 */
@property (nonatomic,copy) TTButtonClick ttButtonClick;
/**
 *  弹出浮层菜单 并且绑定block
 *
 *  @param tagetView 点击的视图
 *  @param ttblock   用来处理点击事件的block
 */
-(void)showFromView:(UIView *)tagetView ttButtonClick:(TTButtonClick)ttblock;
/**
 *  弹出浮层菜单 并且绑定block
 *
 *  @param actureRect 点击的视图的rect（相对于当前window窗口） 适用于点击导航栏按钮
 *  @param ttblock    用来处理点击事件的block
 */
-(void)showMenu:(CGRect)actureRect ttButtonClick:(TTButtonClick)ttblock;
@end
