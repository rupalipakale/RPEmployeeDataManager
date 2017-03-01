//
//  ProfileViewController.h
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tabController.h"

@interface ProfileViewController : UIViewController<tabBarDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblMobileNo;

@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property(strong,nonatomic)NSArray *empArray;

@end
