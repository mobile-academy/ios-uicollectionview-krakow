//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "CollectionViewController.h"
#import "LeftLayout.h"
#import "RightLayout.h"
#import "RandomColorGenerator.h"

NSString *const CellId = @"CellId";

@interface CollectionViewController ()
@property(nonatomic, assign) BOOL layoutToggle;
@property(nonatomic, strong) NSArray *colors;
@end

@implementation CollectionViewController

#pragma mark - Object life cycle

- (id)init {
    self = [super initWithCollectionViewLayout:[LeftLayout new]];
    if (self) {
        self.colors = [[RandomColorGenerator new] generateNumberOfRandomColors:100];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Switch"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(changeLayoutPressed:)];
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

#pragma mark - Layout change

- (void)changeLayoutPressed:(UIBarButtonItem *)sender {
    [self.collectionView setCollectionViewLayout:[self currentLayout] animated:YES completion:^(BOOL finished) {
    }];
}

- (UICollectionViewLayout *)currentLayout {
    self.layoutToggle = !self.layoutToggle;
    return self.layoutToggle ? [RightLayout new] : [LeftLayout new];
}

@end