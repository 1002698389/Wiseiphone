//
//  FilePath.m
//  WiseiPhone
//
//  Created by fcw on 14-7-14.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "FilePath.h"

@implementation FilePath
+(NSString*)documentsPath{
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    
}
+(NSString*)filePathAtDocumentsWithFileName:(NSString*)fileName
{
    NSString * fliePath=[[self documentsPath] stringByAppendingPathComponent:fileName];
    return fliePath;
    
}
@end
