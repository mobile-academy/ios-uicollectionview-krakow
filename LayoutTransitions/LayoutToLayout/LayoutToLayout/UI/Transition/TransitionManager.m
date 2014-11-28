//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  

#import "TransitionManager.h"

@interface TransitionManager ()
@property(nonatomic, strong) id <UIViewControllerContextTransitioning> transitionContext;
@end


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
            self.startedInteraction = YES;
            [self.delegate managerDidStartInteractiveTransition:self];
            break;
        case UIGestureRecognizerStateChanged:
            [self.transitionContext updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateEnded:
            [self finishedTransitionWithSuccess:progress > 0.5f];
            break;
        case UIGestureRecognizerStateCancelled:
            [self finishedTransitionWithSuccess:NO];
            break;
        default:
            break;
    }
}

- (void)finishedTransitionWithSuccess:(BOOL)ended {
    if (ended) {
        [self.transitionContext finishInteractiveTransition];
        [self.collectionView finishInteractiveTransition];
    } else {
        [self.transitionContext cancelInteractiveTransition];
        [self.collectionView cancelInteractiveTransition];
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
    self.transitionContext = transitionContext;
}

@end