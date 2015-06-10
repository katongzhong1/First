//
//  CardInfoModel.h
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardInfoModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *descriptionString;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *articleAttribution;
@property (nonatomic,strong) NSString *articleOriginLink;
@property (nonatomic,strong) NSString *articleLicense;
@property (nonatomic,strong) NSString *articleLicenseLink;
@property (nonatomic,strong) NSString *imageAttribution;
@property (nonatomic,strong) NSString *imageOriginLink;
@property (nonatomic,strong) NSString *imageLicense;
@property (nonatomic,strong) NSString *imageLicenseLink;

@end

@interface CardInfo : NSObject

- (NSArray *)getCardInfo;

@end
