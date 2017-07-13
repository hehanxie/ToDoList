//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by whstarlit on 16/8/4.
//  Copyright © 2016年 whstarlit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddToDoItemViewController : UIViewController
//新建的item
@property ToDoItem *toDoItem;
//文本内容
@property (weak, nonatomic) IBOutlet UITextField *textField;
//确认按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end
