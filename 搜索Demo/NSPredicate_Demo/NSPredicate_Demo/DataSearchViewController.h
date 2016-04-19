//
//  DataSearchViewController.h
//  YingYingLiCai
//
//  Created by JianYe on 13-5-31.
//  Copyright (c) 2013年 YingYing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DataSearchStateBank = 0,
} DataSearchState;

@class DataSearchViewController;
@protocol DataSearchDelegate <NSObject>

- (void)dataSearch:(DataSearchViewController *)controller
        didSelectWithObject:(id)aObject
                  withState:(DataSearchState)state;

- (void)dataSearchDidCanceled:(DataSearchViewController *)controller
                    withState:(DataSearchState)state;
@end

@interface DataSearchViewController : UIViewController

@property (nonatomic,weak)id<DataSearchDelegate> delegate;
@property (nonatomic,strong)NSString *titleString;

- (id)initWithDataList:(NSArray *)dataList state:(DataSearchState)state delegate:(id<DataSearchDelegate>)delegate;

@end
