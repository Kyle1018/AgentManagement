//
//  AMEditCustomerRequest.m
//  AgentManagement
//
//  Created by 郭华滨 on 16/9/25.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "AMEditCustomerRequest.h"
#import "AMCustomer.h"
@implementation AMEditCustomerRequest

- (instancetype)initWithAddCustomerInfo:(NSDictionary*)customerInfo {
    
    self = [super init];
    if (self) {
        
        if (self != nil) {
            
            [self.requestParameters safeAddEntriesFromDictionary:customerInfo];
            
        }
        
    }
    return self;
}

- (NSString *)urlPath
{
    return @"apicustomer/edit";
}

- (id)buildModelWithJsonDictionary:(NSDictionary *)dictionary
{
    
    
    DDLogDebug(@"%@",dictionary);
    
    return [[AMCustomer alloc]initWithDictionary:dictionary error:nil];
    
}

/*
 Printing description of customerInfo:
 {
 "a_id" = 1;
 address = vvvvvdd;
 "an_id" = 10;
 chlorine = 6;
 city = "\U5317\U4eac\U5e02";
 county = "\U4e1c\U57ce\U533a";
 hardness = 6;
 id = 57;
 name = "\U77f3\U6797\U98ce\U666f\U533a";
 order =     (
 {
 brand = "\U7d22\U5c3c";
 "buy_time" = "2016-09-26 08:37:13";
 "c_id" = 57;
 cycle = "1\U4e2a\U6708";
 id = 76;
 "install_time" = "2016-09-26 08:37:16";
 pmodel = "a\U2006a\U2006a";
 }
 );
 ph = 3;
 phone = 11123334567;
 province = "\U5317\U4eac";
 "s_id" = 5;
 tds = 2;
 "u_id" = 10;
 }
 */

@end
