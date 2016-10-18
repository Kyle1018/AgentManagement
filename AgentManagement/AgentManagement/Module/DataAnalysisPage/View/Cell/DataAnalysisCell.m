//
//  DataAnalysisCell.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/17.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "DataAnalysisCell.h"
#define CurrentScrrenSize(oldWidth) (oldWidth * (ScreenWidth/375))
@implementation DataAnalysisCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, CurrentScrrenSize(227))];
    bgView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    bgView.layer.borderWidth =1;
    bgView.layer.borderColor = [UIColor colorWithHex:@"b8b8b8"].CGColor;

    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 35)];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithHex:@"4a4a4a"];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:self.titleLabel];
    
    self.lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, self.titleLabel.height,ScreenWidth-20,bgView.height-self.titleLabel.height)];
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
    
    if (sectionIndex == 0) {
       
         self.titleLabel.text = @"库存增减";
    
            NSArray * data01Array = dataArray[0];
            PNLineChartData *data01 = [PNLineChartData new];
            data01.dataTitle = @"库存";
            
            data01.showPointLabel = YES;
            data01.pointLabelFont=[UIFont systemFontOfSize:10];
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
            
            NSArray * data02Array = dataArray[1];
            PNLineChartData *data02 = [PNLineChartData new];
            data02.dataTitle = @"销售量";
            data02.showPointLabel = YES;
            data02.pointLabelFont=[UIFont systemFontOfSize:10];
            data02.pointLabelColor = [UIColor colorWithHex:@"ff3131"];
            data02.color = [UIColor colorWithHex:@"ff3131"];//折线的颜色
            data02.alpha = 1.0f;
            data02.itemCount = data01Array.count;
            data02.inflexionPointColor = [UIColor colorWithHex:@"ff3131"];//折线点的颜色
            data02.inflexionPointStyle = PNLineChartPointStyleCircle;
            data02.getData = ^(NSUInteger index) {
                
                CGFloat yValue = [data02Array[index] floatValue];
        
                return [PNLineChartDataItem dataItemWithY:yValue];
             
            };
            
            
            self.lineChart.chartData = @[data01,data02];
            [self.lineChart strokeChart];
            
            
            self.lineChart.legendStyle = PNLegendItemStyleSerial;
            self.lineChart.legendFont = [UIFont boldSystemFontOfSize:10.0f];
            
            
            //注解视图
            UIView *legend = [self.lineChart getLegendWithMaxWidth:ScreenWidth-20];
            legend.backgroundColor=[UIColor clearColor];
            [legend setFrame:CGRectMake(10, 0, ScreenWidth-20, 35)];
            [self.contentView addSubview:legend];
        
        
    }
    
    else {
       
         self.titleLabel.text = @"全年销售额";
        NSArray * data01Array = dataArray;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.showPointLabel = YES;
        data01.pointLabelFont=[UIFont systemFontOfSize:10];
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
        NSLog(@"%@",data01);
            
        self.lineChart.chartData = @[data01];
        
        [self.lineChart strokeChart];
    }
        
}




@end
