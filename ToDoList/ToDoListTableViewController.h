//
//  ToDoListTableViewController.h
//  ToDoList
//
//  Created by whstarlit on 16/8/8.
//  Copyright © 2016年 whstarlit. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToDoListTableViewController : UITableViewController

//存放当前目录下的items
@property NSMutableArray *toDoItems;

//编辑按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItemButton;

//过渡动画
-(IBAction)unwindToList:(UIStoryboardSegue *)sender;

//载入页面
-(void)viewDidLoad;

//编辑状态
@property bool isEditing;
/*
 保存数据－－－plist文件只能保存NSString、NSDictionary、NSArray、NSData、NSNumber类的数据
 自定义类的数组不能保存
*/


@end
