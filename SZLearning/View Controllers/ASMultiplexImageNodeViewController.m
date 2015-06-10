//
//  ASMultiplexImageNodeViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/19.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASMultiplexImageNodeViewController.h"



@interface ASMultiplexImageNodeViewController ()<ASImageDownloaderProtocol, ASMultiplexImageNodeDelegate, ASMultiplexImageNodeDataSource>

///图片多重下载
@property (nonatomic, strong) ASMultiplexImageNode *imageNode;
///text
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation ASMultiplexImageNodeViewController



#pragma mark -Life cycle            //生命周期

- (instancetype)init {
    if (self = [super init]) {
        [self preConfigUI];
    }
    return self;
}

/**
 *  在viewController init 的时候, 就异步实现 UI
 */
- (void)preConfigUI {
    
    
    
    
    /**  1. 怎么使用cache
     */
    _imageNode = [[ASMultiplexImageNode alloc] initWithCache:nil downloader:self];
    _imageNode.delegate = self;
    _imageNode.dataSource = self;
    //_imageNode.cropRect = CGRectMake(0.01, 0, 0, 0);
    
    /* 下载 低分辨率 的图片 */
    /*  说明:  当设定为yes时   首先下载指定的 高分辨率的图片  只有在高分辨率的图片 没有缓冲 或 不能立即取到图片的情况下, 才会加载 low-quality 图片 */
    _imageNode.downloadsIntermediateImages = YES;
    _imageNode.imageModificationBlock = ASImageNodeRoundBorderModificationBlock(5, [UIColor whiteColor]);
    _imageNode.placeholderColor = [UIColor yellowColor];
    _imageNode.image = [UIImage imageNamed:@"cardPlaceholder"];
    
    
    
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLabelTap:)];
    [_textLabel addGestureRecognizer:tap];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexColor(24b8c5);
    
    [self.view addSubview:_imageNode.view];
    [self.view addSubview:_textLabel];
    
    [self start];
}

- (void)start {
    _textLabel.text = @"loading...";
    _textLabel.userInteractionEnabled = NO;
    
    
    /** 1. 设置时需要注意, 第一个默认为最优分辨率
     */
    /** 2. 💡 当设置为3个时, medium 什么时候加载？
     */
    _imageNode.imageIdentifiers = @[@"best", @"medium", @"worst"];
}

- (void)viewWillLayoutSubviews {
    static CGFloat padding = 40.0f;
    
    // lay out image
    CGFloat imageWidth = self.view.bounds.size.width - padding;
    CGPoint imageOrigin = CGPointMake(roundf((self.view.bounds.size.width - imageWidth) / 2.0f),
                                      roundf((self.view.bounds.size.height - imageWidth) / 2.0f));
    _imageNode.frame = (CGRect){ imageOrigin, CGSizeMake(imageWidth, imageWidth) };
    
    
    // label
    CGSize textSize = [_textLabel sizeThatFits:CGSizeMake(self.view.bounds.size.width, FLT_MAX)];
    _textLabel.frame = CGRectMake(0.0f, imageOrigin.y + imageWidth + padding, self.view.bounds.size.width, textSize.height);
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

#pragma mark -Delegate              //所有代理方法  顺序

/**
 *  ASMultiplexImage data source & delegate
 */
- (NSURL *)multiplexImageNode:(ASMultiplexImageNode *)imageNode URLForImageIdentifier:(id)imageIdentifier {
    if ([imageIdentifier isEqualToString:@"worst"]) {
        return [NSURL URLWithString:@"http://static.uthing.cn/photo/1/90/RE1YXl0/180x135"];
    }
    
    if ([imageIdentifier isEqualToString:@"medium"]) {
        return [NSURL URLWithString:@"http://static.uthing.cn/photo/1/90/RE1YXl0/640x423"];
    }
    
    if ([imageIdentifier isEqualToString:@"best"]) {
        return [NSURL URLWithString:@"http://static.uthing.cn/photo/1/90/RE1YXl0/index"];
    }
    
    // unexpected identifier
    return nil;
}

//- (UIImage *)multiplexImageNode:(ASMultiplexImageNode *)imageNode imageForImageIdentifier:(id)imageIdentifier {
//    if ([imageIdentifier isEqualToString:@"medium"]) {
//        return [UIImage imageNamed:@"macaw"];
//    }
//    if ([imageIdentifier isEqualToString:@"worst"]) {
//        return [UIImage imageNamed:@"macaw"];
//    }
//    if ([imageIdentifier isEqualToString:@"best"]) {
//        return [UIImage imageNamed:@"macaw"];
//    }
//    
//    return nil;
//}

- (void)multiplexImageNode:(ASMultiplexImageNode *)imageNode didFinishDownloadingImageWithIdentifier:(id)imageIdentifier error:(NSError *)error {
    _textLabel.text = [NSString stringWithFormat:@"loaded '%@'", imageIdentifier];
    
    if ([imageIdentifier isEqualToString:@"best"]) {
        _textLabel.text = [_textLabel.text stringByAppendingString:@". tap to reload"];
        _textLabel.userInteractionEnabled = YES;
    }
}


/**
 *  ASImageDownloaderProtocol
 */
- (id)downloadImageWithURL:(NSURL *)URL callbackQueue:(dispatch_queue_t)callbackQueue downloadProgressBlock:(void (^)(CGFloat))downloadProgressBlock completion:(void (^)(CGImageRef, NSError *))completion {
    /** 1.由方法说明可知  当queue 值为nil  需要回到主线程
     */
    if (callbackQueue == nil) {
        callbackQueue = dispatch_get_main_queue();
    }
    
    // call completion blocks
    void (^handler)(NSURLResponse *, NSData *, NSError *) = ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // add an artificial delay
        usleep(1.0 * USEC_PER_SEC);
        
        // ASMultiplexImageNode callbacks
        dispatch_async(callbackQueue, ^{
            if (downloadProgressBlock) {
                downloadProgressBlock(1.0f);
            }
            
            if (completion) {
                completion([[UIImage imageWithData:data] CGImage], connectionError);
            }
        });
    };
    
    // let NSURLConnection do the heavy lifting
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:handler];
    
    // return nil, don't support cancellation
    return nil;
}

- (void)cancelImageDownloadForIdentifier:(id)downloadIdentifier {
    
}



#pragma mark -Event response        //事件回应

/**
 *  textLabel 点击事件
 */
- (void)textLabelTap:(id)sender {
    [self start];
    
    /** 1. 通知接收者 identifier 有新的url或者image
     */
    
    [_imageNode reloadImageIdentifierSources];
}


#pragma mark -Private methods       //私有方法


#pragma mark -Getters and Setters   //设置方法



@end
