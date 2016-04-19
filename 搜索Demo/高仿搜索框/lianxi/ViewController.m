//
//  ViewController.m
//  lianxi
//
//  Created by Interest on 15/12/16.
//  Copyright © 2015年 Interest. All rights reserved.
//

#import "ViewController.h"

#define inputW  24
#define imgSearchW  12


@interface ViewController ()<UITextFieldDelegate>
{
    UITextField *searchField;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    //添加输入框
    [self inputTextField];
    
    //监听
    [self notificationCenterAction];
    
    
    //不搜索状态
    [self hiddenSearchAnimation];
}


//************************监听事件************************
#pragma mark - 监听键盘的事件
-(void) notificationCenterAction
{
    //监听键盘的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

#pragma mark - 屏幕的伸缩
//键盘升起时动画
- (void)keyboardWillShow:(NSNotification*)notif
{
    //动态提起整个屏幕
    [UIView animateWithDuration:4 animations:^{
        
        [self searchAnimation];
        
    } completion:nil];
}

//键盘关闭时动画
- (void)keyboardWillHide:(NSNotification*)notif
{
    
    [UIView animateWithDuration:4 animations:^{
        
      [self hiddenSearchAnimation];
        
    } completion:nil];
}


//************************输入框事件************************
-(void) inputTextField
{
    //****************************搜索框*****************************
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 60, self.view.frame.size.width - 30, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    _nameTextField.placeholder = @"请输入地址";
    //设置输入框内容的字体样式和大小
    _nameTextField.font = [UIFont fontWithName:@"Arial" size:16.0f];
    _nameTextField.textColor  = [UIColor blackColor];
    //    _nameTextField.textAlignment = UITextAlignmentCenter;
    _nameTextField.delegate = self;
    //*******************************************************
    [self.view addSubview:_nameTextField];

}


//************************动态事件************************
//显示搜索状态
-(void) searchAnimation
{
    self.inputView = [[UIView alloc] init];
    self.inputView.frame= CGRectMake(0, 0 ,inputW , inputW);
 
    
    
    self.imgSearch = [[UIImageView alloc] init];
    self.imgSearch.image = [UIImage imageNamed:@"搜索"];
    CGRect rx = CGRectMake( 12,(inputW - imgSearchW)/2 , imgSearchW, imgSearchW);
    self.imgSearch.frame = rx;
    
    
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
 

}
//显示隐藏状态
-(void) hiddenSearchAnimation
{
    self.inputView = [[UIView alloc] init];
    CGFloat textFieldW = (_nameTextField.frame.size.width) / 2 - 30;
    self.inputView.frame= CGRectMake(0, 0 ,textFieldW , inputW);
   
    
    
    
    self.imgSearch = [[UIImageView alloc] init];
    self.imgSearch.image = [UIImage imageNamed:@"搜索"];
    CGRect rx = CGRectMake( textFieldW -12 , (inputW - imgSearchW)/2 , imgSearchW, imgSearchW);
    self.imgSearch.frame = rx;
    
    
    [self.inputView addSubview:self.imgSearch];
    // 把leftVw设置给文本框
    _nameTextField.leftView = self.inputView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
   
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    NSLog(@"*******%@",_nameTextField.text);
}


//-(UIImage *) imgSearch:(NSInteger *) imgX
//{
//    UIImageView *imgSearch = [[UIImageView alloc] init];
//    imgSearch.image = [UIImage imageNamed:@"搜索"];
//    
//    CGRect rx = CGRectMake( 12,(inputW - imgSearchW)/2 , imgSearchW, imgSearchW);
//    imgSearch.frame = rx;
//    
//    return imgSearch;
//
//}
//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end













// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com