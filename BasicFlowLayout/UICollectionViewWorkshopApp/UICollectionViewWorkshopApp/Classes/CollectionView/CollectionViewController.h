#import <Foundation/Foundation.h>

@class CollectionViewDataSource;

@interface CollectionViewController : UIViewController
@property(nonatomic, readonly) CollectionViewDataSource *dataSource;

- (instancetype)initWithDataSource:(CollectionViewDataSource *)dataSource;

@end
