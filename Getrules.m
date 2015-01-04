//
//  Getrules.m
//  WiseiPhone
//
//  Created by fuchaowen on 14-7-29.
//  Copyright (c) 2014年 Micheal. All rights reserved.
//

#import "Getrules.h"
#import "Rules.h"
#import "linker.h"
@implementation Getrules
+ (Getrules*)shareRules
{
    static Getrules * instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[Getrules alloc]init];
    });
    return instance;


}
- (void)addRules:(Rules*)rule
{
   NSLog(@"插入规则成功");
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "insert into ruletable(rulename,allpoints,precept,path,descript,channelid,eventtype,shapetype,ruleid,isused,width,height,address)values(?,?,?,?,?,?,?,?,?,?,?,?,?) ", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
        NSString * address=[user valueForKey:@"address"];
        sqlite3_bind_text(stmt, 1, [rule.rulename UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [rule.points UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [rule.precept UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [rule.path UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [rule.descript UTF8String], -1, NULL);
        sqlite3_bind_int (stmt, 6, rule.channlid);
        sqlite3_bind_int (stmt, 7, rule.eventtype);
        sqlite3_bind_int (stmt, 8, rule.shapetype);
        sqlite3_bind_int (stmt, 9, rule.ruleid);
        sqlite3_bind_int(stmt, 10, rule.isused);
        sqlite3_bind_double(stmt, 11, rule.width);
        sqlite3_bind_double(stmt, 12, rule.height);
        sqlite3_bind_text(stmt, 13, [address UTF8String], -1,NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"规则添加成功");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)addlink:(linker*)linker
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into linkinfo(byname,address,port,type,username,password,channelnum)values(?,?,?,?,?,?,?)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [linker.byname UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [linker.address UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [linker.port UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [linker.type UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [linker.username UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [linker.password UTF8String], -1, NULL);
        sqlite3_bind_int (stmt, 7, linker.channelnum);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
        }
    }
    sqlite3_finalize(stmt);
}
- (void)addalert:(AlertLog*)alert
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into alertinfo(serverindex,chindex,sceneindex,siteindex,trackerindex,ruleid,alertflag,alerttime,objid,eventtype,targetype,objtype,processflag,level,rulename,descript,picturename,partindex,picpath,bigpicpath)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, alert.serverindex);
        sqlite3_bind_int(stmt, 2,alert.chindex);
        sqlite3_bind_int(stmt, 3,alert.sceneindex);
        sqlite3_bind_int(stmt, 4,alert.siteindex);
        sqlite3_bind_int(stmt, 5,alert.trackerindex);
        sqlite3_bind_int(stmt, 6,alert.ruleid);
        sqlite3_bind_int(stmt, 7,alert.alertflag);
        sqlite3_bind_text(stmt, 8, [alert.alerttime UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 9,alert.objid);
        sqlite3_bind_int(stmt, 10,alert.eventtype);
        sqlite3_bind_int(stmt, 11,alert.targetype);
        sqlite3_bind_int(stmt, 12,alert.objtype);
        sqlite3_bind_int(stmt, 13,alert.processflag);
        sqlite3_bind_int(stmt, 14,alert.level);
        sqlite3_bind_text(stmt, 15, [alert.rulename UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 16, [alert.descript UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 17, [alert.picturename UTF8String], -1,  NULL);
        sqlite3_bind_int(stmt, 18, alert.partindex);
        sqlite3_bind_text(stmt, 19,[alert.picpath UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 20, [alert.bigpicpath UTF8String], -1, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
        }
    }
    sqlite3_finalize(stmt);

}
- (NSMutableArray*)getalert
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select picturename,rulename,descript,alerttime,picpath,bigpicpath,chindex from alertinfo order by alerttime desc", -1, &stmt, NULL);
    NSMutableArray * logs=nil;
    if (flag==SQLITE_OK) {
        logs=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *picname=sqlite3_column_text(stmt, 0);
            const unsigned char *rulename=sqlite3_column_text(stmt, 1);
            const unsigned char *desc=sqlite3_column_text(stmt, 2);
            const unsigned char *time=sqlite3_column_text(stmt, 3);
            const unsigned char *picpath=sqlite3_column_text(stmt,4);
            const unsigned char *bigpicpath=sqlite3_column_text(stmt, 5);
            int chindex=sqlite3_column_int(stmt, 6);
            AlertLog * alert=[[AlertLog alloc]init];
            alert.picturename=[NSString stringWithCString:(const char*)picname encoding:NSUTF8StringEncoding];
            alert.rulename=[NSString stringWithCString:(const char *)rulename encoding:NSUTF8StringEncoding];
            alert.descript=[NSString stringWithCString:(const char *)desc encoding:NSUTF8StringEncoding];
            alert.alerttime=[NSString stringWithCString:(const char *)time encoding:NSUTF8StringEncoding];
            alert.picpath=[NSString stringWithCString:(const char *)picpath encoding:NSUTF8StringEncoding];
            alert.bigpicpath=[NSString stringWithCString:(const char *)bigpicpath encoding:NSUTF8StringEncoding];
            alert.chindex=chindex;
            [logs addObject:alert];
        }
    }
    sqlite3_finalize(stmt);
    return logs;

}
- (void)removepicture
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select picpath,bigpicpath from alertinfo where ruleid in (select ruleid from alertinfo order by alerttime desc limit (select count(ruleid) from alertinfo) offset 50)", -1, &stmt, NULL);
    
    if (flag==SQLITE_OK) {
       
        NSFileManager * filemanager=[NSFileManager defaultManager];
       
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *picpath=sqlite3_column_text(stmt,0);
            const unsigned char *bigpicpath=sqlite3_column_text(stmt, 1);
            // NSLog(@"删除图片");
            AlertLog * alert=[[AlertLog alloc]init];
            alert.picpath=[NSString stringWithCString:(const char *)picpath encoding:NSUTF8StringEncoding];
            alert.bigpicpath=[NSString stringWithCString:(const char *)bigpicpath encoding:NSUTF8StringEncoding];
            NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *fullpath=[directorypath stringByAppendingPathComponent:alert.picpath];
            NSString *bigfullpath=[directorypath stringByAppendingPathComponent:alert.bigpicpath];
            if ([filemanager fileExistsAtPath:fullpath]&&[filemanager fileExistsAtPath:bigfullpath]) {
                
                [filemanager removeItemAtPath:fullpath error:nil];
                [filemanager removeItemAtPath:bigfullpath error:nil];
                
            }
            
        }
    }
    sqlite3_finalize(stmt);
    
    
}

- (void)removeallpictures:(NSString*)picpath{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select picpath,bigpicpath from alertinfo where picpath=?", -1, &stmt, NULL);
    
    if (flag==SQLITE_OK) {
        
        NSFileManager * filemanager=[NSFileManager defaultManager];
        sqlite3_bind_text(stmt, 1, [picpath UTF8String], -1, NULL);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *picpath=sqlite3_column_text(stmt,0);
            const unsigned char *bigpicpath=sqlite3_column_text(stmt, 1);
            NSLog(@"删除图片");
            AlertLog * alert=[[AlertLog alloc]init];
            alert.picpath=[NSString stringWithCString:(const char *)picpath encoding:NSUTF8StringEncoding];
            alert.bigpicpath=[NSString stringWithCString:(const char *)bigpicpath encoding:NSUTF8StringEncoding];
            NSString * directorypath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *fullpath=[directorypath stringByAppendingPathComponent:alert.picpath];
            NSString *bigfullpath=[directorypath stringByAppendingPathComponent:alert.bigpicpath];
            if ([filemanager fileExistsAtPath:fullpath]&&[filemanager fileExistsAtPath:bigfullpath]) {
                
                [filemanager removeItemAtPath:fullpath error:nil];
                [filemanager removeItemAtPath:bigfullpath error:nil];
                
            }
            
        
        }
    }
    sqlite3_finalize(stmt);

    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeupdate" object:self];
}
- (void)deletelog{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from alertinfo where ruleid in (select ruleid from alertinfo order by alerttime desc limit  (select count(ruleid) from alertinfo) offset 50)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        //sqlite3_bind_int(stmt, 1, chidx);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
           
            NSLog(@"执行删除日志操作");
        }
    }
    sqlite3_finalize(stmt);

}
- (void)deletelogbyindex:(NSString*)idxs{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from alertinfo where picpath=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [idxs UTF8String], -1, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
            NSLog(@"删除成功");
        }
    }
    sqlite3_finalize(stmt);


}
- (void)deletealertlogs{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from alertinfo", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        //sqlite3_bind_int(stmt, 1, chidx);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
            NSLog(@"日志删除成功");
           
        }
    }
    sqlite3_finalize(stmt);


}
- (void)deleteurlinfo:(int)channel
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from selectinfo where channel=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, channel);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"删除播放路径成功");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)appendinfo:(int)channel
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into selectinfo select * from originfo where channel=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, channel);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据插入成功！");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)addoriginfo:(urlinfo*)url
{
    NSLog(@"url=%@",url.path);
    NSLog(@"url.index=%d",url.index);
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into originfo(pathurl,channel,width,height)values(?,?,?,?)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [url.path UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, url.index);
        sqlite3_bind_int(stmt, 3, url.width);
        sqlite3_bind_int(stmt, 4, url.height);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据插入成功！");
        }
    }
    sqlite3_finalize(stmt);
    
}
- (NSMutableArray*)takeoriginfo
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select pathurl,channel,width,height from originfo", -1, &stmt, NULL);
    NSMutableArray * info=nil;
    if (flag==SQLITE_OK) {
        info=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char * path=sqlite3_column_text(stmt, 0);
            int index=sqlite3_column_int(stmt, 1);
            int width=sqlite3_column_int(stmt, 2);
            int height=sqlite3_column_int(stmt, 3);
            urlinfo * inf=[[urlinfo alloc]init];
            inf.path=[NSString stringWithCString:(const char *)path encoding:NSUTF8StringEncoding];
            inf.index=index;
            inf.width=width;
            inf.height=height;
            NSLog(@"inf.path=%@",inf.path);
            [info addObject:inf];
        }
    }
    sqlite3_finalize(stmt);
    return info;
    
}
- (int)checkorigininfo:(int)channel
{
    int chane;
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select count(*) from originfo where channel=?", -1, &stmt, NULL);
 
    if (flag==SQLITE_OK) {
        
      
        sqlite3_bind_int(stmt, 1, channel);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            chane=sqlite3_column_int(stmt, 0);
            
        }
    }
    sqlite3_finalize(stmt);
    return chane;
    
    
}
- (int)checkselectinfo:(int)channel
{
    int chane;
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select count(*) from selectinfo where channel=?", -1, &stmt, NULL);

    if (flag==SQLITE_OK) {
        
       
        sqlite3_bind_int(stmt, 1, channel);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            chane=sqlite3_column_int(stmt, 0);
            
        }
    }
    sqlite3_finalize(stmt);
    return chane;
    
}
- (void)deleteoriginfo
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from originfo", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"删除播放路径成功");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)deletealert
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from alertinfo where alerttime like '%1970%'", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        //sqlite3_bind_int(stmt, 1, chidx);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
         
        }
    }
    sqlite3_finalize(stmt);
 

}
- (void)addSelectinfo:(urlinfo*)url
{
    NSLog(@"url=%@",url.path);
    NSLog(@"url.index=%d",url.index);
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into selectinfo(pathurl,channel,width,height)values(?,?,?,?)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [url.path UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, url.index);
        sqlite3_bind_int(stmt, 3, url.width);
        sqlite3_bind_int(stmt, 4, url.height);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"插入所选通道成功！");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (NSString*)takelocalurl:(int)index
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select pathurl  from selectinfo where channel=?", -1, &stmt, NULL);
    NSString * rtsp=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, index);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char * path=sqlite3_column_text(stmt, 0);

            rtsp=[NSString stringWithCString:(const char *)path encoding:NSUTF8StringEncoding];
         
        }
    }
    sqlite3_finalize(stmt);
    return rtsp;

}
- (NSMutableArray*)takeurlinfo
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select pathurl,channel,width,height from selectinfo", -1, &stmt, NULL);
    NSMutableArray * info=nil;
    if (flag==SQLITE_OK) {
        info=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char * path=sqlite3_column_text(stmt, 0);
            int index=sqlite3_column_int(stmt, 1);
            int width=sqlite3_column_int(stmt, 2);
            int height=sqlite3_column_int(stmt, 3);
            urlinfo * inf=[[urlinfo alloc]init];
            inf.path=[NSString stringWithCString:(const char *)path encoding:NSUTF8StringEncoding];
            inf.index=index;
            inf.width=width;
            inf.height=height;
            NSLog(@"inf.path=%@",inf.path);
            [info addObject:inf];
        }
    }
    sqlite3_finalize(stmt);
    return info;
    
    
}
- (void)deleteurlinfo
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from selectinfo", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"删除播放路径成功");
        }
    }
    sqlite3_finalize(stmt);
    
}
- (NSMutableArray*)listlinks
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select id,byname,address,port,type,username,password,channelnum,isopen from linkinfo ", -1, &stmt, NULL);
    NSMutableArray * link=nil;
    if (flag==SQLITE_OK) {
        link=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            int  linkid=sqlite3_column_int(stmt, 0);
            const unsigned char *byname=sqlite3_column_text(stmt, 1);
            const unsigned char *address=sqlite3_column_text(stmt, 2);
            const unsigned char *port=sqlite3_column_text(stmt, 3);
            const unsigned char *type=sqlite3_column_text(stmt, 4);
            const unsigned char *username=sqlite3_column_text(stmt, 5);
            const unsigned char *password=sqlite3_column_text(stmt, 6);
            int channelnum=sqlite3_column_int(stmt, 7);
            const unsigned char *isopen=sqlite3_column_text(stmt, 8);
        linker *linking=[[linker alloc]initWithLinkid:linkid byname:[NSString stringWithCString:(const char *)byname encoding:NSUTF8StringEncoding] address:[NSString stringWithCString:(const char *)address encoding:NSUTF8StringEncoding]  port:[NSString stringWithCString:(const char *)port encoding:NSUTF8StringEncoding]  type:[NSString stringWithCString:(const char *)type encoding:NSUTF8StringEncoding]  username:[NSString stringWithCString:(const char *)username encoding:NSUTF8StringEncoding]  password:[NSString stringWithCString:(const char *)password encoding:NSUTF8StringEncoding]  channelnum:channelnum isopen:[NSString stringWithCString:(const char *)isopen encoding:NSUTF8StringEncoding]];
            [link addObject:linking];
        }
    }
    sqlite3_finalize(stmt);
    return link;

}
- (void)addcurlink:(linker*)link{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt *stmt=nil;
    int flag=sqlite3_prepare(db, "insert into curlink(byname,address,port,type,username,password,channelnum,isopen)values(?,?,?,?,?,?,?,?)", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [link.byname UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [link.address UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [link.port UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [link.type UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [link.username UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [link.password UTF8String], -1, NULL);
        sqlite3_bind_int (stmt, 7, link.channelnum);
        sqlite3_bind_int(stmt, 8, [link.isopen intValue]);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            
        }
    }
    sqlite3_finalize(stmt);


}
- (linker*)querycurlink{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select byname,address,port,type,username,password,channelnum,isopen from curlink ", -1, &stmt, NULL);
    linker *linking;
    if (flag==SQLITE_OK) {
      
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            int linkid=0;
            const unsigned char *byname=sqlite3_column_text(stmt, 0);
            const unsigned char *address=sqlite3_column_text(stmt, 1);
            const unsigned char *port=sqlite3_column_text(stmt, 2);
            const unsigned char *type=sqlite3_column_text(stmt, 3);
            const unsigned char *username=sqlite3_column_text(stmt, 4);
            const unsigned char *password=sqlite3_column_text(stmt, 5);
            int channelnum=sqlite3_column_int(stmt, 6);
            const unsigned char *isopen=sqlite3_column_text(stmt, 7);
            linking=[[linker alloc]initWithLinkid:linkid byname:[NSString stringWithCString:(const char *)byname encoding:NSUTF8StringEncoding] address:[NSString stringWithCString:(const char *)address encoding:NSUTF8StringEncoding]  port:[NSString stringWithCString:(const char *)port encoding:NSUTF8StringEncoding]  type:[NSString stringWithCString:(const char *)type encoding:NSUTF8StringEncoding]  username:[NSString stringWithCString:(const char *)username encoding:NSUTF8StringEncoding]  password:[NSString stringWithCString:(const char *)password encoding:NSUTF8StringEncoding]  channelnum:channelnum isopen:[NSString stringWithCString:(const char *)isopen encoding:NSUTF8StringEncoding]];
           
        }
    }
    sqlite3_finalize(stmt);
    return linking;


}
- (void)deletecurlink{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from curlink", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"删除上次连接");
        }
    }
    sqlite3_finalize(stmt);



}
- (void)deletelinker:(NSString*)name{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "delete from linkinfo where address=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
         sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"连接删除成功");
        }
    }
    sqlite3_finalize(stmt);


}
- (void)updatelinkall{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update linkinfo set isopen='0'", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);


}
- (void)updatell:(NSString*)address{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update linkinfo set isopen='1' where address=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [address UTF8String], -1, NULL);
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);


}
- (void)updatelink:(NSString*)name{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update linkinfo set isopen='1' where address=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
       
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);



}
- (NSMutableArray*)getroutharray
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    NSUserDefaults * userdefault=[NSUserDefaults standardUserDefaults];
    NSString * ipaddress=[userdefault valueForKey:@"address"];
    
    int flag=sqlite3_prepare(db, "SELECT channelid  FROM ruletable where address=? group by channelid", -1, &stmt, NULL);
    NSMutableArray * channels=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [ipaddress UTF8String], -1, NULL);
        channels=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            int chid=sqlite3_column_int(stmt, 0);
            NSNumber * idnum=[NSNumber numberWithInt:chid];
            
            [channels addObject:idnum];
        }
    }
    sqlite3_finalize(stmt);
    return channels;
    
    
}
- (NSMutableArray*)getused:(int)channelid
{
    NSUserDefaults * defaultuser=[NSUserDefaults standardUserDefaults];
    NSString * address=[defaultuser valueForKey:@"address"];
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "SELECT isused  FROM ruletable where address=? and channelid=? ", -1, &stmt, NULL);
    NSMutableArray * channels=nil;
    if (flag==SQLITE_OK) {
        channels=[NSMutableArray arrayWithCapacity:1];
        sqlite3_bind_text(stmt, 1, [address UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 2, channelid);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            int chid=sqlite3_column_int(stmt, 0);
            NSNumber * idnum=[NSNumber numberWithInt:chid];
            
            [channels addObject:idnum];
        }
    }
    sqlite3_finalize(stmt);
    return channels;
    
    
}

