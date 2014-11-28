sib//
//  Created by Pawel Dudek on 02/07/14.
//  Copyright (c) 2014 Dudek. All rights reserved.
//


#import <MTDates/NSDate+MTDates.h>
#import "CalendarCollectionViewLayout.h"
#import "BeadView.h"
#import "SeparatorView.h"


@interface CalendarCollectionViewLayout ()
@property(nonatomic, readwrite) NSDate *startOfDisplayedDay;
@property(nonatomic, readwrite) NSDate *endOfDisplayedDay;

@property(nonatomic, strong) NSArray *cachedSeparatorsAttributes;
@property(nonatomic, strong) NSArray *cachedCellAttributes;

@property(nonatomic, readwrite) NSDate *beadViewDate;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

NSString *const CalendarCollectionViewLayoutDecorationKindBead = @"CalendarCollectionViewLayoutDecorationKindBead";
NSString *const CalendarCollectionViewLayoutDecorationKindSeparator = @"CalendarCollectionViewLayoutDecorationKindSeparator";

@implementation CalendarCollectionViewLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [self.dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    }

    return self;
}

#pragma mark - UICollectionView Layout

- (void)prepareLayout {
    [super prepareLayout];

    //TODO  Assignment 2: Register bead view class
    //TODO  Assignment 3: Register separator view class

    id <CalendarCollectionViewLayoutDelegate> delegate = (id <CalendarCollectionViewLayoutDelegate>) self.collectionView.delegate;

    if ([delegate respondsToSelector:@selector(startOfDisplayedDateForCalendarCollectionViewLayout:)]) {
        self.startOfDisplayedDay = [delegate startOfDisplayedDateForCalendarCollectionViewLayout:self];
    }
    else {
        NSAssert(NO, @"%@ has to implement base calendar layout mehtods!", delegate);
    }

    if ([delegate respondsToSelector:@selector(endOfDisplayedDateForCalendarCollectionViewLayout:)]) {
        self.endOfDisplayedDay = [delegate endOfDisplayedDateForCalendarCollectionViewLayout:self];
    }
    else {
        NSAssert(NO, @"%@ has to implement base calendar layout mehtods!", delegate);
    }

    NSArray *events = @[];
    //TODO Assignment 2: grab events using extended delegate pattern

    if ([delegate respondsToSelector:@selector(beadViewDateForCalendarCollectionViewLayout:)]) {
        self.beadViewDate = [delegate beadViewDateForCalendarCollectionViewLayout:self];
    }
    else {
        NSAssert(NO, @"%@ has to implement base calendar layout mehtods!", delegate);
    }

    [self calculateCellLayoutAttributesForEvents:events];
    [self calculateSeparatorsLayoutAttributes];
}

#pragma mark - Layout Preparation Helpers

- (void)calculateCellLayoutAttributesForEvents:(NSArray *)events {
    NSMutableArray *cellAttributes = [NSMutableArray array];

    for (NSUInteger index = 0; index < [self.collectionView numberOfItemsInSection:0]; ++index) {
        //TODO Assignment 2: Calculate position and size of layout attributes for cell for given event, based on its start and end date
    }

    self.cachedCellAttributes = [cellAttributes copy];
}

- (void)calculateSeparatorsLayoutAttributes {
    NSMutableArray *separatorAttributes = [NSMutableArray array];

    NSInteger numberOfFullHours = [self.startOfDisplayedDay mt_hoursUntilDate:self.endOfDisplayedDay] + 1;
    // TODO Assignment 3: Calculate separator layout attributes based on number of full hours (include half hour separators as well!)

    self.cachedSeparatorsAttributes = [separatorAttributes copy];
}

#pragma mark - Content Size

- (CGSize)collectionViewContentSize {
    CGSize collectionViewContentSize = [super collectionViewContentSize];
    NSInteger minutes = [self.startOfDisplayedDay mt_minutesUntilDate:self.endOfDisplayedDay];
    collectionViewContentSize.height = minutes;
    return collectionViewContentSize;
}

#pragma mark - Elements in rect

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray array];

    //TODO Assignment 2: Add bead view attributes

    [attributes addObjectsFromArray:self.cachedCellAttributes];
    [attributes addObjectsFromArray:self.cachedSeparatorsAttributes];

    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cachedCellAttributes[(NSUInteger) indexPath.row];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
    if ([decorationViewKind isEqualToString:CalendarCollectionViewLayoutDecorationKindBead]) {
        return [self beadViewLayoutAttributes];
    }

    return self.cachedSeparatorsAttributes[(NSUInteger) indexPath.row];
}

- (UICollectionViewLayoutAttributes *)beadViewLayoutAttributes {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    Class layoutAttributesClass = [[self class] layoutAttributesClass];
    UICollectionViewLayoutAttributes *attributes = [layoutAttributesClass layoutAttributesForDecorationViewOfKind:CalendarCollectionViewLayoutDecorationKindBead
                                                                                                    withIndexPath:indexPath];

    CGRect timeIndicatorFrame = CGRectZero;

    //TODO Assignment 2: Calculate appropriate frame for the bead view

    attributes.frame = timeIndicatorFrame;
    attributes.zIndex = 1;

    return attributes;
}

@end
