//
//  AMSearchAdministratorView.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSearchAdministratorView.h"
#import "CustomerManageViewModel.h"

@interface AMSearchAdministratorView ()

@property (nonatomic, weak) IBOutlet UIButton *backgroundButton;
@property (nonatomic, weak) IBOutlet UIButton *contentBackgroundButton;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UIButton *areaButton;
@property (nonatomic, weak) IBOutlet UIButton *resetButton;
@property (nonatomic, weak) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) PickerView *pickerView;
@property (nonatomic, assign) NSInteger lRow;

@property (nonatomic, strong) PickerViewProtocol *protocol;
@property (nonatomic, strong) CustomerManageViewModel *customerManageViewModel;

@end

@implementation AMSearchAdministratorView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initializeControl];
}

- (PickerViewProtocol *)protocol {
    if (!_protocol) {
        _protocol = [[PickerViewProtocol alloc] init];
    }
    return _protocol;
}

- (CustomerManageViewModel *)customerManageViewModel {
    if (!_customerManageViewModel) {
        _customerManageViewModel = [[CustomerManageViewModel alloc] init];
    }
    return _customerManageViewModel;
}

- (void)initializeControl {
    @weakify(self);
    [[self.backgroundButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self resignTextField];
        [self removeFromSuperview];
    }];
    
    [[self.contentBackgroundButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self resignTextField];
    }];
    
    [[self.areaButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self resignTextField];
        [self showAreaPicker];
    }];
    
    [[self.resetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.nameTextField.text = nil;
        self.phoneTextField.text = nil;
        [self.resetButton setTitle:@"" forState:UIControlStateNormal];
        [self resignTextField];
    }];
    
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (self.searchBlock) {
            self.searchBlock(self.nameTextField.text, self.phoneTextField.text, self.areaButton.titleLabel.text);
        }
        [self resignTextField];
        [self removeFromSuperview];
    }];
}

- (void)resignTextField {
    [self.nameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}

- (void)showAreaPicker {
    self.pickerView = [PickerView showAddTo:kAppWindow];
    
    self.pickerView.picker.delegate = self.protocol;
    self.pickerView.picker.dataSource = self.protocol;
    [[self.customerManageViewModel requestAreaListData:0 lIndex:0] subscribeNext:^(id x) {
        self.protocol.pickerDataArray = x;
        self.protocol.pickerDataArrayB = x[1];
        self.protocol.pickerDataArrayC = x[2];
    }];
    
    @weakify(self);
    self.protocol.didSelectRow = ^(NSInteger row,NSInteger component) {
        @strongify(self);
        if ((component == 0) || (component == 1)) {
            if (component == 0) {
                self.lRow = row;
            }
            [self.protocol.pickerDataArray removeAllObjects];
            [self.protocol.pickerDataArrayB removeAllObjects];
            [self.protocol.pickerDataArrayC removeAllObjects];
            [[self.customerManageViewModel requestAreaListData:component==0?row:self.lRow lIndex:component==0?0:row]subscribeNext:^(NSMutableArray* x) {
                self.protocol.pickerDataArray = x;
                self.protocol.pickerDataArrayB = x[1];
                self.protocol.pickerDataArrayC = x[2];
                [self.pickerView.picker selectedRowInComponent:1];
                [self.pickerView.picker selectedRowInComponent:2];
                [self.pickerView.picker reloadAllComponents];
            }];
        }
    };
    
    self.pickerView.tapConfirmBlock = ^(NSString *parameter) {
        @strongify(self);
        [self.areaButton setTitle:[self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]] forState:UIControlStateNormal];
        //        provinceLabel.text = [ self.protocol.pickerDataArray[0]objectAtIndex:[self.pickerView.picker selectedRowInComponent:0]];
        //        cityLabel.text = [ self.protocol.pickerDataArray[1]objectAtIndex:[self.pickerView.picker selectedRowInComponent:1]];
        //        townLabel.text = [ self.protocol.pickerDataArray[2]objectAtIndex:[self.pickerView.picker selectedRowInComponent:2]];
    };
}

@end
