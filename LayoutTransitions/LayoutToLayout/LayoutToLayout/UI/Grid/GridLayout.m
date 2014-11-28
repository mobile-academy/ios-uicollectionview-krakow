//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "GridLayout.h"

@implementation GridLayout

#pragma mark - Object life cycle

- (id)init {
    self = [super init];
    if (self) {
        self.numberOfColumns = 4;
        self.rowHeight = 70.0f;
    }
    return self;
}
@end