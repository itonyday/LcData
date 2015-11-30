//
//  LcDataTable.m
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import "LcDataTable.h"
#import "LcDataColumn.h"

@implementation LcDataTable
{
}

@synthesize columns, rows;


/***** private ********start*/
-(void) checkSchema: (LcDataRow *) row
{
    BOOL sameColumns = row.columns == self.columns;
    if (!sameColumns) {
        NSException *exp = [[NSException alloc]
                            initWithName:@"LcDataException"
                            reason:@"schema of new row is not same as table." userInfo:nil];
        @throw exp;
    }
}
/***** private ********end*/

+(BOOL) isSameColumnName:(NSString *)columnName1 to:(NSString *)columnName2
{
    NSComparisonResult cmpResult = [columnName1 compare:columnName2];
    return cmpResult == NSOrderedSame;
}

-(NSString *) description
{
    NSMutableString *mstr = [NSMutableString new];
    
    for (int i = 0; i < self.columns.count; ++i) {
        if (mstr.length >0) {
            [mstr appendString:@" | "];
        }
        
        LcDataColumn *nextColumn = (LcDataColumn *)[self.columns objectAtIndex:i];
        [mstr appendFormat:@"%@", nextColumn.name];
    }
    
    for (int i=0; i < self.rows.count; ++i) {
        if (mstr.length >0) {
            [mstr appendString:@"\n"];
        }
        
        [mstr appendString:[[self.rows objectAtIndex:i]  description]];
    }
    
    return mstr;
}

-(id) init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.columns = [NSMutableArray new];
    self.rows = [NSMutableArray new];
    return self;
}

-(id) initWithFields:(NSArray *)fields andPk:(NSString *)pkField andAutoIncrement:(NSString *)autoIncrementField
{
    self = [self init];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *newColumns = [LcDataColumn loadFromArray:fields
                pkField:pkField autoIncrementField:autoIncrementField];
    self.columns = newColumns;
    self.rows = [NSMutableArray new];
    
    return self;
}

-(LcDataRow *) newRow
{
    LcDataRow *aNewRow = [[LcDataRow alloc]
                          initWithColumns:self.columns];
    return aNewRow;
}

-(void) addRow:(LcDataRow *)rowData
{
    [self checkSchema:rowData];
    [self.rows addObject:rowData];
}

-(LcDataRow *) getRow:(int)index
{
    return [self.rows objectAtIndex:index];
}

-(void) addColumn:(LcDataColumn *)newColumn
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name CONTAINS '%@'", newColumn.name];
    BOOL contained = [pred evaluateWithObject:self.columns];
    
    if (contained) {
        NSException *exp = [[NSException alloc]
                            initWithName:@"LcDataException"
                            reason:[NSString stringWithFormat:@"the column name '%@' is already exists.", newColumn]
                            userInfo:nil];
        @throw exp;
    }
    
    [self.columns addObject:newColumn];
}

-(void) addColumnName:(NSString *)name
{
    LcDataColumn *column = [[LcDataColumn alloc]
                            initWithName:name];
    [self addColumn:column];
}
@end
