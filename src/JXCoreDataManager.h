//
//  JXCoreDataManager.h
//  CoreData
//
//  Created by andy on 11/20/14.
//  Copyright (c) 2014 ric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#define CORE_DATE_SQLITE_PATH [NSString stringWithFormat:@"%@/Documents/CoreDate.sqlite", NSHomeDirectory()]

@interface JXCoreDataManager : NSObject
{

}

+ (JXCoreDataManager *)shareManager;

/**
 *  插入数据库
 *
 *  @param name          模型名称
 *  @param setValueBlock 模型赋值Block
 *  @param completeBlock 插入完成, 数据回调
 */
- (void)insertObjectWithEntityName:(NSString *)name
                          setValue:(void (^)(NSManagedObject *object))setValueBlock
                          complete:(void (^)(NSError *error))completeBlock;

/**
 *  查询数据库
 *
 *  @param name             模型名称
 *  @param sortDescriptions 排序描述     
 
  元素为--> [[NSSortDescriptor alloc] initWithKey:(string 属性Key) 
                                       ascending:(bool   是否升序)]

 *  @param completeBlock    查询完成, 数据回调
 */
- (void)selectObjectWithEntytyName:(NSString *)name
                  sortDescriptions:(NSArray *)sortDescriptions
                          complete:(void (^)(NSArray *result, NSError *error))completeBlock;

@end
