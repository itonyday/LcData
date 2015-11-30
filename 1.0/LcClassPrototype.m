//
//  LcClassPrototype.m
//  TonyCC
//
//  Created by Tony Day on 11/29/15.
//  Copyright © 2015 Tony Day. All rights reserved.
//

#import "LcClassPrototype.h"
#import <objc/runtime.h>


@implementation LcClassPrototype
{
    Class _theClass;
}

-(instancetype)init
{
    @throw [[NSException alloc] initWithName:@"ArgumentException" reason:@"Call initWithClass: instead of init." userInfo:nil];
}

-(instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    _theClass = aClass;
    
    return self;
}

- (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(_theClass, &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}


@end
