#import <Kiwi/Kiwi.h>

#import "RootViewController.h"
#import "RootView.h"

SPEC_BEGIN(RootViewControllerSpec)

describe(@"RootViewController", ^{
    __block RootViewController *controller;
    __block UIViewController *contentViewController;
    
    beforeEach(^{
        contentViewController = [UIViewController new];
        controller = [[RootViewController alloc] initWithContentViewController:contentViewController];
    });
    
    afterEach(^{
        controller = nil;
    });
    
    describe(@"initialization", ^{
        it(@"should have proper title", ^{
            [[controller.title should] equal:@"UICollectinoView Workshops"];
        });

        it(@"should have content view controller set", ^{
            [[controller.contentViewController should] equal:contentViewController];
        });

        it(@"should have root view loaded", ^{
            [[controller.view should] beKindOfClass:[RootView class]];
        });

        it(@"should have proper background", ^{
            RootView *view = (RootView *) controller.view;
            [[view.backgroundImageView.image should] equal:[UIImage imageNamed:@"background@2x.jpg"]];
        });
    });

    describe(@"content view setting", ^{
        beforeEach(^{
            [controller loadView];
            [controller viewDidLoad];
        });

        it(@"should have content view controller added as child", ^{
            [[controller.childViewControllers should] contain:contentViewController];
        });

        it(@"should have content view added", ^{
            [[controller.view.subviews should] contain:contentViewController.view];
        });
    });
});

SPEC_END
