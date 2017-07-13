//
//  RegisterViewController.m
//  ToDoList
//
//  Created by Nil on 2017/7/12.
//  Copyright © 2017年 whstarlit. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    float cursorHeight;                                    //光标距底部的高度
    float spacingWithKeyboardAndCursor;                    //光标与键盘之间的间隔
}

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordRepeatTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

extern NSMutableDictionary *accountInfo;



@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    _cancelButton.layer.masksToBounds = YES;
    _cancelButton.layer.borderWidth = 1;
    _cancelButton.layer.cornerRadius = 10.0;
    _cancelButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    _confirmButton.layer.masksToBounds = YES;
    _confirmButton.layer.borderWidth = 1;
    _confirmButton.layer.cornerRadius = 10.0;
    _confirmButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderWidth = 1;
    _imageView.layer.cornerRadius = 112.5;
    _imageView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordRepeatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (IBAction)confirmRegisterButton:(id)sender
{
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *password2 = _passwordRepeatTextField.text;
    BOOL isExist = false;
    
    if ([password isEqualToString:password2] && username.length != 0 && password.length != 0)
    {
        for (NSString *key in accountInfo)
        {
            if ([key isEqualToString:username])
            {
                isExist = true;
                NSLog(@"username exist");
            }
        }
        //如果用户名不存在，则加入字典，并返回登陆页面
        if (!isExist)
        {
            [accountInfo setObject:password forKey:username];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Register Success" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                //点击按钮的响应事件
                //返回上层视图
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }
        else
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Username Existed" preferredStyle:  UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }
        
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Information Error" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//切换键盘return功能
- (IBAction)textFieldDidEndOnExit:(id)sender
{
    if (sender == self.usernameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (sender == self.passwordTextField)
    {
        [self.passwordRepeatTextField becomeFirstResponder];
    }
    else
    {
        [sender resignFirstResponder];
        [self confirmRegisterButton:sender];
    }
}


//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float keyboardHeight = keyboardRect.size.height;
    spacingWithKeyboardAndCursor = keyboardHeight - cursorHeight + 20;
//    NSLog(@"%0.1f", spacingWithKeyboardAndCursor);
    if (spacingWithKeyboardAndCursor > 0)
    {
        [UIView animateWithDuration:1.0f animations:^{
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            self.view.frame = CGRectMake(0.0f, -(spacingWithKeyboardAndCursor), self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    if (spacingWithKeyboardAndCursor > 0)
    {
        [UIView animateWithDuration:1.0f animations:^{
            //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
            self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (IBAction)textFieldEditingDidBegin:(id)sender
{
    if ([sender isEqual:self.usernameTextField])
    {
        cursorHeight = self.view.frame.size.height - CGRectGetMaxY(self.usernameTextField.frame);
    }
    else
    {
        cursorHeight = self.view.frame.size.height - CGRectGetMaxY(self.passwordRepeatTextField.frame);
    }
}

@end
