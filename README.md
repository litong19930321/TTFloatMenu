# TTFloatMenu
封装了一个点击弹出的图层的菜单，使用很方便<br>
<img src="https://github.com/litong19930321/TTFloatMenu/blob/master/001.png" width="320px" />
<img src="https://github.com/litong19930321/TTFloatMenu/blob/master/002.png" width="320px" />
<img src="https://github.com/litong19930321/TTFloatMenu/blob/master/003.png" width="320px" />
<br>
使用方法：

你必须传出一个图标的数组，和一组菜单名字的数组,


```
NSArray *textArray = @[@"上传文件",@"新建文件",@"多选操作"];
NSArray *iconArray = @[@"uploadFile",@"wenjianjia",@"duoxuan"];
//创建TTFloatMenu
TTFloatMenu * menu = [[TTFloatMenu alloc] init];
menu.icons = iconArray;
menu.titles = textArray;
```
然后调用showMenu:ttButtonClick:就可以使用了，

1.如果按钮是在导航栏中，你需要传入一个大概的rect给TTFloatMenu，只有这样才能根据你传入的rect来显示菜单，比如点击导航栏右侧按钮弹出菜单栏

```
[menu showMenu:CGRectMake([UIScreen mainScreen].bounds.size.width - 70,20,60,44) ttButtonClick:^(NSInteger tag) {
       //这个回调参数为NSInteger的数值，你根据是0，1，2，3来进行相对应的后续操作
    }];

```
2.如果是在视图view中的一个继承于UIView的子控件，例如uibutton，那么你可以直接把这个button传到TTFloatView，如下

```
[menu showFromView:sender ttButtonClick:^(NSInteger tag) {
//这个回调参数为NSInteger的数值，你根据是0，1，2，3来进行相对应的后续操作
}]
```


