//
//  LcDataRow.h
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import <Foundation/Foundation.h>
#import "LcDataColumn.h"


@interface LcDataRow : NSObject
@property (nonatomic , strong) NSArray *columns;

-(id) initWithColumns: (NSArray *) columns;


-(void) setData: (NSString *) columnName withData: (NSString *)data;
-(void) setByIndex: (int) columnIndex withData: (NSString *) data;
-(NSString *) getData: (NSString *) columnName;
-(NSString *) getByIndex: (int) columnIndex;
-(NSUInteger) count;
-(LcDataColumn *) getColumn: (int) columnIndex;
//-(NSString *) getColumnTextWithoutAutoIncrement;

@end
