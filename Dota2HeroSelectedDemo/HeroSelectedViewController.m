//
//  HeroSelectedViewController.m
//  Dota2HeroSelectedDemo
//
//  Created by cuctv-duan on 16/10/26.
//  Copyright © 2016年 cuctv-duan. All rights reserved.
//

#import "HeroSelectedViewController.h"
#import <YYModel/YYModel.h>
#import "HeroInfoModel.h"
#import "CYLineLayout.h"

@interface HeroSelectedViewController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation HeroSelectedViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CYLineLayout *layout = [[CYLineLayout alloc]init];
        
        self = [self initWithCollectionViewLayout:layout];
        self.collectionView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.35);
        layout.itemSize = CGSizeMake(self.collectionView.frame.size.height * 0.86, self.collectionView.frame.size.height);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.collectionView.backgroundColor = [UIColor purpleColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%lu",(unsigned long)self.dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    HeroInfoModel *model = self.dataArray[indexPath.row];

    cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_vert",model.img]]];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark - 懒加载

- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataPath];
        NSArray *heroDataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _dataArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in heroDataArray) {
            HeroInfoModel *model = [HeroInfoModel yy_modelWithDictionary:dict];
            [_dataArray addObject:model];
        }
        [self.collectionView reloadData];
    }

    return _dataArray;
}

@end
