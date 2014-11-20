//
//  JXCoreDataManager.m
//  CoreData
//
//  Created by andy on 11/20/14.
//  Copyright (c) 2014 ric. All rights reserved.
//

#import "JXCoreDataManager.h"

@interface JXCoreDataManager ()
@property (nonatomic, strong) NSManagedObjectModel *managerObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managerObjectContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation JXCoreDataManager

+ (instancetype)shareManager
{
    static JXCoreDataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

/**
 *  插入数据库
 */
- (void)insertObjectWithEntityName:(NSString *)name setValue:(void (^)(NSManagedObject *))setValueBlock complete:(void (^)(NSError *))completeBlock
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
    
    setValueBlock(object);
    
    NSError *error;
    [self.managedObjectContext save:&error];

    completeBlock(error);
}

/**
 *  查询数据库
 */
- (void)selectObjectWithEntytyName:(NSString *)name sortDescriptions:(NSArray *)sortDescriptions complete:(void (^)(NSArray *, NSError *))completeBlock
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:name inManagedObjectContext:self.managedObjectContext];
   
    [request setEntity:entity];
    [request setSortDescriptors:sortDescriptions];

    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request
                                                               error:&error];
    completeBlock(result, error);
}


#pragma mark -
#pragma mark CoreDate Init

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managerObjectModel != nil) {
        return _managerObjectModel;
    }
    _managerObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managerObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
        
    NSURL *sqliteURL = [NSURL fileURLWithPath:CORE_DATE_SQLITE_PATH];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:sqliteURL
                                                         options:nil error:&error]) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managerObjectContext != nil) {
        return _managerObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator =[self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        _managerObjectContext = [[NSManagedObjectContext alloc]init];
        [_managerObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return _managerObjectContext;
}

@end
