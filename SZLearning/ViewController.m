//
//  ViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/12.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ViewController.h"

#import "Color.h"

#import <JHChainableAnimations.h>
#import "AsyncDisplayKitTestViewController.h"   //scheme 跳转
#import "SZGradientProgressView.h"

#if DEBUG
#import <FLEXManager.h>
#endif

@interface ViewController ()

///test JHChainableAnimaitons
@property (nonatomic, strong) UIImageView *animtaionView;

///<#说明#>
@property (nonatomic, assign) CGRect expandFrame;
///<#说明#>
@property (nonatomic, assign) CGRect collapsedFrame;
///<#说明#>
@property (nonatomic, assign) CGRect expandBounds;
///<#说明#>
@property (nonatomic, assign) CGRect collapsedBounds;

///<#说明#>
@property (nonatomic, assign) BOOL isExpand;

@end

@implementation ViewController



#pragma mark -Life cycle            //生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(200, 200, 255);
    
    [self addFLEXDebug];
    
    [self addView];
    //[self addLayout];
    
}

- (void)addView {
    [self.view addSubview:self.animtaionView];
}

- (void)addLayout {
    [self.animtaionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(@100);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
    }];
}

#pragma mark -Delegate              //所有代理方法  顺序


#pragma mark -Event response        //事件回应
/**
 *  FLEX 点击事件   测试
 */
- (void)flexButtonTapped:(id)sender
{
#if DEBUG
    // This call shows the FLEX toolbar if it's not already shown.
    [[FLEXManager sharedManager] showExplorer];
#endif
}

/**
 *  图片点击事件
 *
 *  @param tap 跳转 AsyncDisplayKit test
 */
- (void)imageTap:(UITapGestureRecognizer *)tap {
    [self.navigationController pushViewController:[[AsyncDisplayKitTestViewController alloc] init] animated:YES];
    UIView *view = tap.view;
    if (tap.view.layer.pop_animationKeys.count > 0) {
        return;
    }
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    if (CGRectGetWidth(view.frame) == CGRectGetHeight(view.frame)) {
        anim.toValue = [NSValue valueWithCGRect:CGRectInset(view.frame, -100, 0)];
        anim.springBounciness = 13;
    } else {
        anim.toValue = [NSValue valueWithCGRect:CGRectInset(view.frame, 100, 0)];
    }
    anim.springSpeed = 10;
    [view.layer pop_addAnimation:anim forKey:@"layerBounds"];

}

#pragma mark -Private methods       //私有方法
/**
 *  添加FLEX( DEBUG 模式下)
 */
- (void)addFLEXDebug {
#if DEBUG
    [self registerViewControllerBasedOption];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
#endif
}

- (void)registerViewControllerBasedOption
{
    // create UIViewController subclass
    UIViewController *viewController = [[UIViewController alloc] init];
    
    // fill it with some stuff
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.text = @"Add switches, notes or whatewer you wish to provide your testers with superpowers!";
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = viewController.view;
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:infoLabel];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[infoLabel]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(infoLabel)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[infoLabel]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(infoLabel)]];
    // return it in viewControllerFutureBlock
#if DEBUG
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"🛃  Custom Superpowers"
                                   viewControllerFutureBlock:^id{
                                       return viewController;
                                   }];
#endif
}

#pragma mark -Getters and Setters   //设置方法

- (UIImageView *)animtaionView {
    if (!_animtaionView) {
        _animtaionView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-30, 100, 44, 44)];
        _animtaionView.backgroundColor = HexColor(@"24b8c5");
        _animtaionView.layer.cornerRadius = 22;
        _animtaionView.clipsToBounds = YES;
        
        _animtaionView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [_animtaionView addGestureRecognizer:tap];
        

    }
    return _animtaionView;
}



@end
