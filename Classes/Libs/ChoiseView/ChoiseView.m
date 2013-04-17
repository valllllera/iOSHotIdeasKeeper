//
//  ChoiseView.m
//  CreditWise
//
//  Created by --- on 07.03.13.
//
//

#import "ChoiseView.h"
#import "AddNoteViewController.h"
#import "TableCell.h"

@implementation ChoiseView

#pragma mark - Initialization

- (id)initWithItems:(NSArray *)items andWithIndexOfActiveIndex:(NSInteger)index
{
    self = [self init];
    if (self) {
        self.items = items;
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    return self;
}


- (id)initWithItems:(NSArray *)items
{
    self = [self init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [_items release];
    [_selectedItemBlock release];
    [super dealloc];
}

#pragma mark - @protocol(UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"TableCell";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:nil options:nil] objectAtIndex:0];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.backgroundColor = [UIColor redColor];
        
    }
    cell.textLabel.text = [[_items objectAtIndex:indexPath.row] description];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

#pragma mark - @protocol(UITableViewDelegate)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_selectedItemBlock)
    {
                _selectedItemBlock([_items objectAtIndex:indexPath.row]);
        self.isSelected = YES;
    }
}

@end
