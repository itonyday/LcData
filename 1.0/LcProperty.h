//
//  LcProperty.h
//  TonyCC
//
//  Created by Tony Day on 11/29/15.
//  Copyright © 2015 Tony Day. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LcProperty : NSObject
@property (nonatomic, strong) NSString *propertyName;
@property (nonatomic, strong) NSString *dataTypeName;

-(instancetype)initWithRawPropertyString:(NSString *)rawPropStr;
@end
