//
//  MyQuestionsViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "MyQuestionsTableViewCell.h"
#import "MyQuestionsStackOverFlowService.h"
#import "Question.h"

@interface MyQuestionsViewController ()<UIBarPositioningDelegate, UITableViewDataSource,UIBarPositioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewMyQuestions;
@property (strong,nonatomic) NSArray *myQuestions;

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.tableViewMyQuestions.dataSource = self;
  
  [self loadMyQuestions];
  
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIBarPositioningDelegate
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
  
  return UIBarPositionTopAttached;
}

#pragma mark - My Actions

-(void)loadMyQuestions{
  
  [MyQuestionsStackOverFlowService myAskedQuestions:^(NSArray *results, NSError *error) {
    if (error) {
      
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        [alertController dismissViewControllerAnimated:true completion:nil];
      }];
      [alertController addAction:action];
      
      [self presentViewController:alertController animated:true completion:nil];
    } else {
      NSLog(@"My Questions: %@",results);
      self.myQuestions = results;
      dispatch_group_t group = dispatch_group_create();
      dispatch_queue_t imageQueue = dispatch_queue_create("com.codefellows.stackoverflow",DISPATCH_QUEUE_CONCURRENT );
      
      for (Question *question in results) {
        dispatch_group_async(group, imageQueue, ^{
          NSString *avatarURL = question.avatarURL;
          NSURL *imageURL = [NSURL URLWithString:avatarURL];
          NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
          UIImage *image = [UIImage imageWithData:imageData];
          question.avatarPic = image;
        });
        
      }
      
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Images Downloaded" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
          [alertController dismissViewControllerAnimated:true completion:nil];
        }];
        [alertController addAction:action];
        [self.tableViewMyQuestions reloadData];
        [self presentViewController:alertController animated:true completion:nil];
        //self.isDownloading = false;
        
      });
    }
  }];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.myQuestions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MyQuestionsTableViewCell *myQuestionsCell = [self.tableViewMyQuestions dequeueReusableCellWithIdentifier:@"myQuestionsCell"];
  
  Question *myQuestion = [[Question alloc]init];
  myQuestion = self.myQuestions[indexPath.row];
  
  myQuestionsCell.imgViewMyQuestions.image = myQuestion.avatarPic;
  myQuestionsCell.labelMyQuestions.text = myQuestion.ownerName;
  myQuestionsCell.labelMyQuestionsText.text = myQuestion.title;
  
  return myQuestionsCell;
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
