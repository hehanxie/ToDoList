//
//  LoginViewController.m
//  ToDoList
//
//  Created by Nil on 2017/7/12.
//  Copyright © 2017年 whstarlit. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

extern NSMutableDictionary *accountInfo;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    _loginButton.layer.masksToBounds = YES;
    _loginButton.layer.borderWidth = 1;
    _loginButton.layer.cornerRadius = 10.0;
    _loginButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
//    _registerButton.layer.masksToBounds = YES;
//    _registerButton.layer.borderWidth = 1;
//    _registerButton.layer.cornerRadius = 10.0;
//    _registerButton.layer.borderColor = [[UIColor grayColor] CGColor];
    
    //右侧清除按钮
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender
{
    BOOL isError = false;
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;

    if (username.length != 0 && password.length != 0)
    {
        NSString *pass = (NSString *)[accountInfo objectForKey:username];
        
        //用户不存在（获取不到数据库中密码)
        if (pass == nil)
        {
            isError = true;
            NSLog(@"not exit");
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"User Not Exit" preferredStyle:  UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alert animated:true completion:nil];
        }
        //用户名，密码匹配
        else if ([pass isEqualToString:password])
        {
            isError = false;
            //NSLog(@"infor correct");
            //跳到下一个页面
            [self performSegueWithIdentifier:@"ToDoListView" sender:self];
        }
        else
        {
            isError = true;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Username or Password Error" preferredStyle:  UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
        }
    }
    //信息填写错误
    else
    {
        isError = true;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Username or Password Error" preferredStyle:  UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
        
    }
    if (isError)
    {
        _usernameTextField.text = @"";
        _passwordTextField.text = @"";
    }
}

- (IBAction)registerButton:(id)sender
{
    _usernameTextField.text = @"";
    _passwordTextField.text = @"";
}


- (IBAction)unwindLogin:(UIStoryboardSegue *)segue
{
//    LoginViewController *source = [segue sourceViewController];
}

//点击空白隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    if (sender == self.usernameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else
    {
        [sender resignFirstResponder];
        [self loginButton:sender];
    }
}


@end
