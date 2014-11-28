#import <Kiwi/Kiwi.h>

#import "CollectionViewController.h"
#import "CollectionViewDataSource.h"

SPEC_BEGIN(CollectionViewControllerSpec)

describe(@"CollectionViewController", ^{
    __block CollectionViewController *controller;
    __block CollectionViewDataSource *dataSource;

    beforeEach(^{
        dataSource = [CollectionViewDataSource new];
        controller = [[CollectionViewController alloc] initWithDataSource:dataSource];
    });

    afterEach(^{
        dataSource = nil;
        controller = nil;
    });

    describe(@"initialization", ^{
        it(@"should have data source set", ^{
            [[controller.dataSource should] equal:dataSource];
        });
    });

    describe(@"collection view configuration", ^{
        __block UICollectionView *collectionView;

        beforeEach(^{
            collectionView = (UICollectionView *) controller.view;
        });

        it(@"should assign collection view delegate", ^{
            [[(NSObject *)collectionView.delegate should] equal:dataSource];
        });

        it(@"should assign collection view data source", ^{
            [[(NSObject *) collectionView.dataSource should] equal:dataSource];
        });
    });
});

SPEC_END
