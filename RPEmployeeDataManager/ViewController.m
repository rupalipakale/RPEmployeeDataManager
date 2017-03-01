//
//  ViewController.m
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 22/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "RegistarViewController.h"
#import "tabController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    context=appDelegate.persistentContainer.viewContext;
    [self loginCheck];
}

-(void)loginCheck
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([[userDefaults valueForKey:@"Loggedin"]  isEqual: @1])
    {
        tabController *tabcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"tabController"];
        [self.navigationController pushViewController:tabcontroller animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnLoginClick:(id)sender {
    if([self emptyCheck])
    {
        NSFetchRequest *fetch = [[NSFetchRequest alloc]initWithEntityName:@"Employee"];
        NSString *string = [NSString stringWithFormat:@"email == '%@' AND password == '%@'",_txtEmail.text,_txtPassword.text];
        NSPredicate *pred;
        pred =  [NSPredicate predicateWithFormat:string];
        [fetch setPredicate:pred];
        
        
       NSArray *arrayRec = [context executeFetchRequest:fetch error:nil];
        NSLog(@"%@",arrayRec);
        NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
        if([arrayRec count])
        {
            [userDefaults setValue:@1 forKey:@"Loggedin"];
            [userDefaults setValue:_txtEmail.text forKey:@"logEmail"];
            [userDefaults setValue:_txtPassword.text forKey:@"logPassword"];
            [self loginCheck];
        }
        else
        {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Either email or password or both are not correct,Please try again.." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
           [userDefaults setValue:@0 forKey:@"Loggedin"];
        }
    }
}

-(void)alertwithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(BOOL)emptyCheck
{
    if ([_txtEmail.text isEqualToString:@""]) {
       
        [self alertwithTitle:@"Error" andMessage:@"Please enter email."];
        return NO;
    }
    else if ([_txtPassword.text isEqualToString:@""])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter password."];
        return NO;
    }
    else if (![self validateEmailWithString:_txtEmail.text])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter valid email."];
    
        return  NO;
    }
    else
        return YES;
}
-(void)clearText
{
    _txtEmail.text=@"";
    _txtPassword.text=@"";
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)btnSignUpClick:(id)sender {
    RegistarViewController *regVC=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistarViewController"];
    [self.navigationController pushViewController:regVC animated:YES];
}
@end
