//
//  tabController.m
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "tabController.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"
#import "DeptViewController.h"

@interface tabController ()

@end

@implementation tabController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    context=appDelegate.persistentContainer.viewContext;
    [self loadData];
}

-(void)loadData
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *userEmail=[userDefaults valueForKey:@"logEmail"];
    NSString *userPassword=[userDefaults valueForKey:@"logPassword"];
    NSFetchRequest *fetch = [[NSFetchRequest alloc]initWithEntityName:@"Employee"];
    NSString *string = [NSString stringWithFormat:@"email == '%@' AND password == '%@'",userEmail,userPassword];
    NSPredicate *pred;
    pred =  [NSPredicate predicateWithFormat:string];
    [fetch setPredicate:pred];
    
    
    _arrRec = [context executeFetchRequest:fetch error:nil];
    NSLog(@"%@",_arrRec);
    
   // NSManagedObject *obj = [_arrRec objectAtIndex:0];
    
    //Dept Data fetch
    NSLog(@"%@",[[_arrRec objectAtIndex:0] valueForKey:@"id"]);
    NSString *empId=[NSString stringWithFormat:@"%@",[[_arrRec objectAtIndex:0] valueForKey:@"id"]];
    
    NSFetchRequest *fetchDept = [[NSFetchRequest alloc]initWithEntityName:@"Department"];
    NSString *stringPred = [NSString stringWithFormat:@"empid == '%@'",empId];
    NSPredicate *predDept;
    predDept =  [NSPredicate predicateWithFormat:stringPred];
    [fetchDept setPredicate:predDept];

    _arrDept=[context executeFetchRequest:fetchDept error:nil];
    NSLog(@"%@",[_arrDept objectAtIndex:0]);
}

-(void)callDeptDelegate
{
    [self.custDelegate getArray:_arrDept];
}
-(void)callDelegte{
    [self.custDelegate getArray:_arrRec];

}
-(void)getArray:(NSArray *)arr
{
    
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
