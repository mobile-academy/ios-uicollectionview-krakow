#import <Foundation/Foundation.h>


@interface RootViewController : UIViewController
@property(nonatomic, readonly) UIViewController *contentViewController;

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController;

@end
