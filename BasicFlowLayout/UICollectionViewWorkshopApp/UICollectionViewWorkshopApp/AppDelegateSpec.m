#import <Kiwi/Kiwi.h>

#import "AppDelegate.h"
#import "RootViewController.h"

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *appDelegate;

    beforeEach(^{
        appDelegate = [AppDelegate new];
    });

    afterEach(^{
        appDelegate = nil;
    });

    describe(@"initialization", ^{
        beforeEach(^{
            [appDelegate application:nil didFinishLaunchingWithOptions:nil];
        });

        it(@"should have navigation controller as root", ^{
            [[appDelegate.window.rootViewController should] beKindOfClass:[UINavigationController class]];
        });

        it(@"should have root view controller as top", ^{
            UINavigationController *navigationController = (id) appDelegate.window.rootViewController;
            [[navigationController.topViewController should] beKindOfClass:[RootViewController class]];
        });
    });
});

SPEC_END
