//  
//  Copyright (c) 2014 Aleksander Zubala All rights reserved.
//  


#import <Foundation/Foundation.h>


@interface ColumnVariantLayout : UICollectionViewFlowLayout
@property(nonatomic, assign) NSUInteger numberOfColumns;
@property(nonatomic, assign) CGFloat rowHeight;
@end