//
//  ZHDBData.m
//  Dyrs
//
//  Created by mbp  on 13-9-9.
//  Copyright (c) 2013年 zeng hui. All rights reserved.
//

#import "ZHDBData.h"
#import "ZHDBControl.h"


ZHDBData *dbData;


@implementation ZHDBData

+ (ZHDBData *)share
{
    if (dbData == nil)
    {
        dbData = [[ZHDBData alloc] init];
    }
    
    return dbData;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
        NSString *dbPath = nil;
        
        dbPath = [KCachesDirectory stringByAppendingPathComponent:db_name];
        db = [[FMDatabase alloc]initWithPath:dbPath];

    }
    return self;
}

- (void)dealloc
{
    
    if (![db open]) {
        return;
    }
    db = nil;
}


#pragma mark  命令执行

- (void)insertTable:(NSString *)sql
{
    
    //    create table
    if ([db open]) {
        
        
        NSArray * commands = [sql componentsSeparatedByString:@"&$&"];
        for(NSString * sqlString in commands)
        {
            BOOL res = [db executeUpdate:sqlString];
            if (!res) {
                DLog(@"error===========  %@", sqlString);
            } else {
                DLog(@"succ ");
            }
            
        }
        
        [db close];
    }
    else {
        DLog(@"error=========== when open db");
    }
}



- (void)stringToDBSqlString:(NSString *)sqlString
{
    
    if (!sqlString) {
        return;
    }
    
    if ([db open]) {
        
        bool statue =  [db executeUpdate:
                        sqlString];
        if (statue) {
            
        }
        else {
            DLog(@"statue:%i error: %@", statue, sqlString);
        }
        
    }
    else {
        DLog(@"db Not  open");
    }
}

- (void)dictToDB:(NSDictionary *)dict sqlString:(NSString *)sqlString
{
    if (!sqlString) {
        return;
    }
    
    if ([db open]) {

        bool statue =  [db executeUpdate:
                        sqlString withParameterDictionary:dict];
        
        if (statue) {
        }
        else {
            DLog(@"statue:%i error: %@,  \n lasterror:%@", statue, sqlString, db.lastError);
        }
    }
}


#pragma mark -

- (NSMutableArray *)getNumForModle:(NSString * )modle
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select DISTINCT number from product_base where letter = %@ order by number asc", modle];
    

    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[rs stringForColumn:@"number"] forKey:@"number"];

            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;

}

- (NSMutableArray *)getNameForModle:(NSString * )modle Num:(NSString * )num
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select pd.product_id, pb.remark pb_remark, pb.letter pb_letter, pb.number pb_number,pd.name pd_name, ct.name ct_name from product_base pb, product_detil pd, category ct WHERE pb.product_id = pd.product_id and  pb.cate_id = ct.cate_id  and pb.letter = %@ and pb.number = %@", modle, num];
    

    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"product_id"]] forKey:@"product_id"];
            [dict setValue:[rs stringForColumn:@"pd_name"] forKey:@"pd_name"];
            [dict setValue:[rs stringForColumn:@"ct_name"] forKey:@"ct_name"];
            [dict setValue:[rs stringForColumn:@"pb_number"] forKey:@"pb_number"];
            [dict setValue:[rs stringForColumn:@"pb_letter"] forKey:@"pb_letter"];
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getNameForModle:(NSString * )modle Num:(NSString * )num name:(NSString *)name
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select  DISTINCT pd.product_id, pb.remark pb_remark, pb.letter pb_letter, pb.number pb_number,pd.name pd_name, ct.name ct_name from product_base pb, product_detil pd, category ct WHERE pb.product_id = pd.product_id and  pb.cate_id = ct.cate_id  and pb.letter = %@ and pb.number = '%@' ", modle, num];
    
    if (name) {
        sqlString = [NSString stringWithFormat:
                      @"select   pd.product_id, pb.remark pb_remark, pb.letter pb_letter, pb.number pb_number,pd.name pd_name, ct.name ct_name from product_base pb, product_detil pd, category ct WHERE pb.product_id = pd.product_id and  pb.cate_id = ct.cate_id  and pb.letter = %@ and pb.number = '%@' and pd.name = '%@'  ", modle, num, name];
    }
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"product_id"]] forKey:@"product_id"];
            [dict setValue:[rs stringForColumn:@"pd_name"] forKey:@"pd_name"];
            [dict setValue:[rs stringForColumn:@"ct_name"] forKey:@"ct_name"];
            [dict setValue:[rs stringForColumn:@"pb_number"] forKey:@"pb_number"];
            [dict setValue:[rs stringForColumn:@"pb_letter"] forKey:@"pb_letter"];
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getPDFFiles
{

    NSMutableArray *dataArray = [[NSMutableArray alloc] init];

    NSString *sqlString = [NSString stringWithFormat:
                           @"select *  from d_file  where status ISNULL"];
    
    //    加 唯一约束
    //
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        //        案例icon  图片list
        //        案例 list
        //        设计师文档 list
        //        手绘 list

        FMResultSet *rs = [db executeQuery:sqlString];
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"picture_id"]] forKey:@"id"];
            
            NSString *str = [[rs stringForColumn:@"path"] stringByReplacingOccurrencesOfString:@"/opt/data/" withString:@""];
            
            NSString *url = [NSString stringWithFormat:@"%@%@",KHomeDomainUrl, str];
            
            
            [dict setValue:url forKey:@"url"];
            [dict setValue:[rs stringForColumn:@"show_name"] forKey:@"name"];
            
            [dataArray addObject:dict];
            
        }
        
        

        
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getNews
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"SELECT *from d_news "];
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {

        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            
            NSString *str = [[rs stringForColumn:@"icon"] stringByReplacingOccurrencesOfString:@"/opt/data/" withString:@""];
            
            NSString *url = [NSString stringWithFormat:@"%@%@",KHomeDomainUrl, str];
            
            
            [dict setValue:url forKey:@"url"];
            [dict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
            [dict setValue:[rs stringForColumn:@"content"] forKey:@"content"];
            [dict setValue:[rs stringForColumn:@"summary"] forKey:@"summary"];

            
            [dataArray addObject:dict];
            
        }
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}



