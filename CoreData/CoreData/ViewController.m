//
//  ViewController.m
//  CoreData
//
//  Created by andy on 11/20/14.
//  Copyright (c) 2014 ric. All rights reserved.
//

#import "ViewController.h"
#import "BaseModelEntity.h"
#import "JXCoreDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];



    JXCoreDataManager *manager = [JXCoreDataManager shareManager];
    
    [manager insertObjectWithEntityName:@"BaseModelEntity"
                               setValue:^(NSManagedObject *object) {
                                   
                                   BaseModelEntity *entity = (BaseModelEntity *)object;
                                   
                                   entity.username = @"JinJianXiang";
                                   entity.password = @"JinJianXiang";
                                   entity.registDate = [NSDate date];
                                   
                               } complete:^(NSError *error) {
        
                                   if (error) {
                                       NSLog(@"插入失败");
                                       return;
                                   }
                                   
                                   NSLog(@"插入成功");
                               }];
    
    [[JXCoreDataManager shareManager] selectObjectWithEntytyName:@"BaseModelEntity"
                                                sortDescriptions:nil
                                                        complete:^(NSArray *result, NSError *error) {
        
                                                            if (error) {
                                                                NSLog(@"查询有误");
                                                                return;
                                                            }
                                                            
                                                            NSLog(@"%ld", result.count);
                                                        }];

}


@end
