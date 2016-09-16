//
//  DataAnalysisViewController.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/8/1.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisViewController.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNColor.h"
#import "PNLineChartDataItem.h"
@interface DataAnalysisViewController ()

@property(nonatomic,strong)PNLineChart*lineChart;
@end

@implementation DataAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createKXlineChart];//创建库存和销售折线图
    
    [self createXlineChart];
}

- (void)createKXlineChart {
    
    
}

- (void)createXlineChart {
    
 
    UILabel *pnLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.view.centerY-9, ScreenWidth, 18)];
    pnLabel.text =@"全年销售额";
    pnLabel.backgroundColor=[UIColor redColor];
    pnLabel.textColor=[UIColor blackColor];
    pnLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:pnLabel];
    
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(10, pnLabel.bottom+15,ScreenWidth-20,ScreenHeight-pnLabel.bottom-15-49-10)];
    self.lineChart.backgroundColor=[UIColor whiteColor];

    self.lineChart.yLabelFormat = @"%1.1f";
    
    [self.lineChart setXLabels:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"]];
    self.lineChart.showCoordinateAxis = YES;
    
    // added an examle to show how yGridLines can be enabled
    // the color is set to clearColor so that the demo remains the same
    self.lineChart.yGridLinesColor = [UIColor clearColor];
    self.lineChart.showYGridLines = YES;
    
    //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
    //Only if you needed
    self.lineChart.yFixedValueMax = 1200.0;
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:@[
                                 @"0",
                                 @"200",
                                 @"400",
                                 @"600",
                                 @"800",
                                 @"1000",
                                 @"1200",
                                 ]
     ];
    
    // Line Chart #1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @0.0, @186.2, @127.2, @176.2,@1000,@500,@688,@0,@29];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = @"Alpha";
    data01.color = [UIColor redColor];
    data01.alpha = 0.3f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = [UIColor greenColor];
    data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart #2
    NSArray * data02Array = @[@0.0, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.showPointLabel = YES;
    data02.pointLabelFont=[UIFont systemFontOfSize:12];
    data02.pointLabelColor = [UIColor blueColor];
    data02.dataTitle = @"Beta";
    data02.color = [UIColor blueColor];
    data02.alpha = 0.5f;
    data02.itemCount = data02Array.count;
   // data02.inflexionPointColor = [UIColor redColor];
    data02.inflexionPointStyle = PNLineChartPointStyleCircle;
   
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChart.chartData = @[data01, data02];
    [self.lineChart strokeChart];
    // self.lineChart.delegate = self;
 
    
    [self.view addSubview:self.lineChart];
    
//        self.lineChart.legendStyle = PNLegendItemStyleStacked;
//        self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//        self.lineChart.legendFontColor = [UIColor redColor];
    
//        UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
//    legend.backgroundColor=[UIColor whiteColor];
//        [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
//        [self.view addSubview:legend];
//
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
