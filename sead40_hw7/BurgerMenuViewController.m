//
//  BurgerMenuViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "BurgerMenuViewController.h"
#import "QuestionSearchViewController.h"

CGFloat const kburgerOpenScreenDivider = 3.0;
CGFloat const kburgerOpenScreenMultiplier = 2.0;
NSTimeInterval const ktimeToSlideMenuOpen = 0.3;
CGFloat const kburgerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;

@interface BurgerMenuViewController ()<UITableViewDelegate>

@property (strong,nonatomic) UIViewController *topViewController;
@property (strong,nonatomic) UIButton *burgerButton;
@property (strong,nonatomic) UIPanGestureRecognizer *pan;
@property (strong,nonatomic) NSArray *viewControllers;

@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  //Instantiate the main menu
  UITableViewController *mainMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
  mainMenuViewController.tableView.delegate = self;
  
  //Add it as a child view controller
  [self addChildViewController:mainMenuViewController];
  mainMenuViewController.view.frame = self.view.frame;
  [self.view addSubview:mainMenuViewController.view];
  [mainMenuViewController didMoveToParentViewController:self];
  
  //Instantiate the question search
  QuestionSearchViewController *questionSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionSearch"];
  
  //Instantiate my questions view
  
  //MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestions"];
  
  
  //Add both views to a view controllers array
  self.viewControllers = @[questionSearchVC];
  
  //Add question search as a child of the burger view controller
  [self addChildViewController:questionSearchVC];
  
  //Set question search's frame
  questionSearchVC.view.frame = self.view.frame;
  
  //Add question search view as a subview of the burger view Controller
  [self.view addSubview:questionSearchVC.view];
  
  //Inform the delegate that question Search moved to its parent view controller
  [questionSearchVC didMoveToParentViewController:self];
  
  //Make question search the view at the top
  self.topViewController = questionSearchVC;
  
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
