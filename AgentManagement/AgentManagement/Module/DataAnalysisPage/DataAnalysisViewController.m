//
//  DataAnalysisViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewController.h"

@interface DataAnalysisViewController ()

@end

@implementation DataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"dddd");
    
    [RACObserve(self, userModel)subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
