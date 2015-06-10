//
//  CardInfoCellNode.h
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASCellNode.h"

#import "CardInfoModel.h"

@interface CardInfoCellNode : ASCellNode

- (void)configureCellDisplayWithCardInfo:(CardInfoModel *)model nodeConstructionQueue:(NSOperationQueue *)queue;

@end