- (NSMutableArray *)getPics
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select *  from d_photo  where status = '<null>'"];

//    加 唯一约束
//    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
//        案例icon  图片list
//        案例 list
//        设计师文档 list
//        手绘 list
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            

//            作品集合
            if ([rs intForColumn:@"type"] == 1) {

                
//                NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
                NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] init];

                NSString *store_name = [rs stringForColumn:@"store_name"];
                NSString *name = [[store_name componentsSeparatedByString:@"."] firstObject];
////                格式 一 445x340
//                NSString *url1 = [NSString stringWithFormat:@"%@/upload/445x340/%@", KHomeDomainUrl, store_name];
//                [dict1 setValue:url1 forKey:@"url"];
//                
//                ;
//                [dict1 setValue:[NSString stringWithFormat:@"%@445x340.%@", name,@"jpg"] forKey:@"name"];
//                [dataArray addObject:dict1];

                
//                格式 二  600x500
                NSString *url2 = [NSString stringWithFormat:@"%@/upload/600x500/%@", KHomeDomainUrl, store_name];
                [dict2 setValue:url2 forKey:@"url"];
                [dict2 setValue:[NSString stringWithFormat:@"%@600x500.%@", name,@"jpg"] forKey:@"name"];

                [dataArray addObject:dict2];
                
//                格式 三  全图
                NSString *url3 = [NSString stringWithFormat:@"%@/upload/%@", KHomeDomainUrl, store_name];
                [dict3 setValue:url3 forKey:@"url"];
                [dict3 setValue:[NSString stringWithFormat:@"%@.%@", name,@"jpg"] forKey:@"name"];
                
                [dataArray addObject:dict3];
//                NSString *url3 = [NSString stringWithFormat:@"%@/upload/929x673/%@", KHomeDomainUrl, store_name];
//                [dict3 setValue:url3 forKey:@"url"];
//                [dict3 setValue:[NSString stringWithFormat:@"%@929x673.%@", name,@"jpg"] forKey:@"name"];
//
//                [dataArray addObject:dict3];
                
            }

//            手绘
            if ([rs intForColumn:@"type"] == 2) {
                
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];

                NSString *store_name = [rs stringForColumn:@"store_name"];
                NSString *name = [[store_name componentsSeparatedByString:@"."] firstObject];

                //                格式 一 445x340
                NSString *url1 = [NSString stringWithFormat:@"%@/upload/895x577/%@", KHomeDomainUrl, store_name];
                [dict setValue:[NSString stringWithFormat:@"%@895x577.%@", name,@"jpg"] forKey:@"name"];

                [dict setValue:url1 forKey:@"url"];
                [dataArray addObject:dict];

            }
            
            

        }
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getPicsForProductId:(NSString *)pro_id
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select *  from picture  where statue = 1 and product_id = %@", pro_id];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"picture_id"]] forKey:@"picture_id"];
            [dict setValue:[rs stringForColumn:@"url"] forKey:@"url"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;

}


