//
//  Experience.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/8.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#pragma mark - 💡

/**
 *  1.界面间的切换效果 ARTransitonAnimator   https://github.com/AugustRush/ARTransitionAnimator
 
 *  2. 脸部图片识别  https://github.com/croath/UIImageView-BetterFace
 */

##pragma mark - 常用路径

/*
 
 1.代码片段路径：~/Library/Developer/Xcode/UserData/CodeSnippets
 
 */

#pragma mark - 优秀文章、博客记录

/* 
 一、文章
 1.iPhone屏幕尺寸、分辨率及适配 (http://blog.csdn.net/phunxm/article/details/42174937 )
 2.项目管理：CocoaPods建立私有仓库 (http://www.cocoachina.com/ios/20150508/11785.html )
 3.学习资料整理 (http://zixun.github.io/blog/2014/03/06/iosxue-xi-zi-liao-zheng-li/#applewatch )
 4.开发资源整理 (https://github.com/lyfeyaj/awesome-resources )
 5.OC- runtime  http://yulingtianxia.com/blog/2014/11/05/objective-c-runtime/
 
 二、测试
 1.Unit test: (http://ocmock.org/features/ ) 
  [iOS单元测试系列]-译-OCMock常见使用方式 (http://www.cocoachina.com/ios/20150508/11769.html )
 
 2.Realm 数据库基础教程 (http://www.cocoachina.com/ios/20150505/11756.html )
 */

#pragma mark - 常见问题解决方案
/*
 
 1.使用CocoaPods导入头文件不能提示？
   在BuildSettings中搜索Header Search Path，然后设置$(PODS_ROOT),并勾选recursive支持递归搜索。
   (方法二: )在build settings -->Search Paths-->User Header Search Paths 然后设置$(PODS_ROOT)
 2.CocoaPods pod install/pod update更新慢的问题  (升级CocoaPods的spec仓库)
    pod install --verbose --no-repo-update
    pod update --verbose --no-repo-update
 
 
 2.导入pch文件 http://www.cnblogs.com/YouXianMing/p/3989155.html
 (1)Building Setting中搜索pref
 (2)将Prefix Header的值设为 $(SRCROOT)/$(PRODUCT_NAME)/$(PRODUCT_NAME).pch
 
 3.自动轮播视图NSTimer的释放问题
 是否可以通过监听view的window属性值来判断是否在当前窗口显示
 封装使用UIViewController,利用viewWillAppear和 viewDidDisAppear 方法在内部控制NStimer的释放
 
 4.警告消除方式 (http://www.cocoachina.com/ios/20141218/10678.html )
 (1).方式一:  
     #pragma clang diagnostic push
     ￼#pragma clang diagnostic ignored "警告名称"
     ￼// 被夹在这中间的代码针对于此警告都会无视并且不显示出来
     ￼#pragma clang diagnostic pop
 (2).方式二:
     常见的警告的规范名称与查找方法，只列举一种：
     没用上的变量      -Wunused-variable
     编译过后，在左上最后一个分标签“编译信息”中，能找到如上格式的警告分类
 (3).方式三:
     当然，也可以在pch等具有大范围作用域的头文件中包含：
     ￼#pragma clang diagnostic ignored "警告名称"
     如果剔除了push与pop
     则后面所有的代码都具有强制消除警告作用
 (4).去掉cocoapod中引入的第三方左右警告  加入  inhibit_all_warnings

 5.NSLogger define NSLog(…) LogMessageF( __FILE__,__LINE__,__FUNCTION__, NULL, 0, __VA_ARGS__)
 
 
 pragma mark - 5月12日
 1.NSLogger
 2.FLEX
 3.Chisel
 4.Synx (https://github.com/venmo/synx )
 
 
 */


#pragma mark - xcode 插件使用 

/**
 1 . Stencil 通过定制file模版来新建file  
 */

#pragma mark - xcode  第三方库

/**
 1 . JTSImageViewController   交互式的IOS图片查看器
 */

#pragma mark - 常用代码片段 快捷键

/*
 
 //注释类
 1.汉字注释:                            an
 2.viewController代码分类:              pr
 3.pragma mark - 说明:                 pam
 
 
 4.private Interface:                  pi
 5.属性定义:(Property Strong)           ps
 
 */

##pragma mark - xcode tips

/* 
 ⌘ Command
 ⇧ Shift
 ⌥ Option
 ⌃ Control
 ↩ Return
 
 1. 快速定位导航条file所在位置: 'Command'+'Shift'+'J'
 2. 显示描述内容:             'Option'
 */


/* 
 1. xcode 的清理  
 (1).finder中找到 /Users/apple/Library/Developer/Xcode 里面有DerivedData和Snapshots两个文件夹，删除里面文件即可
 */


#pragma mark - test  

/**
 *  OCLint (http://www.tuicool.com/articles/AnEnMzf)
 
 *  使用 
        1.在bash中通过cd命令进到需要lint的工程路径下
        2.在bash中执行：xcodebuild | tee xcodebuild.log （此命令调用xcodebuild进行了编译并把相关日志信息输入到xcodebuild.log，该log文件是后续步骤的必要条件，生成在当前的工程目录中）
        3.在bash中执行 oclint-xcodebuild xcodebuild.log （此步骤是利用之前的.log文件通过oclint-xcodebuild的可执行文件生成了名为compile_commands.json的json格式文件，该文件应该包含了多组内容，其中的key分别为directory、command、file，该文件不应该为空。此文件是下一步输入的必要条件。）
        4.在bash中执行 oclint-json-compilation-database，此步骤是真正执行了lint，执行完应该在终端输出结果。
 */


















