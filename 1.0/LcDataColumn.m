//
//  LcDataTable.m
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import "LcDataColumn.h"
#import "LcDataTable.h"

@implementation LcDataColumn
@synthesize name, isPk, isAutoIncrement;


-(id) initWithName: (NSString *) aName setAsPk: (BOOL)isPkField setAsAutoIncrement: (BOOL)autoIncrement;
{
    self = [super init];
    self.name = aName;
    self.isPk = isPkField;
    self.isAutoIncrement = autoIncrement;
    
    return self;
}

-(id) initWithName:(NSString *)aName
{
    self = [self initWithName:aName setAsPk:NO setAsAutoIncrement:NO];
    return self;
}

+(NSMutableArray *) loadFromArray: (NSArray *)arrField pkField: (NSString *)aPkField autoIncrementField: (NSString *)aAutoIncrementField;
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:arrField.count];
    
    for (int i = 0; i < arrField.count; ++i) {
        NSString *item = [arrField objectAtIndex:i];
        LcDataColumn *column = [[LcDataColumn alloc] initWithName:item];
        
        if (aPkField && [LcDataTable isSameColumnName:item to:aPkField]) {
            column.isPk = YES;
        }
        
        if (aAutoIncrementField && [LcDataTable isSameColumnName:item to:aAutoIncrementField]) {
            column.isAutoIncrement = YES;
        }
        
        [result addObject:column];
    }
    
    return result;
}

@end
