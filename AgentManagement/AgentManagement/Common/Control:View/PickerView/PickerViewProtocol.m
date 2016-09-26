//
//  PickerViewProtocol.m
//  AgentManagement
//
//  Created by huabin on 16/9/23.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "PickerViewProtocol.h"

@implementation PickerViewProtocol

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return [self.pickerDataArray count];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [[self.pickerDataArray objectAtIndex:component]count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return  [[self.pickerDataArray objectAtIndex:component]objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 42;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
  
    if ( [self.pickerDataArray count]==3) {
        
        return ScreenWidth/3;
    }
    else if ([self.pickerDataArray count]==2) {
        
        return ScreenWidth/2;
    }
 
    else {
        
        return ScreenWidth;
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    //三轮
    if (self.pickerDataArrayB.count>0 && self.pickerDataArrayC.count>0) {

        if (self.didSelectRow) {
            
            
            self.didSelectRow(row,component);
        }

    }
    
    //俩轮
    else if (self.pickerDataArrayB.count>0 && self.pickerDataArrayC.count==0) {
        
        if (component==0) {
            
            [self.pickerDataArray replaceObjectAtIndex:1 withObject: [self.pickerDataArrayB objectAtIndex:row]];
            
            [pickerView selectedRowInComponent:1];
            [pickerView reloadComponent:1];
        }
        
    }
    //一轮
    else {
        
        [self.pickerDataArray[component]objectAtIndex:row];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

@end
