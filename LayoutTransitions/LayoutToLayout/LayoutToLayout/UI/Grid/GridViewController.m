//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "GridViewController.h"
#import "GridLayout.h"

@implementation GridViewController

#pragma mark - Object life cycle

- (id)init {
    self = [super initWithCollectionViewLayout:[GridLayout new]];
    if (self) {
        self.title = @"Grid";
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


@end