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
    //TODO shift initial attributes so they are out of the screen on the right hand side
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
    UICollectionViewLayoutAttributes *attributes = [super finalLayoutAttributesForDisappearingItemAtIndexPath:itemIndexPath];
    //TODO shift initial attributes so they are out of the screen on the right hand side
    return attributes;
}

@end