#import <Foundation/Foundation.h>


@interface RootView : UIView
@property(nonatomic, readonly) UIImageView *backgroundImageView;
@property(nonatomic, weak) UIView *contentView;
@property(nonatomic) CGFloat topLayoutGuideLength;
@end
