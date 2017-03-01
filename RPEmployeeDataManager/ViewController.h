//
//  ViewController.h
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 22/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLoginClick:(id)sender;
- (IBAction)btnSignUpClick:(id)sender;

@end

