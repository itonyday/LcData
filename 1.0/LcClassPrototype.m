//
//  LcClassPrototype.m
//  TonyCC
//
//  Created by Tony Day on 11/29/15.
//  Copyright © 2015 Tony Day. All rights reserved.
//

#import "LcClassPrototype.h"
#import "LcProperty.h"
#import <objc/runtime.h>


@implementation LcClassPrototype
{
    Class _theClass;
    NSMutableArray *_allProp;
    int _currIndex;
}

-(instancetype)init
{
    @throw [[NSException alloc] initWithName:@"ArgumentException" reason:@"Call initWithClass: instead of init." userInfo:nil];
}

-(instancetype)initWithClass:(Class)aClass
{
    self = [super init];
    if (self) {
        _theClass = aClass;
        [self load];
    }
    
    return self;
}

-(NSArray *)properties
{
    return _allProp;
}

- (void)load
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList(_theClass, &count);
    
    _allProp = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t rawProp = properties[i];
        const char *propAttr = property_getAttributes(rawProp);
        NSString *rawPropStr = [NSString stringWithUTF8String:propAttr];
        LcProperty *prop = [[LcProperty alloc] initWithRawPropertyString:rawPropStr];
        [_allProp addObject:prop];
    }
    
    free(properties);
}

#pragma mark enumerator
-(NSArray *)allObjects
{
    return _allProp;
}

- (id)nextObject
{
    if(_currIndex == [_allProp count])
    {
        _currIndex = 0;
        return nil;
    }
    
    return [_allProp objectAtIndex:_currIndex++];
}

@end
