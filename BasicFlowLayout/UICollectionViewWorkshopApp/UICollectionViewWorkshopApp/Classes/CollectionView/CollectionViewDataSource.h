#import <Foundation/Foundation.h>


@interface CollectionViewDataSource : NSObject <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property(nonatomic, readonly) NSArray *items;
@property(nonatomic, readonly) UICollectionViewFlowLayout *collectionViewLayout;

- (void)registerClassesForCollectionView:(UICollectionView *)collectionView;
@end
