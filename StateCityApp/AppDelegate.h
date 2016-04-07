//
//  AppDelegate.h
//  StateCityApp
//
//  Created by Yosemite on 4/5/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(retain,nonatomic)NSString *dbapth;
@end

