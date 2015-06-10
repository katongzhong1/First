//
//  UploadImageTool.m
//  SZLearning
//
//  Created by Apple on 15/5/28.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "UploadImageTool.h"

@implementation UploadImageTool

- (void)uploadTheImage {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-type
    NSString *contenType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", @"23445"];  //"BoundaryConstant" is basically the variable "boundary" which is essentially a random (NSString *)
    [request setValue:contenType forHTTPHeaderField:@"Content-Type"];
    
    // post body
    //NSMutableData *body = [NSMutableData data];
    
    // add params
//    for (<#initialization#>; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
}

@end
