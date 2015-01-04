//
//  AlertLog.m
//  WiseMonitor
//
//  Created by fuchaowen on 14-9-18.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "AlertLog.h"

@implementation AlertLog
- (id)initWithServerindex:(int)serverindex chindex:(int)chindex sceneindex:(int)sceneindex siteindex:(int)siteindex trackerindex:(int)trackerindex
                   ruleid:(int)ruleid alertflag:(int)alertflag alerttime:(NSString*)alerttime objid:(int)objid eventtype:(int)eventtype targetype:(int)targetype objtype:(int)objtype processflag:(int)processflag level:(int)level rulename:(NSString*)rulename descript:(NSString*)descript picturename:(NSString*)picturename partindex:(int)partindex picpath:(NSString*)picpath bigpicpath:(NSString *)bigpicpath{

    self=[super init];
    if (self) {
        self.serverindex=serverindex;
        self.chindex=chindex;
        self.sceneindex=sceneindex;
        self.siteindex=siteindex;
        self.trackerindex=trackerindex;
        self.ruleid=ruleid;
        self.alertflag=alertflag;
        self.alerttime=alerttime;
        self.objid=objid;
        self.eventtype=eventtype;
        self.targetype=targetype;
        self.objtype=objtype;
        self.processflag=processflag;
        self.level=level;
        self.rulename=rulename;
        self.descript=descript;
        self.picturename=picturename;
        self.partindex=partindex;
        self.picpath=picpath;
        self.bigpicpath=bigpicpath;
    }
    return self;
}
@end
