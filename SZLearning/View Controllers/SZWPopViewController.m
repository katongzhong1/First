//
//  SZWPopViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/21.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "SZWPopViewController.h"
#import "PopListCellNode.h"

#import "PaperFoldView.h"

#import "ButtonViewController.h"
#import "FoldingAnimationViewController.h"
#import "TransformViewController.h"
#import "TransitionViewController.h"
#import "ReactiveCocoaViewController.h"
#import "MontionViewController.h"

@interface SZWPopViewController ()<ASTableViewDelegate, ASTableViewDataSource, PaperFoldViewDelegate>

///viewController 数组
@property (nonatomic, strong) NSArray *items;
///ASTableView
@property (nonatomic, strong) ASTableView *asTableView;
/// FoldView
@property (nonatomic, strong) PaperFoldView *paperFoldView;
/// mapVie
@property (nonatomic, strong) UIView *mapView;

@end

@implementation SZWPopViewController



#pragma mark -Life cycle            //生命周期

- (instancetype)init {
    if (self = [super init]) {
        [self preConfigTheSubView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setFace];
    
    // asTableView
    [self.view addSubview:self.paperFoldView];
    [_paperFoldView setRightFoldContentView:self.mapView foldCount:3 pullFactor:0.8];
    [_paperFoldView setCenterContentView:self.asTableView];
}

#pragma mark -Delegate              //所有代理方法  顺序

//TODO: ASDisplayNode+UIViewBridge.mm  134  @"Must be an identity transform 待修复

/**
 *
 *  ASTableView    delegate  and datasource
 */
- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self nodeForRowAindexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [self viewControllerForRowAtIndexPath:indexPath];
    vc.navigationItem.titleView = [self labelWithString:[self titleForRowAtIndexPath:indexPath]];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)paperFoldView:(id)paperFoldView didFoldAutomatically:(BOOL)automated toState:(PaperFoldState)paperFoldState
{
    NSLog(@"did transition to state %i automated %i", paperFoldState, automated);
}


#pragma mark -Event response        //事件回应


#pragma mark -Private methods       //私有方法

- (void)setFace {

    self.navigationItem.titleView = [self labelWithString:@"poping"];
    
    self.view.backgroundColor = [UIColor flatGreenColor];
}

- (FBShimmeringView *)labelWithString:(NSString *)title {
    FBShimmeringView *shimmerView = [[FBShimmeringView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont fontWithName:@"AvenirNext-Heavy" size:20];
    [label sizeToFit];
    label.textColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:label.frame andColors:@[[UIColor flatYellowColor], [UIColor flatRedColor], [UIColor flatOrangeColor]]];
    
    shimmerView.frame = label.frame;
    shimmerView.contentView = label;
    
    shimmerView.shimmering = YES;
    shimmerView.shimmeringSpeed = 140;
    shimmerView.shimmeringHighlightWidth = 0.2;
    shimmerView.shimmeringOpacity = .9;
    return shimmerView;
}

/**
 *
 */
- (void)preConfigTheSubView {
    // viewControllers
    self.items = @[@[@"ImageView Animation", [ButtonViewController class]],
                   @[@"Folding Animation", [FoldingAnimationViewController class]],
                   @[@"Transform", [TransformViewController class]],
                   @[@"Transition", [TransitionViewController class]],
                   @[@"ReactiveCocoa", [ReactiveCocoaViewController class]],
                   @[@"MontionVC", [MontionViewController class]]];
}

/**
 *  返回自定制的 ASCellNode
 */
- (ASCellNode *)nodeForRowAindexPath:(NSIndexPath *)indexPath {
    PopListCellNode *cellNode = [[PopListCellNode alloc] init];
    cellNode.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cellNode.text = [self.items[indexPath.row] firstObject];
    
    return cellNode;
}

- (NSString *)titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.items[indexPath.row] firstObject];
}

- (UIViewController *)viewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.items[indexPath.row] lastObject] new];
}

#pragma mark -Getters and Setters   //设置方法

- (ASTableView *)asTableView {
    if (!_asTableView) {
        _asTableView = [[ASTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain asyncDataFetching:NO];
        _asTableView.backgroundColor = [UIColor flatGreenColorDark];
        _asTableView.asyncDelegate = self;
        _asTableView.asyncDataSource = self;
        
        _asTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _asTableView;
}

- (PaperFoldView *)paperFoldView {
    if (!_paperFoldView) {
        _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetMaxX(self.view.bounds), CGRectGetMaxY(self.view.bounds))];
        _paperFoldView.backgroundColor = [UIColor randomFlatColor];
        _paperFoldView.delegate = self;
        _paperFoldView.enableRightFoldDragging = YES;
        _paperFoldView.enableLeftFoldDragging = YES;
    }
    return _paperFoldView;
}

- (UIView *)mapView {
    if (!_mapView) {
        _mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, CGRectGetMaxY(self.view.bounds))];
        _mapView.backgroundColor = [UIColor randomFlatColor];
    }
    return _mapView;
}

@end

