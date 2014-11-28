#import "RootView.h"


@implementation RootView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background@2x.jpg"]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        _backgroundImageView = imageView;
    }

    return self;
}

- (void)setContentView:(UIView *)contentView {
    if (_contentView != contentView) {
        [_contentView removeFromSuperview];
        _contentView = contentView;
        [self addSubview:contentView];
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
    self.contentView.frame = CGRectMake(0, self.topLayoutGuideLength, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - self.topLayoutGuideLength);
}

@end
