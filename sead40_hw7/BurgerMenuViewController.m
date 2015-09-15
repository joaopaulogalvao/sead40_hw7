//
//  BurgerMenuViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "BurgerMenuViewController.h"

CGFloat const kburgerOpenScreenDivider = 3.0;
CGFloat const kburgerOpenScreenMultiplier = 2.0;
NSTimeInterval const ktimeToSlideMenuOpen = 0.3;
CGFloat const kburgerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;

@interface BurgerMenuViewController ()<UITableViewDelegate>

@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  UITableViewController *mainMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
  mainMenuViewController.tableView.delegate = self;
  
  [self addChildViewController:mainMenuViewController];
  mainMenuViewController.view.frame = self.view.frame;
  [self.view addSubview:mainMenuViewController.view];
  [mainMenuViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
