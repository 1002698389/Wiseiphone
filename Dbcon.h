//
//  Dbcon.h
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface Dbcon : NSObject
+ (sqlite3*)dbOpen;
+ (void)DbClose;
@end
