//
//  ChoiseView.h
//  CreditWise
//
//  Created by --- on 07.03.13.
//
//

#import <UIKit/UIKit.h>

@interface ChoiseView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *items;
@property (nonatomic, copy) void (^selectedItemBlock)(id item);

- (id)initWithItems:(NSArray *)items andWithIndexOfActiveIndex:(NSInteger)index;
- (id)initWithItems:(NSArray *)items;
@property (nonatomic,assign) BOOL isSelected;

@end
