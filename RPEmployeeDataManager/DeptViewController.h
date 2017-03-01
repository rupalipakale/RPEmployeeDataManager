//
//  DeptViewController.h
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tabController.h"

@interface DeptViewController : UIViewController<tabBarDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lblDeptName;
@property (strong, nonatomic) IBOutlet UILabel *lblDeptDetails;
@property(strong,nonatomic)NSArray *empArray;
@end
