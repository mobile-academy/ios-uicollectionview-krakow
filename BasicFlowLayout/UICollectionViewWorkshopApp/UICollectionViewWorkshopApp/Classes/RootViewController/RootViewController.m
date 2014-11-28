#import "RootViewController.h"
#import "RootView.h"


@implementation RootViewController

- (instancetype)initWithContentViewController:(UIViewController *)contentViewController {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"UICollectinoView Workshops";
        _contentViewController = contentViewController;
    }

    return self;
}

- (void)loadView {
    self.view = [RootView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.contentViewController) {
        [self addChildViewController:self.contentViewController];
        [(RootView *)self.view setContentView:self.contentViewController.view];
        [self.contentViewController didMoveToParentViewController:self];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [(RootView *)self.view setTopLayoutGuideLength:self.topLayoutGuide.length];       
}

@end
