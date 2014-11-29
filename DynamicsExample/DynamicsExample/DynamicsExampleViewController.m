//
// Copyright 2014 Robert Wijas. All rights reserved.
//

#import "DynamicsExampleViewController.h"
#import "FBTweakInline.h"

static NSString *const ResetNotificationName = @"RWDynamicsExampleViewControllerResetNotificationName";

#define CATEGORY @"Example";

@interface DynamicsExampleViewController ()

@property(nonatomic, strong) UIView *testView;
@property(nonatomic, strong) UIView *collisionView;

@property(nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property(nonatomic, strong) UIGravityBehavior *gravityBehavior;

@property(nonatomic, strong) UICollisionBehavior *collisionBehavior;

@property(nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property(nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;

@property(nonatomic) BOOL gravity;
@property(nonatomic) BOOL collision;

@property(nonatomic) BOOL collisionViewEnabled;

@end

@implementation DynamicsExampleViewController

- (id)init {
    self = [super init];
    if (self) {
        FBTweakBind(self, gravity, CATEGORY, @"Behaviors", @"Gravity", NO);
        FBTweakBind(self, collision, CATEGORY, @"Behaviors", @"Collision", NO);
        FBTweakBind(self, collisionViewEnabled, CATEGORY, @"Behaviors", @"Collision View", NO);
        
        FBTweakAction(CATEGORY, @"Actions", @"Reset", ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:ResetNotificationName
                                                                object:nil];
        });

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reset)
                                                     name:ResetNotificationName
                                                   object:nil];
    }

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    [self reset];
}

- (UIView *)createTestViewWithColor:(UIColor *)color {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    view.userInteractionEnabled = YES;
    view.clipsToBounds = NO;
    view.backgroundColor = [color colorWithAlphaComponent:0.2];
    view.layer.borderWidth = 1;
    view.layer.borderColor = color.CGColor;

    return view;
}

- (void)reset {
    [self.testView removeFromSuperview];

    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.testView = [self createTestViewWithColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.testView];

    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(pan:)];
    [self.testView addGestureRecognizer:panGestureRecognizer];
    
    [self setupBehaviors];
    
    [self updateCollisionView];
}

- (void)setupBehaviors {
    self.gravityBehavior = [[UIGravityBehavior alloc] init];
    [self.gravityBehavior addItem:self.testView];

    [self updateGravityBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.testView]];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.collisionBehavior addItem:self.testView];

    [self updateCollisionBehavior];

    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] init];
    [self.dynamicItemBehavior addItem:self.testView];

    [self.dynamicAnimator addBehavior:self.dynamicItemBehavior];

    FBTweakBind(self.dynamicItemBehavior, elasticity, CATEGORY, @"Dynamic Item Properties", @"Elasticity", 0.1);
    FBTweakBind(self.dynamicItemBehavior, friction, CATEGORY, @"Dynamic Item Properties", @"Friction", 0.4);
    FBTweakBind(self.dynamicItemBehavior, density, CATEGORY, @"Dynamic Item Properties", @"Density", 1.0);
    FBTweakBind(self.dynamicItemBehavior, angularResistance, CATEGORY, @"Dynamic Item Properties", @"Angular Resistance", 1.0);
    FBTweakBind(self.dynamicItemBehavior, allowsRotation, CATEGORY, @"Dynamic Item Properties", @"Allows Rotation", YES);
    FBTweakBind(self.dynamicItemBehavior, resistance, CATEGORY, @"Dynamic Item Properties", @"Resistance", 0.1);
}

- (void)updateGravityBehavior {
    [self updateBehavior:self.gravityBehavior enabled:self.gravity];
}

- (void)updateCollisionBehavior {
    [self updateBehavior:self.collisionBehavior enabled:self.collision];
}

- (void)updateBehavior:(UIDynamicBehavior *)behavior enabled:(BOOL)enabled {
    if (enabled) {
        [self.dynamicAnimator addBehavior:behavior];
    } else {
        [self.dynamicAnimator removeBehavior:behavior];
    }
}

- (void)updateCollisionView {
    [self.collisionView removeFromSuperview];
    [self.collisionBehavior removeItem:self.collisionView];
    
    if (self.collisionViewEnabled) {
        self.collisionView = [self createTestViewWithColor:[UIColor orangeColor]];
        self.collisionView.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
        [self.view addSubview:self.collisionView];
        
        [self.collisionBehavior addItem:self.collisionView];
    } else {
        self.collisionView = nil;
    }
}

- (void)pan:(UIPanGestureRecognizer *)gestureRecognizer {
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGPoint touchPoint = [gestureRecognizer locationOfTouch:0
                                                             inView:self.view];
            
            self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.testView
                                                                attachedToAnchor:touchPoint];
            
            FBTweakBind(self.attachmentBehavior, damping, CATEGORY, @"Attachement", @"Damping", 0.0);
            FBTweakBind(self.attachmentBehavior, frequency, CATEGORY, @"Attachement", @"Frequency", 0.0);
            
            [self.dynamicAnimator addBehavior:self.attachmentBehavior];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint touchPoint = [gestureRecognizer locationOfTouch:0
                                                             inView:self.view];
            self.attachmentBehavior.anchorPoint = touchPoint;
            break;
        }
        default: {
            if (self.attachmentBehavior) {
                [self.dynamicAnimator removeBehavior:self.attachmentBehavior];
                self.attachmentBehavior = nil;
            }
        }
    }
}

- (void)setGravity:(BOOL)gravity {
    _gravity = gravity;
    [self updateGravityBehavior];
}

- (void)setCollision:(BOOL)collision {
    _collision = collision;
    [self updateCollisionBehavior];
    [self updateCollisionView];
}

- (void)setCollisionViewEnabled:(BOOL)collisionViewEnabled {
    _collisionViewEnabled = collisionViewEnabled;
    [self updateCollisionView];
}

@end