//
// Copyright 2014 Robert Wijas. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SelectionCollectionViewFlowLayout : UICollectionViewFlowLayout

- (void)updateLayoutForIndexPath:(NSIndexPath *)indexPath;

- (void)cleanupBehaviorsForIndexPath:(NSIndexPath *)indexPath;

@end