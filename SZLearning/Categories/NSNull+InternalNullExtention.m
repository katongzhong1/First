//
//  NSNull+InternalNullExtention.m
//  Uthing3.0
//
//  Created by Apple on 15/3/24.
//  Copyright (c) 2015年 wushengzhong. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"

@implementation NSNull (InternalNullExtention)



- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self doesNotRecognizeSelector:aSelector];
}


//日本人的一个封装方案
//- (void)forwardInvocation:(NSInvocation *)invocation
//{
//    if ([self respondsToSelector:[invocation selector]]) {
//        [invocation invokeWithTarget:self];
//    }
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
//{
//    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
//    if(sig == nil) {
//        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
//    }
//    return sig;
//}

@end
