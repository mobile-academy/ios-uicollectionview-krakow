//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//

#import "StackViewController.h"
#import "StackLayout.h"
#import "RandomColorGenerator.h"
#import "GridViewController.h"
#import "TransitionManager.h"

NSString *const CellId = @"CellId";

@interface StackViewController () <UINavigationControllerDelegate>
@property(nonatomic, strong) NSArray *colors;
@property(nonatomic, strong) TransitionManager *transitionManager;
@end

@implementation StackViewController

#pragma mark - Object life cycle

- (id)init {
    self = [super initWithCollectionViewLayout:[StackLayout new]];
    if (self) {
        self.title = @"Stack";
        self.colors = [[RandomColorGenerator new] generateNumberOfRandomColors:20];
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellId];
    self.transitionManager = [[TransitionManager alloc] initWithCollectionView:self.collectionView];
    self.transitionManager.delegate = self;
    self.navigationController.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.colors count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    cell.backgroundColor = self.colors[(NSUInteger) indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self presentGridController];
}

- (void)presentGridController {
    GridViewController *gridViewController = [GridViewController new];
    gridViewController.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:gridViewController animated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    return self.transitionManager.startedInteraction ? self.transitionManager : nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
    return animationController == self.transitionManager ? self.transitionManager : nil;
}

#pragma mark - TransitionManagerDelegate

- (void)managerDidStartInteractiveTransition:(TransitionManager *)transitionManager {
    [self presentGridController];
}

@end