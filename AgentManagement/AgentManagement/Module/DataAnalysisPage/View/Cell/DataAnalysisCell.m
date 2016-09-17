//
//  DataAnalysisCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/17.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisCell.h"

@implementation DataAnalysisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.contentView.width-20, self.contentView.height+20)];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    bgView.layer.borderWidth =1;
    bgView.layer.borderColor = [UIColor blackColor].CGColor;

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width-20, 35)];
    self.titleLabel.backgroundColor=[UIColor whiteColor];
    self.titleLabel.text = @"全年销售额";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.titleLabel];
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom,self.contentView.width-20,self.contentView.height-25)];
    self.lineChart.backgroundColor=[UIColor whiteColor];
    [bgView addSubview:self.lineChart];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithXLabels:(NSArray*)xLabels YLabels:(NSArray*)yLabels datasArray:(NSArray*)dataArray sectionIndex:(NSInteger)sectionIndex {
    
    [self.lineChart setXLabels:xLabels];

    self.lineChart.yFixedValueMax = [[yLabels lastObject]floatValue];
    self.lineChart.yFixedValueMin = 0.0;
    
    [self.lineChart setYLabels:yLabels];
    NSArray * data01Array = dataArray;
    PNLineChartData *data01 = [PNLineChartData new];
//    data01.alpha = 0;
  //  data01.dataTitle = @"Alpha";
    data01.showPointLabel = YES;
    data01.pointLabelFont=[UIFont systemFontOfSize:12];
    data01.pointLabelColor = [UIColor colorWithHex:@"47b6ff"];
    data01.color = [UIColor colorWithHex:@"47b6ff"];//折线的颜色
    data01.alpha = 1.0f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointColor = [UIColor colorWithHex:@"47b6ff"];//折线点的颜色
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
        
    self.lineChart.chartData = @[data01];
    [self.lineChart strokeChart];
    
    
    if (sectionIndex == 0) {
        
        self.titleLabel.hidden = YES;
    }
    else {
        
        self.titleLabel.hidden = NO;
        
    }
    
//    self.lineChart.legendStyle = PNLegendItemStyleSerial;
//    self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    self.lineChart.legendFontColor = [UIColor greenColor];


//    UIView *legend = [self.lineChart getLegendWithMaxWidth:ScreenWidth-20];
//    legend.backgroundColor=[UIColor redColor];
//    [legend setFrame:CGRectMake(10, 0, ScreenWidth-20, 100)];
//    [self.contentView addSubview:legend];
    
    
    
//    UIView *legend = [self.lineChart getLegendWithMaxWidth:ScreenWidth-20];
//    legend.backgroundColor=[UIColor whiteColor];
//    [legend setFrame:CGRectMake(30, 340,100,100)];
//    [self.contentView addSubview:legend];
}

@end
