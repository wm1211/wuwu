//
//  DataSearchViewController.m
//  YingYingLiCai
//
//  Created by JianYe on 13-5-31.
//  Copyright (c) 2013年 YingYing. All rights reserved.
//

#import "DataSearchViewController.h"
#import "Bank.h"

@interface DataSearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)IBOutlet UISearchBar *searchBar;
@property (nonatomic,strong)IBOutlet UITableView *contentView;
@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)NSArray *data;
@property (nonatomic,strong)NSArray *dataHold;

@property (nonatomic,assign)BOOL scrollTag;
@property (nonatomic,assign)DataSearchState searchState;
@end

@implementation DataSearchViewController
@synthesize searchBar = _searchBar;
@synthesize contentView = _contentView;
@synthesize data = _data;
@synthesize dataHold = _dataHold;
@synthesize delegate = _delegate;
@synthesize scrollTag = _scrollTag;
@synthesize searchState = _searchState;
@synthesize titleLabel = _titleLabel;
@synthesize titleString = _titleString;
- (void)dealloc {
    self.delegate = nil;
}

- (id)initWithDataList:(NSArray *)dataList
                 state:(DataSearchState)state
              delegate:(id<DataSearchDelegate>)delegate
{
    self = [super initWithNibName:@"DataSearchViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.data = [NSArray arrayWithArray:dataList];
        self.dataHold = [NSArray arrayWithArray:dataList];
        self.delegate = delegate;
        self.searchState = state;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (IBAction)cancel:(id)sender
{
    if ([_delegate respondsToSelector:@selector(dataSearchDidCanceled:withState:)]) {
        [_delegate dataSearchDidCanceled:self withState:_searchState];
    }
}

- (void)loadView
{
    [super loadView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.title = @"模糊搜索";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
    
    if (_titleString) {
        _titleLabel.text = _titleString;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**< 清除searchbar的背景*/
//    for (UIView *subview in self.searchBar.subviews) {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            UIView *bg = [[UIView alloc] initWithFrame:subview.frame];
//            bg.backgroundColor = [UIColor colorWithWhite:0.09 alpha:1];
//            [self.searchBar insertSubview:bg aboveSubview:subview];
//            [subview removeFromSuperview];
//            break;
//        }
//    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DataSearchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    NSDictionary *dic = [_data objectAtIndex:indexPath.row];
    
    
    if (_searchState == DataSearchStateBank) {
        Bank *bank = [[Bank alloc] initWithDictionary:dic];
        cell.textLabel.text = bank.name;
    }   
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if ([_delegate respondsToSelector:@selector(dataSearch:didSelectWithObject:withState:)]) {
        [_delegate dataSearch:self didSelectWithObject:[_data objectAtIndex:indexPath.row] withState:_searchState];
    }
}

#pragma mark -
#pragma mark search bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    if ([searchText isEqualToString:@""]) {
        self.data = _dataHold;
        [_contentView reloadData];
        return;
    }
    
    NSString *keyName = @"";
    if (_searchState == DataSearchStateBank) {
        keyName = [Bank keyName];
    }
    /**< 模糊查找*/
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", keyName, searchText];
    /**< 精确查找*/
//  NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", keyName, searchText];
    
    NSLog(@"predicate %@",predicateString);
    
    NSMutableArray  *filteredArray = [NSMutableArray arrayWithArray:[_dataHold filteredArrayUsingPredicate:predicateString]];
    
    self.data = filteredArray;
    [_contentView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}
@end
