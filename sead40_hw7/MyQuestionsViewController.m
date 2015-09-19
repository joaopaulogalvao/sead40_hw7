//
//  MyQuestionsViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MyQuestionsViewController.h"
#import "MyQuestionsTableViewCell.h"
#import "Question.h"

@interface MyQuestionsViewController ()<UIBarPositioningDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewMyQuestions;
@property (strong,nonatomic) NSArray *myQuestions;

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.tableViewMyQuestions.dataSource = self;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIBarPositioningDelegate
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar{
  
  return UIBarPositionTopAttached;
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.myQuestions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MyQuestionsTableViewCell *myQuestionsCell = [self.tableViewMyQuestions dequeueReusableCellWithIdentifier:@"searchCell"];
  
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
