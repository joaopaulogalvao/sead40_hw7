//
//  MyProfileViewController.m
//  sead40_hw7
//
//  Created by Joao Paulo Galvao Alves on 9/16/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MyProfileViewController.h"
#import "MyProfileStackOverFlowService.h"
#import "Errors.h"
#import "User.h"

@interface MyProfileViewController ()

@property (retain, nonatomic) NSString *myName;
@property (strong,nonatomic) NSArray *myProfileInfos;
@property (retain, nonatomic) IBOutlet UIImageView *imgViewMyProfile;
@property (retain, nonatomic) IBOutlet UILabel *labelUsername;
@property (retain, nonatomic) IBOutlet UILabel *labelReputation;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self loadMyProfile];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMyProfile{
  
  [MyProfileStackOverFlowService myProfileInfo:^(NSArray *results, NSError *error) {
    if (error) {
      
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        [alertController dismissViewControllerAnimated:true completion:nil];
      }];
      [alertController addAction:action];
      
      [self presentViewController:alertController animated:true completion:nil];
    } else {
      NSLog(@"My Profile: %@",results);
      self.myProfileInfos = results;
      dispatch_group_t group = dispatch_group_create();
      dispatch_queue_t imageQueue = dispatch_queue_create("com.codefellows.stackoverflow",DISPATCH_QUEUE_CONCURRENT );
      
      for (User *user in results) {
        dispatch_group_async(group, imageQueue, ^{
          NSString *avatarURL = user.avatarURL;
          NSURL *imageURL = [NSURL URLWithString:avatarURL];
          NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
          UIImage *image = [UIImage imageWithData:imageData];
          NSString *myUsername = user.username;
          NSNumber *myReputation = user.reputation;
          user.profileImage = image;
          self.imgViewMyProfile.image = image;
          self.labelUsername.text = myUsername;
          self.labelReputation.text = [NSString stringWithFormat:@"%@",myReputation] ;
        });
        
      }
      
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Images Downloaded" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
          [alertController dismissViewControllerAnimated:true completion:nil];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:true completion:nil];
        //self.isDownloading = false;
        
      });
    }
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