- (NSMutableArray *)getDetailForProductId:(NSString *)pro_id
{
    
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select pd.standard, pd.name, pd.price, pb.remark   from product_detil pd, product_base pb where pb.product_id = pd.product_id and pd.product_id =  %@", pro_id];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs doubleForColumn:@"price"]] forKey:@"price"];
            [dict setValue:[rs stringForColumn:@"standard"] forKey:@"standard"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            [dict setValue:[rs stringForColumn:@"remark"] forKey:@"remark"];
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
    
    
    
}


- (NSMutableArray *)getProductForCategory:(NSString * )cateId
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select   pd.product_id, pb.remark pb_remark, pb.letter pb_letter, pb.number pb_number,pd.name pd_name, ct.name ct_name from product_base pb, product_detil pd, category ct WHERE pb.product_id = pd.product_id and  pb.cate_id = ct.cate_id  and pb.cate_id = %@ GROUP BY pb.product_id", cateId];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"product_id"]] forKey:@"product_id"];
            [dict setValue:[rs stringForColumn:@"pd_name"] forKey:@"pd_name"];
            [dict setValue:[rs stringForColumn:@"ct_name"] forKey:@"ct_name"];
            [dict setValue:[rs stringForColumn:@"pb_number"] forKey:@"pb_number"];
            [dict setValue:[rs stringForColumn:@"pb_letter"] forKey:@"pb_letter"];
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    return dataArray;
}


- (NSMutableArray *)getSubCateForCategory:(NSString * )cateId
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select *  from category  where fid = %@", cateId];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"cate_id"]] forKey:@"cate_id"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getProductForSerices:(NSString * )sericesId
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select   pd.product_id, pb.remark remark,pb.letter pb_letter, pb.number pb_number,pd.name pd_name, ct.name ct_name from product_base pb, product_detil pd, category ct WHERE pb.product_id = pd.product_id and  pb.cate_id = ct.cate_id  and pb.series_id = %@ GROUP BY pb.product_id", sericesId];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"product_id"]] forKey:@"product_id"];
            [dict setValue:[rs stringForColumn:@"pd_name"] forKey:@"pd_name"];
            [dict setValue:[rs stringForColumn:@"ct_name"] forKey:@"ct_name"];
            [dict setValue:[rs stringForColumn:@"pb_number"] forKey:@"pb_number"];
            [dict setValue:[rs stringForColumn:@"pb_letter"] forKey:@"pb_letter"];
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}







- (void)updatePicDownLoaded:(NSString *)pid
{
    NSString *sqlString = [NSString stringWithFormat:
                           @"update d_photo set status = 1 where id = %@", pid];
    
    [self stringToDBSqlString:sqlString];
}

- (void)updatePDFDownLoaded:(NSString *)pid
{
    NSString *sqlString = [NSString stringWithFormat:
                           @"update d_file set status = 1 where id = %@", pid];
    
    [self stringToDBSqlString:sqlString];
}




- (void)deleteAllData
{
    NSString *sqlString = [NSString stringWithFormat:
                           @"delete from d_ablum&$&delete from d_ablum_photo&$&delete from d_ablum_tag&$&delete from d_designer&$&delete from d_file&$&delete from d_file_rela&$&delete from d_news&$&delete from d_photo&$&delete from d_photo_rela&$&delete from d_tag&$&"];
    
    [self insertTable:sqlString];
    

}

- (NSMutableDictionary *)getDesignerForD_Id:(NSString * )designer_id
{
    
    
    NSMutableDictionary *dataDict  = [[NSMutableDictionary alloc] init];
    
//    select real_name, mobile, email, adress, introduction from "d_designer" d, "d_user" u where d.user_ID = u.id
//    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select * from d_designer where id = %@", designer_id];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"real_name"] forKey:@"real_name"];
            [dict setValue:[rs stringForColumn:@"mobile"] forKey:@"mobile"];
            [dict setValue:[rs stringForColumn:@"email"] forKey:@"email"];
            [dict setValue:[rs stringForColumn:@"address"] forKey:@"address"];
            [dict setValue:[rs stringForColumn:@"introduction"] forKey:@"introduction"];
            
            

            dataDict = dict;
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataDict;

}


// 获取推荐 案例列表

