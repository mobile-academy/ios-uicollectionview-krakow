//
//  Copyright (c) 2014 dudek. All rights reserved.
//


#import "CarouselCollectionViewLayout.h"

@interface CarouselCollectionViewLayout ()
@property(nonatomic) CGFloat rightLeftMargin;
@property(nonatomic) CGFloat topBottomMargin;
@property(nonatomic, readwrite) NSIndexPath *indexPathForCenteredItem;
@end

@implementation CarouselCollectionViewLayout

#pragma mark - Preparing Layout

- (void)prepareLayout {
    [super prepareLayout];

    CGSize collectionViewSize = self.collectionView.bounds.size;
    self.rightLeftMargin = (collectionViewSize.width - self.itemSize.width) / 2;
    self.topBottomMargin = (collectionViewSize.height - self.itemSize.height) / 2;
}

- (CGSize)collectionViewContentSize {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];

    CGFloat contentWidth = numberOfItems * self.itemSize.width + (numberOfItems - 1) * self.interItemSpace + 2 * self.rightLeftMargin;
    CGFloat contentHeight = self.itemSize.height + 2 * self.topBottomMargin;

    return CGSizeMake(contentWidth, contentHeight);
}

#pragma mark - Attributes

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    CGFloat combinedItemWidth = self.itemSize.width + self.interItemSpace;

    CGFloat minimalXPosition = CGRectGetMinX(rect) - self.rightLeftMargin;
    CGFloat maximalXPosition = CGRectGetMaxX(rect) - self.rightLeftMargin;

    CGFloat firstVisibleItem = floorf(minimalXPosition / combinedItemWidth);
    CGFloat lastVisibleItem = ceilf(maximalXPosition / combinedItemWidth);

    if (firstVisibleItem < 0) {
        firstVisibleItem = 0;
    }

    if (lastVisibleItem > [[self collectionView] numberOfItemsInSection:0]) {
        lastVisibleItem = [[self collectionView] numberOfItemsInSection:0];
    }

    return @[];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [[[self class] layoutAttributesClass] layoutAttributesForCellWithIndexPath:indexPath];
    return attributes;
}

#pragma mark - Target Content Offset

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint targetContentOffset = proposedContentOffset;
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = [self layoutAttributesForUserFingerMovingWithVelocity:velocity
                                                                                                          proposedContentOffset:proposedContentOffset];

    if (layoutAttributesForItemToCenterOn) {
        targetContentOffset.x = layoutAttributesForItemToCenterOn.center.x - self.collectionView.bounds.size.width / 2;
        targetContentOffset.y = 0;
        self.indexPathForCenteredItem = layoutAttributesForItemToCenterOn.indexPath;
    }

    return targetContentOffset;
}

#pragma mark - Helpers

- (UICollectionViewLayoutAttributes *)layoutAttributesForUserFingerMovingWithVelocity:(CGPoint)velocity proposedContentOffset:(CGPoint)offset {
    UICollectionViewLayoutAttributes *layoutAttributesForItemToCenterOn = nil;
    CGRect nextVisibleBounds = [self collectionView].bounds;
    nextVisibleBounds.origin = offset;

    return layoutAttributesForItemToCenterOn;
}

#pragma mark - Invalidating Layout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);
}

#pragma mark - Overriden Setters

- (void)setItemSize:(CGSize)itemSize {
    if (!CGSizeEqualToSize(_itemSize, itemSize)) {
        _itemSize = itemSize;
        [self invalidateLayout];
    }
}

@end
