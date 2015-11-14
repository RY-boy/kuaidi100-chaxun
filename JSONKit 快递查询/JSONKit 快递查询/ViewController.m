//
//  ViewController.m
//  JSONKit 快递查询
//
//  Created by qingyun on 15/11/14.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
#define basurl @"http://www.kuaidi100.com/query?"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *type;

@property (weak, nonatomic) IBOutlet UITextField *pid;
@end

@implementation ViewController
-(void)jsonClick
{
    //创建url
    NSString *queryStr = [NSString stringWithFormat:@"type=%@&postid=%@",_type.text,_pid.text];
    NSString *str = [basurl stringByAppendingString:queryStr];
    //创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //创建任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:str] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //判断状态
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
            //data转换成对象
           id objct=[data objectFromJSONData];
            if ([objct isKindOfClass:[NSDictionary class]]) {
                NSLog(@"===字典====>%@",objct);
            }
            if ([objct isKindOfClass:[NSArray class]]) {
                NSLog(@"=====字典====%@",objct);
            }
            
        }
    }];
    //启动
    [task resume];
}
-(void)addsubView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(150, 500, 100, 40);
    btn.backgroundColor=[UIColor redColor];
    [btn addTarget:self action:@selector(jsonClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addsubView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
