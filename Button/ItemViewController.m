//
//  ItemViewController.m
//  Button
//
//  Created by yutq on 2020/9/1.
//  Copyright © 2020 yutq. All rights reserved.
//

#import "ItemViewController.h"
#import "BookView.h"
#import "BookLayout.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ItemViewController ()

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BookLayout *layout = [[BookLayout alloc] init];
    BookView *book = [[BookView alloc] initWithFrame:CGRectMake(10, 100, 300, 500) collectionViewLayout:layout];
    [self.view addSubview:book];

}


@end
