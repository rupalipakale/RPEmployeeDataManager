//
//  RegistarViewController.h
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 22/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistarViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextView *txtAdress;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtDeptName;
@property (strong, nonatomic) IBOutlet UITextField *txtDeptDetails;
@property (strong, nonatomic) IBOutlet UITextField *txtMobileNo;

- (IBAction)btnSaveClick:(id)sender;
- (IBAction)btnCancelClick:(id)sender;

@end
