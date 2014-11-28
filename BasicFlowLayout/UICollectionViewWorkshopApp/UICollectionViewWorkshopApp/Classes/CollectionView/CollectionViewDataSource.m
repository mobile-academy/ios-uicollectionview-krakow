#import "CollectionViewDataSource.h"
#import "CollectionViewCell.h"


@implementation CollectionViewDataSource

- (id)init {
    self = [super init];
    if (self) {
        [self setupItems];

        _collectionViewLayout = [UICollectionViewFlowLayout new];
        _collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }

    return self;
}

- (void)setupItems {
    NSMutableArray *items = [NSMutableArray array];
    for (NSUInteger i = 0; i < 3; ++i) {
        NSMutableArray *section = [NSMutableArray array];
        for (NSUInteger j = 0; j < 10; ++j) {
            [section addObject:@{
                    @"color" : [UIColor colorWithRed:((i + 1) * j) / 30.0f
                                               green:(2 * i * j * j) / 300.0f
                                                blue:(2 * i * i * j) / 90.0f
                                               alpha:0.9]
            }];
        }
        [items addObject:section];
    }
    _items = items;
}

- (void)registerClassesForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[CollectionViewCell class]
       forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 200);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.items.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *sectionArray = self.items[(NSUInteger) section];
    return sectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])
                                                                         forIndexPath:indexPath];
    NSDictionary *item = self.items[(NSUInteger) indexPath.section][(NSUInteger) indexPath.item];
    cell.backgroundColor = item[@"color"];
    cell.textLabel.text = [NSString stringWithFormat:@"[%@, %@]", @(indexPath.section), @(indexPath.item)];
    return cell;
}
@end
