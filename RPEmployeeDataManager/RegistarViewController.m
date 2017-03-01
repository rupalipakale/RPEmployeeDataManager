//
//  RegistarViewController.m
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 22/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "RegistarViewController.h"
#import "AppDelegate.h"

@interface RegistarViewController ()

@end

@implementation RegistarViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _txtAdress.layer.cornerRadius=0.2f;
    _txtAdress.layer.borderWidth=1;
    //_txtAdress.layer.borderColor =[UIColor blackColor];
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    context=appDelegate.persistentContainer.viewContext;

}

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
    if ([_txtName.text isEqualToString:@""]) {
        [self alertwithTitle:@"Error" andMessage:@"Please enter name."];
        return NO;
    }
    else if ([_txtAdress.text isEqualToString:@""])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter address."];
        
        return NO;
    }
    else if ([_txtMobileNo.text isEqualToString:@""])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter mobile no."];
        return NO;
    }
    if ([_txtDeptName.text isEqualToString:@""]) {
        [self alertwithTitle:@"Error" andMessage:@"Please enter Department Name."];
        return NO;
    }
    else if (![self validateEmailWithString:_txtEmail.text])
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter valid email."];
        return NO;
    }
    else if (!([_txtMobileNo.text length]==10))
    {
        [self alertwithTitle:@"Error" andMessage:@"Please enter valid mobile no."];
        return NO;
    }
    else
        return YES;
}

-(void)clearText
{
    _txtEmail.text=@"";
    _txtPassword.text=@"";
    _txtName.text=@"";
    _txtAdress.text=@"";
    _txtDeptName.text=@"";
    _txtDeptDetails.text=@"";
    _txtMobileNo.text=@"";
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==_txtDeptName || textField==_txtDeptDetails)
    {
     [self animateTextField:textField up:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_txtDeptName || textField==_txtDeptDetails)
    {
     [self animateTextField:textField up:NO];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
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

- (IBAction)btnSaveClick:(id)sender {
    if([self emptyCheck])
    {
        NSEntityDescription *entityEmployee=[NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        NSManagedObject *employeeObject=[[NSManagedObject alloc]initWithEntity:entityEmployee insertIntoManagedObjectContext:context];
        NSNumber *empid=[NSNumber numberWithInt:arc4random()];
        NSLog(@"%@",empid);
        [employeeObject setValue:empid forKey:@"id"];
        [employeeObject setValue:_txtName.text forKey:@"name"];
        [employeeObject setValue:_txtEmail.text forKey:@"email"];
        [employeeObject setValue:_txtAdress.text forKey:@"address"];
        [employeeObject setValue:_txtPassword.text forKey:@"password"];
        [employeeObject setValue:[NSNumber numberWithInteger:[_txtMobileNo.text integerValue]] forKey:@"phone_no"];
        
        
        NSEntityDescription *entityDept=[NSEntityDescription entityForName:@"Department" inManagedObjectContext:context];
        NSManagedObject *deptObject=[[NSManagedObject alloc]initWithEntity:entityDept insertIntoManagedObjectContext:context];
        NSNumber *deptId=[NSNumber numberWithInt:arc4random()];
        [deptObject setValue:deptId forKey:@"deptid"];
        [deptObject setValue:empid forKey:@"empid"];
        [deptObject setValue:_txtDeptName.text forKey:@"dname"];
        [deptObject setValue:_txtDeptDetails.text forKey:@"deptdetails"];
        
        //set Relation
        [employeeObject setValue:deptObject forKey:@"empdeptrelation"];
        NSError *error;
        [context save:&error];
        [self clearText];
        NSString *msg,*title;
        if(error)
        {
            title=@"Error";
            msg=error.localizedDescription;
            NSLog(@"%@",error.localizedDescription);
        }
        else
        {
            title=@"Saved Successfully...";
            msg=@"You can continue to login now.";
        }
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
           
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
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

- (IBAction)btnCancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
