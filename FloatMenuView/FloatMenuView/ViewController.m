//
//  ViewController.m
//  FloatMenuView
//
//  Created by 李曈 on 16/9/13.
//  Copyright © 2016年 lt. All rights reserved.
//

#import "ViewController.h"
#import "TTFloatMenu.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"菜单" forState:1<<6];
    [button setTitleColor:[UIColor whiteColor] forState:0];
    button.frame = CGRectMake(150,200, 60, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:1<<6];
    [self.view addSubview:button];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemCLick)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIBarButtonItem * itemR = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(itemCLickR)];
    self.navigationItem.rightBarButtonItem = itemR;

}
-(void)itemCLickR{
    NSArray *textArray = @[@"上传文件",@"新建文件",@"多选操作"];
    NSArray *iconArray = @[@"uploadFile",@"wenjianjia",@"duoxuan"];
    
    TTFloatMenu * menu = [[TTFloatMenu alloc] init];
    menu.icons = iconArray;
    menu.titles = textArray;
    
    [menu showMenu:CGRectMake([UIScreen mainScreen].bounds.size.width - 70,20,60,44) ttButtonClick:^(NSInteger tag) {
        switch (tag) {
            case 0:
                NSLog(@"上传文件");
                [self showAlert:@"上传文件"];
                break;
            case 1:
                NSLog(@"新建文件");
                [self showAlert:@"新建文件"];
                break;
            case 2:
                NSLog(@"多选操作");
                [self showAlert:@"多选操作"];
                break;
            default:
                break;
        }
    }];
}
-(void)itemCLick{
    NSArray *textArray = @[@"上传文件",@"新建文件",@"多选操作"];
    NSArray *iconArray = @[@"uploadFile",@"wenjianjia",@"duoxuan"];
    TTFloatMenu * menu = [[TTFloatMenu alloc] init];
    menu.icons = iconArray;
    menu.titles = textArray;
    [menu showMenu:CGRectMake(12,20,60,44) ttButtonClick:^(NSInteger tag) {
        switch (tag) {
            case 0:
                NSLog(@"上传文件");
                [self showAlert:@"上传文件"];
                break;
            case 1:
                NSLog(@"新建文件");
                [self showAlert:@"新建文件"];
                break;
            case 2:
                NSLog(@"多选操作");
                [self showAlert:@"多选操作"];
                break;
            default:
                break;
        }
    }];
}
-(void)buttonClick:(UIButton *)sender{
    UIWindow * window = [[UIApplication sharedApplication].windows lastObject];
    CGRect rect2 = [sender convertRect:sender.bounds toView:window];
    NSLog(@"--button%@",NSStringFromCGRect(rect2));
    NSArray *textArray = @[@"上传文件",@"新建文件",@"多选操作"];
    NSArray *iconArray = @[@"uploadFile",@"wenjianjia",@"duoxuan"];
    TTFloatMenu * menu = [[TTFloatMenu alloc] init];
    menu.icons = iconArray;
    menu.titles = textArray;
    [menu showFromView:sender ttButtonClick:^(NSInteger tag) {
        switch (tag) {
            case 0:
                NSLog(@"上传文件");
                [self showAlert:@"上传文件"];
                break;
            case 1:
                NSLog(@"新建文件");
                [self showAlert:@"新建文件"];
                break;
            case 2:
                NSLog(@"多选操作");
                [self showAlert:@"多选操作"];
                break;
            default:
                break;
        }
    }];
}

-(void)showAlert:(NSString *)title{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
