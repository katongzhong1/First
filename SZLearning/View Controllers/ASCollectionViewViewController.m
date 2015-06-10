//
//  ASCollectionViewViewController.m
//  SZLearning
//
//  Created by Apple on 15/5/18.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "ASCollectionViewViewController.h"

#import "CardInfoModel.h"
#import "CardInfoCellNode.h"

#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ASCollectionViewViewController ()<ASCollectionViewDelegate, ASCollectionViewDataSource>

///CardInfo
@property (nonatomic, strong) NSArray *cardInfoArray;
///CollectionView
@property (nonatomic, strong) ASCollectionView *collectionView;
@property (nonatomic, strong) NSOperationQueue *nodeContsructionQueue;

@end

@implementation ASCollectionViewViewController


- (instancetype)init {
    if ((!(self = [super init]))) {
        return nil;
    }
     self.cardInfoArray = [[[CardInfo alloc] init] getCardInfo];
    self.nodeContsructionQueue = [[NSOperationQueue alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(320, 120);
    layout.sectionInset = UIEdgeInsetsMake(20, 8, 8, 8);
    
    _collectionView = [[ASCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.asyncDataSource = self;
    _collectionView.asyncDelegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    return self;
}

#pragma mark -Life cycle            //生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_collectionView];
}

- (void)viewWillLayoutSubviews
{
    _collectionView.frame = self.view.bounds;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



#pragma mark -Delegate              //所有代理方法  顺序

#pragma mark ASCollectionView data source.

- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [NSString stringWithFormat:@"[%zd.%zd] says hi dsafsdfsafsdafdsafdsafdsa3243214321432", indexPath.section, indexPath.item];
    ASTextCellNode *node = [[ASTextCellNode alloc] init];
    node.text = text;
    node.backgroundColor = [UIColor lightGrayColor];
    
    CardInfoCellNode *kittenNode = [[CardInfoCellNode alloc] init];
//    [kittenNode configureCellDisplayWithCardInfo:self.cardInfoArray[indexPath.row] nodeConstructionQueue:self.nodeContsructionQueue];
    
    return kittenNode;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (void)collectionViewLockDataSource:(ASCollectionView *)collectionView
{
    // lock the data source
    // The data source should not be change until it is unlocked.
}

- (void)collectionViewUnlockDataSource:(ASCollectionView *)collectionView
{
    // unlock the data source to enable data source updating.
}

#pragma mark -Event response        //事件回应


#pragma mark -Private methods       //私有方法


#pragma mark -Getters and Setters   //设置方法




@end
