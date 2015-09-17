//
//  QuestionSearchViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/15/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "QuestionJSONParser.h"
#import "StackOverFlowService.h"
#import "Question.h"

@interface QuestionSearchViewController ()<UISearchBarDelegate>

@property (strong,nonatomic) NSArray *questions;

@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
 //[StackOverFlowService questionsForSearchTerm:nil completionHandler:nil];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
  
  [StackOverFlowService questionsForSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSError *error) {
    NSLog(@"%@",self.questions);
    self.questions = results;
  }];
  
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