- (NSMutableArray*)getRules:(int)channel
{
    NSUserDefaults * defuser=[NSUserDefaults standardUserDefaults];
    NSString * hostname=[defuser valueForKey:@"address"];
    NSLog(@"hostname=%@",hostname);
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select rulename,allpoints,id,precept,path,descript,channelid,eventtype,shapetype,ruleid,isused,width,height,address from ruletable where channelid=? and address=? ", -1, &stmt, NULL);
    NSMutableArray * rules=nil;
    if (flag==SQLITE_OK) {
        
        rules=[NSMutableArray arrayWithCapacity:30];
        sqlite3_bind_int(stmt, 1, channel);
        sqlite3_bind_text(stmt, 2,[hostname UTF8String], -1,NULL);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *rulename=sqlite3_column_text(stmt, 0);
            const unsigned char *allpoints=sqlite3_column_text(stmt, 1);
            int rid=sqlite3_column_int(stmt, 2);
            const unsigned char *precept=sqlite3_column_text(stmt, 3);
            const unsigned char *path=sqlite3_column_text(stmt, 4);
            const unsigned char *descript=sqlite3_column_text(stmt, 5);
            int channelid=sqlite3_column_int(stmt, 6);
            int eventtype=sqlite3_column_int(stmt, 7);
            int shapetype=sqlite3_column_int(stmt, 8);
            int ruleid=sqlite3_column_int(stmt, 9);
            int isused=sqlite3_column_int(stmt, 10);
            int width=sqlite3_column_int(stmt, 11);
            int height=sqlite3_column_int(stmt, 12);
            const unsigned char * address=sqlite3_column_text(stmt, 13);
            Rules * rule=[[Rules alloc]initWithRulename:[NSString stringWithCString:(const char *)rulename encoding:NSUTF8StringEncoding] point:[NSString stringWithCString:(const char*)allpoints encoding:NSUTF8StringEncoding] rid:rid precept:[NSString stringWithCString:(const char*)precept encoding:NSUTF8StringEncoding] path:[NSString stringWithCString:(const char*)path encoding:NSUTF8StringEncoding] descript:[NSString stringWithCString:(const char *)descript encoding:NSUTF8StringEncoding] channlid:channelid eventtype:eventtype shapetype:shapetype ruleid:ruleid isused:isused width:width height:height address:[NSString stringWithCString:(const char *)address encoding:NSUTF8StringEncoding]];
            
            [rules addObject:rule];
        }
    }
    sqlite3_finalize(stmt);
    return rules;
}
- (NSMutableArray*)takeruleid:(int)channelid
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select ruleid from ruletable where channelid=? ", -1, &stmt, NULL);
    NSMutableArray * ruleid=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, channelid);
        ruleid=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
          
            int rid=sqlite3_column_int(stmt, 0);
            NSNumber * idnum=[NSNumber numberWithInt:rid];
            
            [ruleid addObject:idnum];
        }
    }
    sqlite3_finalize(stmt);
    return ruleid;


}
- (NSMutableArray*)takepoints:(int)channelid{
  
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select rulename,allpoints,width,height from ruletable where channelid=? ", -1, &stmt, NULL);
    NSMutableArray * points=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, channelid);
        points=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *rulename=sqlite3_column_text(stmt, 0);
           const unsigned char *point=sqlite3_column_text(stmt, 1);
            int width=sqlite3_column_int(stmt, 2);
            int height=sqlite3_column_int(stmt, 3);
            PointsObj * po=[[PointsObj alloc]initWithLine:[NSString stringWithCString:(const char *)rulename encoding:NSUTF8StringEncoding] point:[NSString stringWithCString:(const char *)point encoding:NSUTF8StringEncoding] width:width height:height];
            [points addObject:po];
           
        }
    }
    sqlite3_finalize(stmt);
    return points;


}
- (NSMutableArray*)takeselectchanel{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select channel from selectinfo group by channel", -1, &stmt, NULL);
    NSMutableArray * channels=nil;
    if (flag==SQLITE_OK) {
        
        channels=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            int channel=sqlite3_column_int(stmt, 0);
            NSNumber * channelobj=[NSNumber numberWithInt:channel];
            [channels addObject:channelobj];
            
        }
    }
    sqlite3_finalize(stmt);
    return channels;



}
- (NSMutableArray*)getRules
{
    NSUserDefaults * user=[NSUserDefaults standardUserDefaults];
    NSString * address=[user valueForKey:@"address"];
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select rulename,allpoints,id,precept,path,descript,channelid,eventtype,shapetype,ruleid,isused,width,height from ruletable where address=? ", -1, &stmt, NULL);
    NSMutableArray * rules=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [address UTF8String], -1, NULL);
        rules=[NSMutableArray arrayWithCapacity:1];
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *rulename=sqlite3_column_text(stmt, 0);
            const unsigned char *allpoints=sqlite3_column_text(stmt, 1);
            int rid=sqlite3_column_int(stmt, 2);
            const unsigned char *precept=sqlite3_column_text(stmt, 3);
            const unsigned char *path=sqlite3_column_text(stmt, 4);
            const unsigned char *descript=sqlite3_column_text(stmt, 5);
            int channelid=sqlite3_column_int(stmt, 6);
            int eventtype=sqlite3_column_int(stmt, 7);
            int shapetype=sqlite3_column_int(stmt, 8);
            int ruleid=sqlite3_column_int(stmt, 9);
            int isused=sqlite3_column_int(stmt, 10);
            float width=sqlite3_column_double(stmt, 11);
            float height=sqlite3_column_double(stmt, 12);
            Rules * rule=[[Rules alloc]initWithRulename:[NSString stringWithCString:(const char *)rulename encoding:NSUTF8StringEncoding] point:[NSString stringWithCString:(const char*)allpoints encoding:NSUTF8StringEncoding] rid:rid precept:[NSString stringWithCString:(const char*)precept encoding:NSUTF8StringEncoding] path:[NSString stringWithCString:(const char*)path encoding:NSUTF8StringEncoding] descript:[NSString stringWithCString:(const char *)descript encoding:NSUTF8StringEncoding] channlid:channelid eventtype:eventtype shapetype:shapetype ruleid:ruleid isused:isused width:width height:height address:address];
            
            [rules addObject:rule];
        }
    }
    sqlite3_finalize(stmt);
    NSLog(@"allrule=%@",rules);
    return rules;
}
- (Rules*)selectData:(int)iid
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select rulename,allpoints,id,precept,path,descript,channelid,eventtype,shapetype,ruleid,isused,width,height,address from ruletable where id=?", -1, &stmt, NULL);
    Rules * rule=nil;
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, iid);
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            const unsigned char *rulename=sqlite3_column_text(stmt, 0);
            const unsigned char *allpoints=sqlite3_column_text(stmt, 1);
            int rid=sqlite3_column_int(stmt, 2);
            const unsigned char *precept=sqlite3_column_text(stmt, 3);
            const unsigned char *path=sqlite3_column_text(stmt, 4);
            const unsigned char *descript=sqlite3_column_text(stmt, 5);
            int channelid=sqlite3_column_int(stmt, 6);
            int eventtype=sqlite3_column_int(stmt, 7);
            int shapetype=sqlite3_column_int(stmt, 8);
            int ruleid=sqlite3_column_int(stmt, 9);
            int isused=sqlite3_column_int(stmt, 10);
            float width=sqlite3_column_double(stmt, 11);
            float height=sqlite3_column_double(stmt, 12);
            const unsigned char *address=sqlite3_column_text(stmt, 13);
            rule=[[Rules alloc]initWithRulename:[NSString stringWithCString:(const char *)rulename encoding:NSUTF8StringEncoding] point:[NSString stringWithCString:(const char*)allpoints encoding:NSUTF8StringEncoding] rid:rid precept:[NSString stringWithCString:(const char*)precept encoding:NSUTF8StringEncoding] path:[NSString stringWithCString:(const char*)path encoding:NSUTF8StringEncoding] descript:[NSString stringWithCString:(const char *)descript encoding:NSUTF8StringEncoding] channlid:channelid eventtype:eventtype shapetype:shapetype ruleid:ruleid isused:isused width:width height:height address:[NSString stringWithCString:(const char *)address encoding:NSUTF8StringEncoding]];
           
        }
    }
    sqlite3_finalize(stmt);
    return rule;
}
- (void)deleteruleall
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from ruletable", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        
        if (sqlite3_step(stmt)==SQLITE_DONE) {
           // NSLog(@"删除成功");
        }
    }
    sqlite3_finalize(stmt);


}

