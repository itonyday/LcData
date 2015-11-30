//
//  LcProperty.m
//  TonyCC
//
//  Created by Tony Day on 11/29/15.
//  Copyright © 2015 Tony Day. All rights reserved.
//

#import "LcProperty.h"

@implementation LcProperty

-(instancetype)initWithRawPropertyString:(NSString *)rawPropStr
{
    self = [super init];
    [self parseRaw:rawPropStr];
    return self;
}

-(void)parseRaw:(NSString *)rawPropStr
{
    /*
     Ti,N,V__id
     Tf,N,V_balance
     T@"NSDate",&,N,V_dt
     T@"NSString",&,N,V_cardName
     */
    NSArray *components = [rawPropStr componentsSeparatedByString:@","];
    NSString *typeIndicator = components[0];
    NSString *propNameIndicator;
    
    if ([typeIndicator rangeOfString:@"@"].length ){
      propNameIndicator = components[3];
    }else{
          propNameIndicator = components[2];
    }
    
    if ([typeIndicator  isEqual: @"Ti"]) {
        self.dataTypeName = @"int";
    }else if ([typeIndicator  isEqual: @"Tf"]) {
        self.dataTypeName = @"float";
    }else if ([typeIndicator  isEqual: @"T@\"NSDate\""]) {
        self.dataTypeName = @"NSDate";
    } else {//if ([typeIndicator  isEqual: @"T@\"NSString\""]) {
        self.dataTypeName = @"NSString";
    }
    
    self.propertyName = [propNameIndicator substringFromIndex:2];
}
@end
