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
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
        [self.collectionView addGestureRecognizer:pinch];
    }
    return self;
}

#pragma mark - Actions

- (void)didPinch:(UIPinchGestureRecognizer *)pinchRecognizer {
    CGFloat progress = pinchRecognizer.scale - 1.0f; //naive way
    switch (pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        case UIGestureRecognizerStateCancelled:
            break;
        default:
            break;
    }
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