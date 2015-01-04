//
//  Dbcon.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Dbcon.h"
#define SQLITEFILENAME @"ruletable.sqlite"
static sqlite3 * db=nil;
@implementation Dbcon
+ (sqlite3*)dbOpen
{
    if (db!=nil) {
        return db;
    }
    NSString * docpath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //数据库文件路径。
    NSString * sqlfilepath=[docpath stringByAppendingPathComponent:SQLITEFILENAME];
    NSFileManager * fm=[NSFileManager defaultManager];
    if ([fm fileExistsAtPath:sqlfilepath]==NO) {//如果给定的路径没有文件
        
        NSString * bundlesqlfilepath=[[NSBundle mainBundle] pathForResource:SQLITEFILENAME ofType:nil];
        //把包里面的数据库文件，拷贝到documents下。
        [fm copyItemAtPath:bundlesqlfilepath toPath:sqlfilepath error:nil];
        
    }
    sqlite3_open([sqlfilepath UTF8String], &db);
    
    
    return db;
}
+ (void)DbClose
{
    sqlite3_close(db);
    db=nil;

}
@end
