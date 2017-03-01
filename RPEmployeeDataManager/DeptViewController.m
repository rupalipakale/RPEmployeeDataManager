//
//  DeptViewController.m
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "DeptViewController.h"

@interface DeptViewController ()

@end

@implementation DeptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tabController *obj=[[tabController alloc]init];
    obj.custDelegate=self;
    [obj callDeptDelegate];
}

-(void)getArray:(NSArray *)arr
{
    self.empArray=arr;
    self.lblDeptName.text=[[_empArray objectAtIndex:0] valueForKey:@"dname"];
    self.lblDeptDetails.text=[[_empArray objectAtIndex:0] valueForKey:@"deptdetails"];
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
