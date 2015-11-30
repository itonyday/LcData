//
//  LcDataTable.h
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import <Foundation/Foundation.h>
#import "LcDataRow.h"

@interface LcDataTable : NSObject
@property (nonatomic, strong) NSMutableArray *columns;
@property (nonatomic, strong) NSMutableArray *rows;

-(id) initWithFields: (NSArray *)fields andPk: (NSString *)pkField andAutoIncrement: (NSString *)autoIncrementField;

-(void) addColumn:(LcDataColumn *) newColumn;
-(void) addColumnName:(NSString *) name;
-(LcDataRow *) newRow;
-(void) addRow:(LcDataRow *) rowData;
-(LcDataRow *) getRow: (int) index;

+(BOOL) isSameColumnName: (NSString *) columnName1 to: (NSString *) columnName2;

@end
