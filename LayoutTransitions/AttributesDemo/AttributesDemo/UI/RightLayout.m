//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "RightLayout.h"

@implementation RightLayout

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.numberOfColumns = 1;
        self.sectionInset = UIEdgeInsetsMake(10.f, 200.f, 10.f, 10.0f);
    }
    return self;
}

#pragma mark - Layout hooks

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    [self shiftAttributesOutOfScreen:attributes];
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    [self shiftAttributesOutOfScreen:attributes];
    return attributes;
}

- (void)shiftAttributesOutOfScreen:(UICollectionViewLayoutAttributes *)attributes {
    CGPoint center = attributes.center;
    center.x = CGRectGetWidth(self.collectionView.bounds) + self.itemSize.width/2;
    attributes.center = center;
}


@end