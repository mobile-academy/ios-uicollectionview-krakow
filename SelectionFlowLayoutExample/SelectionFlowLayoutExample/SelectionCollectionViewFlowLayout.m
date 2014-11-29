//
// Copyright 2014 Robert Wijas. All rights reserved.
//

#import "SelectionCollectionViewFlowLayout.h"


@interface SelectionCollectionViewFlowLayout ()

@property(nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property(nonatomic, strong) NSMutableDictionary *snapBehaviors;

@property(nonatomic, strong) NSMutableArray *selectedIndexPaths;

@end

@implementation SelectionCollectionViewFlowLayout

- (id)init {
    self = [super init];

    if (self) {
        self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 200);
        self.itemSize = CGSizeMake(100, 100);

        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

        self.snapBehaviors = [NSMutableDictionary dictionary];
        self.selectedIndexPaths = [NSMutableArray array];
    }

    return self;
}

- (void)prepareLayout {
    [super prepareLayout];

    NSLog(@"%s", sel_getName(_cmd));
}

- (void)recalculateBehaviorsForSelectedIndexPaths {
    [self.selectedIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *currentAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self removeBehaviorForIndexPath:indexPath];

        NSUInteger index = [self.selectedIndexPaths indexOfObject:indexPath];

        CGPoint snapPoint = CGPointZero;
        snapPoint.x = self.collectionView.bounds.size.width - self.sectionInset.left - self.itemSize.width * 0.5f;
        snapPoint.y = self.sectionInset.top + self.itemSize.height * 0.5f + (self.minimumLineSpacing + self.itemSize.height) * index;

        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:currentAttributes
                                                                snapToPoint:snapPoint];

        [self.snapBehaviors setObject:snapBehavior forKey:indexPath];
        [self.dynamicAnimator addBehavior:snapBehavior];

    }];
}

- (void)updateLayoutForIndexPath:(NSIndexPath *)indexPath {
    BOOL selected = [self.collectionView.indexPathsForSelectedItems containsObject:indexPath];

    UICollectionViewLayoutAttributes *currentAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *flowLayoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    if (selected) {
        [self.selectedIndexPaths addObject:indexPath];
        [self recalculateBehaviorsForSelectedIndexPaths];
    } else {
        [self removeBehaviorForIndexPath:indexPath];
        [self.selectedIndexPaths removeObject:indexPath];

        [self recalculateBehaviorsForSelectedIndexPaths];

        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:currentAttributes
                                                                snapToPoint:flowLayoutAttributes.center];
        [self.snapBehaviors setObject:snapBehavior forKey:indexPath];
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
}

- (void)cleanupBehaviorsForIndexPath:(NSIndexPath *)indexPath {
    if (![self.collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
        [self removeBehaviorForIndexPath:indexPath];
    }
}

- (void)removeBehaviorForIndexPath:(NSIndexPath *)indexPath {
    UISnapBehavior *snapBehavior = [self.snapBehaviors objectForKey:indexPath];
    if (snapBehavior) {
        [self.dynamicAnimator removeBehavior:snapBehavior];
        [self.snapBehaviors removeObjectForKey:indexPath];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *flowLayoutAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *result = [NSMutableArray array];

    NSArray *dynamicIndexPaths = self.snapBehaviors.allKeys;
    for (UICollectionViewLayoutAttributes *attributes in flowLayoutAttributes) {
        if (![dynamicIndexPaths containsObject:attributes.indexPath]) {
            [result addObject:attributes];
        }
    }

    [result addObjectsFromArray:[self.dynamicAnimator itemsInRect:rect]];

    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.snapBehaviors.allKeys containsObject:indexPath]) {
        return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    } else {
        return [super layoutAttributesForItemAtIndexPath:indexPath];
    }
}

- (CGSize)collectionViewContentSize {
    CGSize contentSize = [super collectionViewContentSize];

    NSIndexPath *lastSelectedIndexPath = self.selectedIndexPaths.lastObject;
    if (lastSelectedIndexPath) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:lastSelectedIndexPath];

        CGFloat maxY = attributes.center.y + attributes.bounds.size.height * 0.5f + self.sectionInset.bottom;
        contentSize.height = MAX(contentSize.height, maxY);
    }

    return contentSize;
}

@end