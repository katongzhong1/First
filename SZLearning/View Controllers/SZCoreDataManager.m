//
//  SZCoreDataManager.m
//  SZLearning
//
//  Created by Apple on 15/5/23.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "SZCoreDataManager.h"
#import <CoreData/CoreData.h>

@implementation SZCoreDataManager

+ (NSString *)entityName {
    return @"Item";
}

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName]
                                         inManagedObjectContext:moc];
}

@end
