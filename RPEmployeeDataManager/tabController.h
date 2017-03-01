//
//  tabController.h
//  RPEmployeeDataManager
//
//  Created by Student P_07 on 23/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol tabBarDelegate<NSObject>
@optional
-(void)getArray:(NSArray *)arr;
@end
@interface tabController : UITabBarController
@property id<tabBarDelegate>custDelegate;
@property (nonatomic,strong)NSArray *arrRec;
@property (nonatomic,strong)NSArray *arrDept;
-(void)callDelegte;
-(void)callDeptDelegate;
@end
