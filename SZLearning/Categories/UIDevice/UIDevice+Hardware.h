//
//  UIDevice+Hardware.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/6.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  IOS设备信息
 */

/* 设备类型枚举 */
typedef NS_ENUM(NSUInteger, UIDeviceFamily) {
    UIDeviceFamilyiPhone,
    UIDeviceFamilyiPod,
    UIDeviceFamilyiPad,
    UIDeviceFamilyAppleTV,
    UIDeviceFamilyUnknown,
};

typedef enum
{
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6,
    IPHONE_6_PLUS,
    
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    
    SIMULATOR
} Hardware;


@interface UIDevice (Hardware)

/* 设备平台: 模拟器、iPhone、iPod、iPad、AppleTV */

/** This method retruns the hardware type */
- (NSString*)hardwareString;

/** This method returns the Hardware enum depending upon harware string */
- (Hardware)hardware;

/** This method returns the readable description of hardware string */
- (NSString*)hardwareDescription;

/** This method returs the readble description without identifier (GSM, CDMA, GLOBAL) */
- (NSString *)hardwareSimpleDescription;

/** This method returns YES if the current device is better than the hardware passed */
- (BOOL)isCurrentDeviceHardwareBetterThan:(Hardware)hardware;

/** This method returns the resolution for still image that can be received
 from back camera of the current device. Resolution returned for image oriented landscape right. **/
- (CGSize)backCameraStillImageResolutionInPixels;

/* CPU频率 */
- (NSUInteger) cpuFrequency;
/* 设备总线频率 */
- (NSUInteger) busFrequency;       //理解请查看知识点1
/* CPU个数(核数) */
- (NSUInteger) cpuCount;
/* 设备总内存 */
- (NSUInteger) totalMemory;
/* 设备正使用内存 */
- (NSUInteger) userMemory;

/* 设备总存储空间 */
- (NSNumber *) totalDiskSpace;
/* 设备空闲存储空间 */
- (NSNumber *) freeDiskSpace;

/* 设备mac地址 */
- (NSString *) macaddress;

/* 设备是否使用Retina屏 */
- (BOOL) hasRetinaDisplay;

/* 设备类型 */
- (UIDeviceFamily) deviceFamily;

/// Orta
+ (BOOL)isPad;
+ (BOOL)isPhone;
+ (BOOL)isRunningUnitTests;
- (NSString *)deviceFamilyString;

@end

#pragma mark - 知识点

//知识点 1.bus  总线
/* 总线（Bus）是计算机各种功能部件之间传送信息的公共通信干线，它是由导线组成的传输线束， 按照计算机所传输的信息种类，计算机的总线可以划分为数据总线、地址总线和控制总线，分别用来传输数据、数据地址和控制信号。*/


