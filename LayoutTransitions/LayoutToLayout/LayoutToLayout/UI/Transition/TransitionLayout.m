//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "TransitionLayout.h"


@implementation TransitionLayout

#pragma mark - Layout hooks

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in array) {
        [self rotateAccordingToProgress:attributes];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [self rotateAccordingToProgress:attributes];
    return attributes;
}

#pragma mark - Helpers

- (void)rotateAccordingToProgress:(UICollectionViewLayoutAttributes *)attributes {
    attributes.transform = CGAffineTransformMakeRotation((CGFloat) (M_PI * self.transitionProgress));
}


@end