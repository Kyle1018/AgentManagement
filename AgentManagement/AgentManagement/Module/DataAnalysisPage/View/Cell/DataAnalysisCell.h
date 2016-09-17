//
//  DataAnalysisCell.h
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/17.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
@interface DataAnalysisCell : UITableViewCell
@property(nonatomic,strong)PNLineChart* lineChart;
@property(nonatomic,strong) UILabel *titleLabel;
- (void)setDataWithXLabels:(NSArray*)xLabels YLabels:(NSArray*)yLabels datasArray:(NSArray*)dataArray sectionIndex:(NSInteger)sectionIndex;

@end
