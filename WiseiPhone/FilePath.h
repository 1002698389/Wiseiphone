//
//  FilePath.h
//  WiseiPhone
//
//  Created by fcw on 14-7-14.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePath : NSObject
+(NSString*)documentsPath;
+(NSString*)filePathAtDocumentsWithFileName:(NSString*)fileName;
@end
