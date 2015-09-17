//
//  QuestionSearchTableViewCell.h
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/17/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSearchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewOwner;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestionTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;

@end
