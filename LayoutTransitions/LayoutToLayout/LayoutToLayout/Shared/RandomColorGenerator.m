//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import "RandomColorGenerator.h"

@implementation RandomColorGenerator

#pragma mark - Public methods

- (NSArray *)generateNumberOfRandomColors:(NSUInteger)numberOfRandomColors {
    NSMutableArray *randomColors = [NSMutableArray new];
    for (NSInteger i = 0; i < numberOfRandomColors; ++i) {
        UIColor *color = [UIColor colorWithRed:[self randomColorComponent]
                                         green:[self randomColorComponent]
                                          blue:[self randomColorComponent] alpha:1.0f];
        [randomColors addObject:color];
    }
    return randomColors;
}

- (CGFloat)randomColorComponent {
    return arc4random_uniform(256) / 256.0f;
}

@end