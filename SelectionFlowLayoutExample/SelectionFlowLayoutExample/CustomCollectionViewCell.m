//
// Copyright 2014 Robert Wijas. All rights reserved.
//

#import "CustomCollectionViewCell.h"


@interface CustomCollectionViewCell ()
@property(nonatomic, readwrite, strong) UILabel *label;
@end

@implementation CustomCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont boldSystemFontOfSize:23];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;

        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.label];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.label.frame = self.contentView.bounds;
}

@end