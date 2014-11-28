//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "LeftLayout.h"


@implementation LeftLayout

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.numberOfColumns = 1;
        self.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 200.0f);
    }
    return self;
}

#pragma mark - Layout hooks

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
    //TODO shift initial attributes so they are out of the screen on the left hand side
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    //TODO shift final attributes so they are out of the screen on the left hand side
    return attributes;
}


@end