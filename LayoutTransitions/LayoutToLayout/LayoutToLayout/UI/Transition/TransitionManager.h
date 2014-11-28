//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import <Foundation/Foundation.h>

@protocol TransitionManagerDelegate;
@class TransitionLayout;

@interface TransitionManager : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, weak) id <TransitionManagerDelegate> delegate;
@property(nonatomic, assign) BOOL startedInteraction;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end

@protocol TransitionManagerDelegate <NSObject>
- (void)managerDidStartInteractiveTransition:(TransitionManager *)transitionManager;
@end