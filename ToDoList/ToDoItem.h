//
//  ToDoItem.h
//  ToDoList
//
//  Created by whstarlit on 16/8/8.
//  Copyright © 2016年 whstarlit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

//每个item的属性
//item名称
@property NSString *itemName;
//item的状态，完成，未完成
@property BOOL completed;
//item创建的时间(不可变)
@property (readonly)NSData *creationTime;

@end
