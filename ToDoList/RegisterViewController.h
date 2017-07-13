//
//  RegisterViewController.h
//  ToDoList
//
//  Created by Nil on 2017/7/12.
//  Copyright © 2017年 whstarlit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

extern NSMutableDictionary *accountInfo;

- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;
@end
