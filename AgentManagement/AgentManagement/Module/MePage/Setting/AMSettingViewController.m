//
//  AMSettingViewController.m
//  AgentManagement
//
//  Created by Kyle on 2016/10/19.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMSettingViewController.h"
#import "AMSettingViewModel.h"
#import "AMSettingTableViewCell.h"

NSString *const kSettingTitleKey = @"kSettingTitleKey-fjadl";
NSString *const kSettingSubtitleKey = @"kSettingSubtitleKey-fjdalfj";
NSString *const kIsImageCellKey = @"kIsImageCellKey-fdalf";

NSString *const kPortraitString = @"头像";
NSString *const kNameString = @"名字";
NSString *const kPhoneString = @"电话";
NSString *const kAddressString = @"地址";
NSString *const kCertificationString = @"企业认证";
NSString *const kModifyPasswordString = @"修改密码";

@interface AMSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *settingTableView;

@property (nonatomic, strong) NSArray *settingArray;

@end

@implementation AMSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeControl {
    self.title = @"设置";
    
    [self reloadSetting];
}

- (void)reloadSetting {
    self.settingArray = @[@[@{kSettingTitleKey : kPortraitString, kIsImageCellKey : @(YES)}, @{kSettingTitleKey : kNameString, kSettingSubtitleKey : @""}, @{kSettingTitleKey : kPhoneString, kSettingSubtitleKey : @""}, @{kSettingTitleKey : kAddressString, kSettingSubtitleKey : @""}], @[@{kSettingTitleKey : kCertificationString, kSettingSubtitleKey : @""}], @[@{kSettingTitleKey : kModifyPasswordString, kSettingSubtitleKey : @""}]];
    [self.settingTableView reloadData];
}

- (NSDictionary *)dictionaryForIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = nil;
    
    if (indexPath.section < self.settingArray.count) {
        NSArray *array = self.settingArray[indexPath.row];
        
        if (indexPath.row < array.count) {
            dictionary = array[indexPath.row];
        }
    }
    return dictionary;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger number = 0;
    
    if (section < self.settingArray.count) {
        number = [(NSArray *)self.settingArray[section] count];
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCellIdentifier];
    
    if (!cell) {
        cell = [AMSettingTableViewCell viewFromXib];
    }
    
    NSDictionary *dictionary = [self dictionaryForIndexPath:indexPath];
    
    [cell updateWithTitle:dictionary[kSettingTitleKey] subtitle:dictionary[kSettingSubtitleKey] isImageCell:[dictionary[kIsImageCellKey] boolValue]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.;
    } else if (section == 1) {
        return 20.;
    } else {
        return 20.;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., ScreenWidth, 20.)];
    
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary = [self dictionaryForIndexPath:indexPath];
    
    if ([dictionary[kSettingTitleKey] isEqualToString:kPortraitString]) {
        return 64.;
    } else {
        return 44.;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dictionary = [self dictionaryForIndexPath:indexPath];
    NSString *title = dictionary[kSettingTitleKey];
    
    if (title.length > 0) {
        if ([title isEqualToString:kPortraitString]) {
        } else if ([title isEqualToString:kNameString]) {
            
        } else if ([title isEqualToString:kAddressString]) {
            
        } else if ([title isEqualToString:kPhoneString]) {
            
        } else if ([title isEqualToString:kCertificationString]) {
            
        } else if ([title isEqualToString:kModifyPasswordString]) {
            
        }
    }
}

@end
