//
//  Dboperation.m
//  StateCityApp
//
//  Created by Yosemite on 4/5/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "Dboperation.h"

@implementation Dboperation
@synthesize get_dbpath;
-(id)init
{
    if (self==[super init])
    {
        deli=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        get_dbpath=deli.dbapth;
    }
    return self;
}
-(NSMutableArray *)Select2Column:(NSString *)query
{
    NSMutableArray *arrmute=[[NSMutableArray alloc]init];
    NSMutableDictionary *dictmute=[[NSMutableDictionary alloc]init];
    if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql,[query UTF8String], -1,&ppStmt, nil)==SQLITE_OK)
        {
            while(sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                NSString *getid=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 0)];
                NSString *getnm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 1)];
                
                [dictmute setObject:getid forKey:@"getid"];
                [dictmute setObject:getnm forKey:@"getnm"];
                
                [arrmute addObject:[dictmute copy]];
            }
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return arrmute;
}
-(NSMutableArray *)Select4Column:(NSString *)query
{
    NSMutableArray *arrmute=[[NSMutableArray alloc]init];
    NSMutableDictionary *dictmute=[[NSMutableDictionary alloc]init];
    if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql,[query UTF8String], -1,&ppStmt, nil)==SQLITE_OK)
        {
            while(sqlite3_step(ppStmt)==SQLITE_ROW)
            {
                NSString *s_id=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 0)];
                NSString *s_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 1)];
                NSString *st_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 2)];
                NSString *ct_nm=[NSString stringWithFormat:@"%s",sqlite3_column_text(ppStmt, 3)];
                
                [dictmute setObject:s_id forKey:@"s_id"];
                [dictmute setObject:s_nm forKey:@"s_nm"];
                [dictmute setObject:st_nm forKey:@"st_nm"];
                [dictmute setObject:ct_nm forKey:@"ct_nm"];
                
                [arrmute addObject:[dictmute copy]];
            }
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return arrmute;
}
-(BOOL)InsUpdDel:(NSString *)query
{
    BOOL result=NO;
    if (sqlite3_open([get_dbpath UTF8String], &dbsql)==SQLITE_OK)
    {
        sqlite3_stmt *ppStmt;
        if (sqlite3_prepare_v2(dbsql,[query UTF8String], -1,&ppStmt, nil)==SQLITE_OK)
        {
            sqlite3_step(ppStmt);
            result=YES;
        }
        sqlite3_finalize(ppStmt);
    }
    sqlite3_close(dbsql);
    return result;
}
@end