- (void)deleteRules:(int)rid
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db,"delete from ruletable where id=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, rid);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
           
        }
    }
    sqlite3_finalize(stmt);
}
- (void)updateused:(Rules*)rule isused:(int)isused{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update ruletable set isused=? where id=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, isused);
        sqlite3_bind_int(stmt, 2, rule.Rid);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);



}
- (void)updateusedall:(int)channelid isused:(int)isused
{
    NSUserDefaults * defaultuser=[NSUserDefaults standardUserDefaults];
    NSString * address=[defaultuser valueForKey:@"address"];
    NSLog(@"address=%@",address);
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update ruletable set isused=? where channelid=? and address=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_int(stmt, 1, isused);
        sqlite3_bind_int(stmt, 2, channelid);
        sqlite3_bind_text(stmt, 3, [address UTF8String], -1, NULL);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)updateRules:(Rules*)rule
{
    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update ruletable set rulename=?,allpoints=?,precept=?,descript=?,eventtype=?,shapetype=? where id=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [rule.rulename UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [rule.points UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [rule.precept UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [rule.descript UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 5, rule.eventtype);
        sqlite3_bind_int(stmt, 6, rule.shapetype);
        sqlite3_bind_int(stmt, 7, rule.Rid);
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);
    
    
}
- (void)updatelinkfrom:(linker*)linker{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "update linkinfo set byname=?,address=?,port=?,username=?,password=?  where address=?", -1, &stmt, NULL);
    if (flag==SQLITE_OK) {
     
        sqlite3_bind_text(stmt, 1, [linker.byname UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [linker.address UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [linker.port UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 4, [linker.username UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [linker.password UTF8String],-1,NULL);
        //sqlite3_bind_text(stmt, 6, [linker.isopen UTF8String],-1,NULL);
        sqlite3_bind_text(stmt, 6, [linker.address UTF8String], -1, NULL);
    
        if (sqlite3_step(stmt)==SQLITE_DONE) {
            NSLog(@"数据更新成功");
        }
    }
    sqlite3_finalize(stmt);



}
- (int)takeurlinfocount{

    sqlite3 * db=[Dbcon dbOpen];
    sqlite3_stmt * stmt=nil;
    int flag=sqlite3_prepare(db, "select count(channel) from selectinfo ", -1, &stmt, NULL);
    int channel;
    if (flag==SQLITE_OK) {
        
       
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            
            channel=sqlite3_column_int(stmt, 0);
           
            
        }
    }
    sqlite3_finalize(stmt);
    return channel;


}
@end
