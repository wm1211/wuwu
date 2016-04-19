//
//  ViewController.m
//  NSPredicate_Demo
//
//  Created by JianYe on 13-7-22.
//  Copyright (c) 2013年 YingYing. All rights reserved.
//

#import "ViewController.h"
#import "DataSearchViewController.h"
#import "JSONKit.h"
#import "Bank.h"
#define DocumentPaths  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)//Document文件路径
#define CacehFileName(_x) [[DocumentPaths objectAtIndex:0]stringByAppendingPathComponent:_x]

@interface ViewController ()<UITextFieldDelegate,DataSearchDelegate>

@property (nonatomic,strong)IBOutlet UITextField *searchField;
@property (nonatomic,strong)IBOutlet UILabel *codeLabel;
@end

@implementation ViewController
@synthesize searchField = _searchField;
@synthesize codeLabel = _codeLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - text field delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self beginSearch:nil];
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


- (void)beginSearch:(id)sender
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"banks" ofType:@"txt"];
    NSArray *banks = [NSArray arrayWithContentsOfFile:path];
    DataSearchViewController *search = [[DataSearchViewController alloc] initWithDataList:banks state:DataSearchStateBank delegate:self];
    search.titleString = @"银行搜索";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:search];
    [self presentViewController:nav animated:YES completion:^{}];
}

- (void)dataSearch:(DataSearchViewController *)controller didSelectWithObject:(id)aObject
         withState:(DataSearchState)state
{
    Bank *bank = [[Bank alloc] initWithDictionary:aObject];
    _searchField.text = bank.name;
    _codeLabel.text = [NSString stringWithFormat:@"编号:%@",bank.code];
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)dataSearchDidCanceled:(DataSearchViewController *)controller
                    withState:(DataSearchState)state
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}
@end
