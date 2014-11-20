//
//  ViewController.h
//  CoreData
//
//  Created by andy on 11/20/14.
//  Copyright (c) 2014 ric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
 *  数据模型对象
 */
@property (nonatomic, strong) NSManagedObjectModel *managerObjectMoedel;

/**
 *  上下文对象
 */
@property (nonatomic, strong) NSManagedObjectContext *managerObjectContext;

/**
 *  持久性存储区
 */
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end

