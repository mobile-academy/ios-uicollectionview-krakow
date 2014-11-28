//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import <Foundation/Foundation.h>

@protocol TransitionManagerDelegate;

@interface TransitionManager : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>
@property(nonatomic, assign) BOOL startedInteraction;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, weak) id <TransitionManagerDelegate> delegate;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end

@protocol TransitionManagerDelegate <NSObject>
- (void)managerDidStartInteractiveTransition:(TransitionManager *)transitionManager;
@end
