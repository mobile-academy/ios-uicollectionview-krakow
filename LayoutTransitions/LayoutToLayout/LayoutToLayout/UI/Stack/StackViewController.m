//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//

#import "StackViewController.h"
#import "StackLayout.h"
#import "RandomColorGenerator.h"
#import "GridViewController.h"

NSString *const CellId = @"CellId";

@interface StackViewController () <UINavigationControllerDelegate>
@property(nonatomic, strong) NSArray *colors;
@end

@implementation StackViewController

#pragma mark - Object life cycle

- (id)init {
    self = [super initWithCollectionViewLayout:[StackLayout new]];
    if (self) {
        self.title = @"Stack";
        self.colors = [[RandomColorGenerator new] generateNumberOfRandomColors:20];
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellId];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.colors count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.backgroundColor = self.colors[(NSUInteger) indexPath.item];
    return cell;
}

@end