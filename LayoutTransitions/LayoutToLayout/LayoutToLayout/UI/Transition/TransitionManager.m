//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  

#import "TransitionManager.h"

@implementation TransitionManager

#pragma mark - Object life cycle

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        self.collectionView = collectionView;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
}

#pragma mark - UIViewControllerInteractiveTransitioning

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
}

@end