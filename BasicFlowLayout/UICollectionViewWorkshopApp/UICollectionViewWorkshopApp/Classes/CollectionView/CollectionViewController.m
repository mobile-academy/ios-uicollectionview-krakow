#import "CollectionViewController.h"
#import "CollectionViewDataSource.h"


@implementation CollectionViewController

- (instancetype)initWithDataSource:(CollectionViewDataSource *)dataSource {
    self = [super init];
    if (self) {
        _dataSource = dataSource;
    }

    return self;
}

- (void)loadView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                          collectionViewLayout:self.dataSource.collectionViewLayout];
    collectionView.delegate = self.dataSource;
    collectionView.dataSource = self.dataSource;
    collectionView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.2];
    self.view = collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSource registerClassesForCollectionView:(UICollectionView *) self.view];
}

@end
