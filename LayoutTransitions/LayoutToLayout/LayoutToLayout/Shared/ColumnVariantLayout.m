//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "ColumnVariantLayout.h"


@implementation ColumnVariantLayout

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.rowHeight = 100.0f;
        self.numberOfColumns = 1;
        self.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        self.minimumLineSpacing = 10.f;
        self.minimumInteritemSpacing = 10.0f;
    }
    return self;
}

#pragma mark - Layout hooks

- (void)prepareLayout {
    self.itemSize = [self calculateItemSize];
    [super prepareLayout];
}

- (CGSize)calculateItemSize {
    if (self.numberOfColumns == 0) return CGSizeZero;
    CGRect availableRect = UIEdgeInsetsInsetRect(self.collectionView.bounds, self.sectionInset);
    CGFloat widthForItems = CGRectGetWidth(availableRect) - (self.numberOfColumns - 1) * self.minimumInteritemSpacing;
    CGFloat itemWidth = floorf(widthForItems / self.numberOfColumns);
    return CGSizeMake(itemWidth, self.rowHeight);
}

@end