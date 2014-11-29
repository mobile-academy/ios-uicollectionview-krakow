#import <Kiwi/Kiwi.h>

#import "CollectionViewDataSource.h"
#import "CollectionViewCell.h"

SPEC_BEGIN(CollectionViewDataSourceSpec)

describe(@"CollectionViewDataSource", ^{
    __block CollectionViewDataSource *dataSource;

    beforeEach(^{
        dataSource = [CollectionViewDataSource new];
    });

    afterEach(^{
        dataSource = nil;
    });

    describe(@"initialization", ^{
        it(@"should have flow layout set", ^{
            [[dataSource.collectionViewLayout should] beKindOfClass:[UICollectionViewFlowLayout class]];
        });
    });

    describe(@"items", ^{
        __block NSArray *items;

        beforeEach(^{
            items = dataSource.items;
        });

        it(@"should have 3 sections", ^{
            [[[items should] have:3] elements];
        });

        it(@"should have 10 elements per section", ^{
            BOOL correctAmount = YES;
            for (NSArray *section in items) {
                correctAmount = correctAmount && section.count == 10;
            }
            [[theValue(correctAmount) should] beYes];
        });
    });
    
    describe(@"delegation and data sourcing", ^{
        __block NSArray *items;

        beforeEach(^{
            items = dataSource.items;
        });
        
        it(@"should return proper cell size", ^{
            CGSize size = [dataSource collectionView:nil
                                              layout:nil
                              sizeForItemAtIndexPath:nil];
            [[theValue(CGSizeEqualToSize(size, CGSizeMake(100, 200))) should] beYes];
        });
        
        it(@"should return proper number of sections", ^{
            NSInteger numberOfSectionsInCollectionView = [dataSource numberOfSectionsInCollectionView:nil];
            [[theValue(numberOfSectionsInCollectionView) should] equal:theValue(items.count)];
        });

        context(@"configuring cell", ^{
            __block UICollectionView *collectionView;
            __block CollectionViewCell *collectionViewCell;

            beforeEach(^{
                collectionViewCell = [CollectionViewCell new];
                collectionView = [UICollectionView nullMock];
                [collectionView stub:@selector(dequeueReusableCellWithReuseIdentifier:forIndexPath:) andReturn:collectionViewCell];
            });

            it(@"should set cell's background color", ^{
                UICollectionViewCell *cell = [dataSource collectionView:collectionView
                                                 cellForItemAtIndexPath:nil];
                [[cell.backgroundColor shouldNot] beNil];
            });

            it(@"should set proper's cell title", ^{
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:1];
                CollectionViewCell *cell = (CollectionViewCell *) [dataSource collectionView:collectionView
                                                                      cellForItemAtIndexPath:indexPath];
                NSString *text = [NSString stringWithFormat:@"[%@, %@]", @(indexPath.section), @(indexPath.item)];
                [[cell.textLabel.text should] equal:text];
            });
        });
    });
});

SPEC_END
