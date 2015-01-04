//
//  AlertLog.h
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-18.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertLog : NSObject
@property(nonatomic,assign)int serverindex;
@property(nonatomic,assign)int chindex;
@property(nonatomic,assign)int sceneindex;
@property(nonatomic,assign)int siteindex;
@property(nonatomic,assign)int trackerindex;
@property(nonatomic,assign)int ruleid;
@property(nonatomic,assign)int alertflag;
@property(nonatomic,retain)NSString *alerttime;
@property(nonatomic,assign)int objid;
@property(nonatomic,assign)int eventtype;
@property(nonatomic,assign)int targetype;
@property(nonatomic,assign)int objtype;
@property(nonatomic,assign)int processflag;
@property(nonatomic,assign)int level;
@property(nonatomic,retain)NSString *rulename;
@property(nonatomic,retain)NSString *descript;
@property(nonatomic,retain)NSString *picturename;
@property(nonatomic,assign)int partindex;
@property(nonatomic,retain)NSString *picpath;
@property(nonatomic,retain)NSString *bigpicpath;
- (id)initWithServerindex:(int)serverindex chindex:(int)chindex sceneindex:(int)sceneindex siteindex:(int)siteindex trackerindex:(int)trackerindex
                   ruleid:(int)ruleid alertflag:(int)alertflag alerttime:(NSString*)alerttime objid:(int)objid eventtype:(int)eventtype targetype:(int)targetype objtype:(int)objtype processflag:(int)processflag level:(int)level rulename:(NSString*)rulename descript:(NSString*)descript picturename:(NSString*)picturename partindex:(int)partindex picpath:(NSString*)picpath bigpicpath:(NSString*)bigpicpath;
@end
