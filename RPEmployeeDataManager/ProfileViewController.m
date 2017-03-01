//
//  ProfileViewController.m
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabController *obj=[[tabController alloc]init];
    obj.custDelegate=self;
    [obj callDelegte];

    self.lblName.text=[[_empArray objectAtIndex:0] valueForKey:@"name"];
    self.lblEmail.text=[[_empArray objectAtIndex:0] valueForKey:@"email"];
    self.lblAddress.text=[[_empArray objectAtIndex:0] valueForKey:@"address"];
    self.lblMobileNo.text=[NSString stringWithFormat:@"%@",[[_empArray objectAtIndex:0] valueForKey:@"phone_no"]];
}

-(void)getArray:(NSArray *)arr
{
    self.empArray=arr;
    
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
