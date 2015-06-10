//
//  SZCoreDataManager.h
//  SZLearning
//
//  Created by Apple on 15/5/23.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZCoreDataManager : NSObject

+ (instancetype)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)moc;

@end
