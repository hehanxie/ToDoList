//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by whstarlit on 16/8/8.
//  Copyright © 2016年 whstarlit. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoItem.h"
#import "AddToDoItemViewController.h"

@interface ToDoListTableViewController ()



@end

@implementation ToDoListTableViewController
@synthesize toDoItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toDoItems = [[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem = self.addItemButton;
    _isEditing = false;
    //调用初始化函数
    [self loadInitialData];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete implementation, return the number of rows
    //返回数组的数量(行数)
    return [self.toDoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //item识别标识符
    static NSString *CellIdentifier = @"ListPrototypeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    //显示确认状态图案
    if (toDoItem.completed)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    //选择要展开的控制器
    AddToDoItemViewController *source = [segue sourceViewController];
    //取回控制器的待办事项
    ToDoItem *item = source.toDoItem;
    if (item != nil)
    {
        [self.toDoItems addObject:item];
        [self.tableView reloadData];
    }
}

-(void)loadInitialData
{
    //初始化item并存入数组
    ToDoItem *item1 = [[ToDoItem alloc] init];
    item1.itemName = @"Buy Battery";
    [self.toDoItems addObject:item1];
    ToDoItem *item2 = [[ToDoItem alloc] init];
    item2.itemName = @"Buy Bread";
    [self.toDoItems addObject:item2];
    ToDoItem *item3 = [[ToDoItem alloc] init];
    item3.itemName = @"Running";
    [self.toDoItems addObject:item3];
}

#pragma mark - Table view delegate

//选择item后，item的状态
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格选定后立即取消锁定
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //在toDoItems数组中搜索相应的ToDoItem
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    //切换选定的Item的当前状态
    tappedItem.completed = !tappedItem.completed;
    //重新载入刚更新的数据
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


//添加左滑删除功能
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //如果左滑是删除
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        /*
         数据源删除
         indexPath成员
         section－－－表格所在的第几组
         row    －－－表格所在第几行
         */
        //浅拷贝会出问题，删除错误，无法删除数据源
        //NSMutableArray *subArray = _toDoItems[indexPath.section];
        [toDoItems removeObjectAtIndex:indexPath.row];
        
        /*
         UI--列表删除
         */
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        //刷新数据
        //[tableView reloadData];
    }
}

//添加左滑删除文字
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return @"删除";
}

//编辑按钮
- (IBAction)buttonPressed:(id)sender
{
    //退出编辑状态
    if (_isEditing)
    {
        _isEditing = false;
        [self.tableView setEditing:NO animated:NO];
        [self.editButton setTitle:@"Edit"];
        //恢复添加按钮
        [self.addItemButton setEnabled:YES];
        [self.addItemButton setTintColor:nil];
    }
    else
    {
        _isEditing = true;
        [self.editButton setTitle:@"Cancel"];
        [self.tableView setEditing:YES animated:YES];
        [self.addItemButton setEnabled:NO];
        [self.addItemButton setTintColor: [UIColor clearColor]];
    }
}


//返回YES，表示支持单元格的移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//编辑状态下：删除tableView中cell
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//移动tableView中的cell
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //修改数据源
    [self.toDoItems exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    //让表视图对应的行进行移动
    [tableView exchangeSubviewAtIndex:sourceIndexPath.row withSubviewAtIndex:destinationIndexPath.row];
}

- (IBAction)unwindExit:(UIStoryboardSegue *)segue
{
    
    //    LoginViewController *source = [segue sourceViewController];
}

- (IBAction)exitButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end