- (NSMutableArray *)getCasesRecommendForD_Id:(NSString * )designer_id
{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select a.id, a.name a_name, a.content content, p.store_name p_name, p.path from d_ablum a, d_photo p where a.chief_photo = p.id and a.recommend = 1 "];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"a_name"] forKey:@"a_name"];
            [dict setValue:[rs stringForColumn:@"p_name"] forKey:@"p_name"];
            [dict setValue:[rs stringForColumn:@"content"] forKey:@"content"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    return dataArray;
}

// 获取案例列表

- (NSMutableArray *)getCasesForD_Id:(NSString * )designer_id
{
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select a.id, a.name a_name, a.content content, p.store_name p_name, p.path from d_ablum a, d_photo p where a.chief_photo = p.id "];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"a_name"] forKey:@"a_name"];
            [dict setValue:[rs stringForColumn:@"p_name"] forKey:@"p_name"];
            [dict setValue:[rs stringForColumn:@"content"] forKey:@"content"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];

            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }

    return dataArray;
}

- (NSMutableArray *)getCasesDetailForC_Id:(NSString * )case_id
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
//    select p.id , ap.photo_id, p.name, p.path, p.store_name from d_ablum_photo ap, d_photo p where ap.photo_id = p.id and  ap.ablum_id = 1

    NSString *sqlString = [NSString stringWithFormat:
                           @"select p.id , ap.photo_id, p.name, p.path, p.store_name from d_ablum_photo ap, d_photo p where ap.photo_id = p.id and  ap.ablum_id = %@;", case_id];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"photo_id"] forKey:@"photo_id"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];
            [dict setValue:[rs stringForColumn:@"store_name"] forKey:@"store_name"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    
    

    
    return dataArray;
}

// 获取手绘列表
- (NSMutableArray *)getPhotoForD_Id:(NSString * )designer_id
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    //    select p.id , ap.photo_id, p.name, p.path, p.store_name from d_ablum_photo ap, d_photo p where ap.photo_id = p.id and  ap.ablum_id = 1
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select id  name, path, store_name from  d_photo  where  type = 2"];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];
            [dict setValue:[rs stringForColumn:@"store_name"] forKey:@"store_name"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    
    
    
    
    return dataArray;
}

// 获取设计师 文档 列表
- (NSMutableArray *)getFilesForD_Id:(NSString * )designer_id
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"SELECT * from d_file"];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"show_name"] forKey:@"show_name"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];

            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


- (NSMutableArray *)getTagsForD_Id:(NSString * )designer_id
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select sort, name from d_tag where des_id = %@ group by sort ", designer_id];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"sort"]] forKey:@"sort"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}

- (NSMutableArray *)getCaseForTags:(NSMutableArray * )tagsArray
{

    NSMutableString *str = [NSMutableString stringWithFormat:@""];
    
    for (NSString *s in tagsArray) {


        [str appendFormat:@"%@,", s];
    }
    
    if (str.length > 1) {
        str = (NSMutableString *)[str substringWithRange:NSMakeRange(0, str.length-1)];
    }

    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select  a.id, a.name a_name, p.store_name p_name, p.path , a.content content from d_ablum a, d_photo p where a.chief_photo = p.id and a.id in (select DISTINCT ablum_id from d_ablum_tag where d_ablum_tag.tag_id in(%@))", str];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"a_name"] forKey:@"a_name"];
            [dict setValue:[rs stringForColumn:@"p_name"] forKey:@"p_name"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];
            [dict setValue:[rs stringForColumn:@"content"] forKey:@"content"];

            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
    
}

- (NSMutableArray *)getCaseForWords:(NSString * )keyWord
{
    
 
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select  a.id, a.name a_name, p.store_name p_name, p.path   from d_ablum a, d_photo p where a.chief_photo=p.id and a.name like  '%%%@%%'", keyWord];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[rs stringForColumn:@"a_name"] forKey:@"a_name"];
            [dict setValue:[rs stringForColumn:@"p_name"] forKey:@"p_name"];
            [dict setValue:[rs stringForColumn:@"path"] forKey:@"path"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}



- (NSMutableArray *)getTagsForSort:(NSString * )sort
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    NSString *sqlString = [NSString stringWithFormat:
                           @"select id,sort, name  from d_tag where sort = %@ ", sort];
    
    
    if (![db open]) {
        
        DLog (@"Could not open db.");
    }
    else {
        
        
        FMResultSet *rs = [db executeQuery:sqlString];
        
        while ([rs next]) {
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
            [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"sort"]] forKey:@"sort"];
            [dict setValue:[rs stringForColumn:@"name"] forKey:@"name"];
            
            
            
            [dataArray addObject:dict];
            
        }
        
        
        [rs close];
        [db close];
        
    }
    
    
    return dataArray;
}


@end
