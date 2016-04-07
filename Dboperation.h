//
//  Dboperation.h
//  StateCityApp
//
//  Created by Yosemite on 4/5/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface Dboperation : NSObject
{
    AppDelegate *deli;
    sqlite3 *dbsql;
}
@property(retain,nonatomic)NSString *get_dbpath;
-(NSMutableArray *)Select2Column:(NSString *)query;
-(NSMutableArray *)Select4Column:(NSString *)query;
-(BOOL)InsUpdDel:(NSString *)query;
@end
