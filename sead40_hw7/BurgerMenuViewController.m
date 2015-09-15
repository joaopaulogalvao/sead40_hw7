//
//  BurgerMenuViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "BurgerMenuViewController.h"
#import "QuestionSearchViewController.h"
#import "MyQuestionsViewController.h"

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
  
  MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestions"];
  
  
  //Add both views to a view controllers array
  self.viewControllers = @[questionSearchVC,myQuestionsVC];
  
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
  
  //Add the burger button
  UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kburgerButtonWidth, kburgerButtonHeight)];
  [burgerButton setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
  [self.topViewController.view addSubview:burgerButton];
  [burgerButton addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  self.burgerButton = burgerButton;
  
  //Add a pan gesture
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topViewControllerPanned:)];
  [self.topViewController.view addGestureRecognizer:pan];
  self.pan = pan;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - My actions

-(void)burgerButtonPressed:(UIButton *)sender {
  [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
    self.topViewController.view.center = CGPointMake(self.view.center.x * kburgerOpenScreenMultiplier, self.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
    [self.topViewController.view addGestureRecognizer:tap];
    sender.userInteractionEnabled = false;
    
  }];
}

-(void)topViewControllerPanned: (UIPanGestureRecognizer *)sender {
  
  // Get the velocity
  CGPoint velocity = [sender velocityInView:self.topViewController.view];
  
  // Get the translation movement point
  CGPoint translation = [sender translationInView:self.topViewController.view];
  
  // Make the view move on x only, if the velocity is greater than zero
  if (sender.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
      [sender setTranslation:CGPointZero inView:self.topViewController.view];
    } else {
      
      NSLog(@"Velocity: %f", velocity.x);
      NSLog(@"Translation: %f", translation.x);
      self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
      [sender setTranslation:CGPointZero inView:self.topViewController.view];
    }
  }
  
  // Check when the movement ends
  if (sender.state == UIGestureRecognizerStateEnded) {
    if (self.topViewController.view.frame.origin.x > self.topViewController.view.frame.size.width / kburgerOpenScreenDivider) {
      NSLog(@"user is opening menu");
      
      // Animate the view's movement
      [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        
        //After passing a third of the screen animate to a nice point by multiplying by the constant
        self.topViewController.view.center = CGPointMake(self.view.center.x * kburgerOpenScreenMultiplier, self.topViewController.view.center.y);
      } completion:^(BOOL finished) {
        
        // Add the gesture after the animation is finished, so you can tap to close again
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.topViewController.view addGestureRecognizer:tap];
        self.burgerButton.userInteractionEnabled = false;
        
      }];
      
      //Make an else telling the view to close
    } else {
      [UIView animateWithDuration:ktimeToSlideMenuOpen animations:^{
        self.topViewController.view.center = CGPointMake(self.view.center.x, self.topViewController.view.center.y);
      } completion:^(BOOL finished) {
        
      }];
    }
  }
  
}

-(void)tapToCloseMenu:(UITapGestureRecognizer *)tap {
  
  //Remove the tap
  [self.topViewController.view removeGestureRecognizer:tap];
  
  //Animate it back to the old center
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    
    //Remove the button interaction 
    self.burgerButton.userInteractionEnabled = true;
    
  }];
}

-(void)switchToViewController:(UIViewController *)newVC{
  [UIView animateWithDuration:0.3 animations:^{
    
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width,self.topViewController.view.frame.origin.y,self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
    
  } completion:^(BOOL finished) {
    CGRect oldFrame = self.topViewController.view.frame;
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    
    [self addChildViewController:newVC];
    newVC.view.frame = oldFrame;
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    self.topViewController = newVC;
    
    [self.burgerButton removeFromSuperview];
    [self.topViewController.view addSubview:self.burgerButton];
    
    
    [UIView animateWithDuration:0.3 animations:^{
      self.topViewController.view.center = self.view.center;
    } completion:^(BOOL finished) {
      [self.topViewController.view addGestureRecognizer:self.pan];
      self.burgerButton.userInteractionEnabled = true;
    }];
    
    
    
  }];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"%ld",(long)indexPath.row);
  
  UIViewController *newVC = self.viewControllers[indexPath.row];
  if (![newVC isEqual:self.topViewController]) {
    [self switchToViewController:newVC];
  }
  
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
