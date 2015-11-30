//
//  LcDataTable.h
//  
//
//  Created by Tony Day on 10/5/15.
//
//

#import <Foundation/Foundation.h>

@interface LcDataColumn : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic) BOOL  isPk;
@property (nonatomic) BOOL isAutoIncrement;

-(id) initWithName: (NSString *) aName setAsPk: (BOOL)isPkField setAsAutoIncrement: (BOOL)autoIncrement;
-(id) initWithName: (NSString *) aName;

//+(NSMutableArray *) loadFromArray: (NSArray *) arrField pkField: (NSArray *)pkFields autoIncrementField: (NSArray *)autoIncrementFields;
+(NSMutableArray *) loadFromArray: (NSArray *)arrField pkField: (NSString *)aPkField autoIncrementField: (NSString *)aAutoIncrementField;

@end
