//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "StackLayout.h"

@interface StackLayout ()
@property(nonatomic, strong) NSMutableArray *layoutAttributes;
@property(nonatomic, assign) CGSize itemSize;
@end

@implementation StackLayout

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(200.f, 200.f);

    }
    return self;
}

#pragma mark - Layout hooks

- (void)prepareLayout {
    self.layoutAttributes = [NSMutableArray new];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    CGPoint center = self.collectionView.center;
    for (NSInteger i = 0; i < numberOfItems; ++i) {
        UICollectionViewLayoutAttributes *attributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.size = self.itemSize;
        attributes.center = center;
        [self.layoutAttributes addObject:attributes];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layoutAttributes[(NSUInteger) indexPath.item];
}

- (void)invalidateLayout {
    [super invalidateLayout];
    self.layoutAttributes = nil;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

@end