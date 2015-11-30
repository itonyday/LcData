//
//  LcDataRow.m
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import "LcDataRow.h"
#import "LcDataTable.h"
#import "LcDataColumn.h"


@implementation LcDataRow
{
    NSArray *_columns;
    NSMutableArray *_data;
}
-(NSArray *) columns{
    return _columns;
}
-(NSString *) description
{
    NSMutableString *mstr = [NSMutableString new];
    
    for (int i = 0; i < _columns.count; ++i) {
        if (mstr.length > 0) {
            [mstr appendString:@" "];
        }
        
        id nextData = [_data objectAtIndex:i];
        NSString *nextStr;
        
        if (nextData == [NSNull null]) {
            nextStr = @"<null>";
        }else{
            nextStr = (NSString *)nextData;
        }
        
        [mstr appendString:nextStr];
    }
    
    return [mstr description];
}

-(id) initWithColumns:(NSArray *)columns
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _columns = columns;
    [self loadNewData];
    
    return self;
}

-(void) loadNewData{
    _data = [[NSMutableArray alloc] initWithCapacity: _columns.count];
    
    for (int i = 0; i < _columns.count; ++i) {
        [_data insertObject:[NSNull null] atIndex:i];
    }
}

-(NSUInteger) count{
    return _columns.count;
}

-(int) getColumnIndex: (NSString *) columnName
{
    for (int i = 0; i < _columns.count; ++i) {
        LcDataColumn *nextColumn = (LcDataColumn *)[_columns objectAtIndex:i];
        BOOL isSame = [LcDataTable isSameColumnName:nextColumn.name to:columnName];
       
        if (!isSame) {
            continue;
        }
        
        return i;
    }
    
    @throw [[NSException alloc]
            initWithName:@"LcArgumentException"
            reason:[NSString stringWithFormat:@"can not find column name '%@'.", columnName]
            userInfo:nil];
}

-(void) checkColumnIndex: (int) columnIndex
{
    if (columnIndex >= _columns.count) {
        int maxIndex =(int)(_columns.count - 1);
        @throw [[NSException alloc]
                initWithName:@"LcArgumentException"
                reason:[NSString stringWithFormat:@"given index %i is out of bounds,  max index of column is %i.", columnIndex, maxIndex ]
                userInfo:nil];
    }
}

-(id ) getData:(NSString *)columnName
{
    int columnIndex  =[self getColumnIndex:columnName];
    return [_data objectAtIndex:columnIndex];
}

-(NSString *) getByIndex:(int)columnIndex
{
    [self checkColumnIndex:columnIndex];
    return [_data objectAtIndex:columnIndex];
}

-(void) setData:(NSString *)columnName withData:(NSString *)data
{
    int columnIndex = [self getColumnIndex:columnName];
    
    if (data == nil) {
        [_data replaceObjectAtIndex:columnIndex withObject:@""];
    }else{
        [_data replaceObjectAtIndex:columnIndex withObject:data];
    }
}

-(void) setByIndex:(int)columnIndex withData:(NSString *)data
{
    [self checkColumnIndex:columnIndex];
    [_data replaceObjectAtIndex:columnIndex withObject:data];
}

-(LcDataColumn *) getColumn:(int)columnIndex
{
    [self checkColumnIndex:columnIndex];
    return [_columns objectAtIndex:columnIndex];
}
//
//-(NSString *) getColumnTextWithoutAutoIncrement
//{
//    NSMutableString *mstr = [NSMutableString new];
//    for (int i = 0; i < _columns.count; ++i) {
//        LcDataColumn *item =[_columns objectAtIndex:i];
//        
//        if (item.isAutoIncrement) {
//            continue;
//        }
//        
//        if (mstr.length > 0) {
//            [mstr appendString:@", "];
//        }
//        
//        [mstr appendFormat:@"[%@]", item.name];
//    }
//    
//    return mstr;
//}
@end
