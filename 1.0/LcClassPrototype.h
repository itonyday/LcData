//
//  LcClassPrototype.h
//  TonyCC
//
//  Created by Tony Day on 11/29/15.
//  Copyright © 2015 Tony Day. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LcClassPrototype : NSEnumerator
@property (nonatomic, strong) NSArray *properties;

-(instancetype)initWithClass:(Class)aClass;

@end
