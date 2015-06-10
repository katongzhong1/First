//
//  ASTableViewTestViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASTableViewTestViewController.h"

#import <AsyncDisplayKit/ASTableView.h>

#import "KittenNode.h"
#import "CardInfoModel.h"
#import "CardInfoCellNode.h"

@interface ASTableViewTestViewController ()<ASTableViewDelegate, ASTableViewDataSource>

///ASTableView
@property (nonatomic, strong)  ASTableView *asTableView;
///CardInfo
@property (nonatomic, strong) NSArray *cardInfoArr;

@property (nonatomic, strong) NSOperationQueue *nodeContsructionQueue;


@end

@implementation ASTableViewTestViewController



#pragma mark -Life cycle            //生命周期
- (void)loadView {
    [super loadView];
    
    self.cardInfoArr = [[[CardInfo alloc] init] getCardInfo];
    self.nodeContsructionQueue = [[NSOperationQueue alloc] init];
    NSLog(@"%@", self.cardInfoArr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addView];
    [self addLayout];
}

- (void)addView {
    self.view.backgroundColor = HexColor(@"24b8c5");
    
    [self.view addSubview:self.asTableView];
}

- (void)addLayout {
    
}

#pragma mark -Delegate              //所有代理方法  顺序

#pragma mark  ASTableView Delegate

- (ASCellNode *)tableView:(UITableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardInfoCellNode *kittenNode = [[CardInfoCellNode alloc] init];
    NSLog(@"%f  %f", kittenNode.calculatedSize.width, kittenNode.calculatedSize.height);

    [kittenNode configureCellDisplayWithCardInfo:self.cardInfoArr[indexPath.row] nodeConstructionQueue:nil];

    
    return kittenNode;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cardInfoArr.count;
}

#pragma mark -Event response        //事件回应


#pragma mark -Private methods       //私有方法


#pragma mark -Getters and Setters   //设置方法

- (ASTableView *)asTableView {
    if (!_asTableView) {
        _asTableView = [[ASTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _asTableView.asyncDelegate = self;
        _asTableView.asyncDataSource  = self;
        ASRangeTuningParameters pararmeters;
        pararmeters.leadingBufferScreenfuls = 13;
        pararmeters.trailingBufferScreenfuls = 13;
        //_asTableView.rangeTuningParameters = pararmeters;
        _asTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _asTableView;
}


@end
