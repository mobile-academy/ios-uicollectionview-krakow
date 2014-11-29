//
// Copyright 2014 Robert Wijas. All rights reserved.
//

#import "SelectionCollectionViewFlowLayout.h"


@interface SelectionCollectionViewFlowLayout ()

@end

@implementation SelectionCollectionViewFlowLayout

- (id)init {
    self = [super init];

    if (self) {
        self.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        self.itemSize = CGSizeMake(100, 100);
    }

    return self;
}

@end