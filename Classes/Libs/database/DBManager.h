//
//  DBManager.h
//  Cinescape
//
//  Created by digicorp on 28/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FMDB.h"
//#import "sqlite3.h"

#define documentsDirectory_Statement NSString *documentsDirectory; \
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
documentsDirectory = [paths objectAtIndex:0];

typedef enum {
    OprationInToLiveTable          = 0,
    OprationInToLocalTable         = 1
} OprationType;


typedef void (^CompletionHandler)(NSMutableArray *result);
typedef void (^QueryCompletionHandler)(BOOL success);;

@interface DBManager : NSObject {
	NSString *dbPath;
	//sqlite3 *database;
}
@property(nonatomic,retain) NSString *dbPath;

+(DBManager*)sharedManager;
/*
-(NSArray*)getCountries;
-(NSArray*)getFilterCategories;
-(NSArray*)getFilterSubCategories:(NSString*)strCatID;
-(NSArray*)getFilterData:(NSString*)subCategoriesId;
-(void)deleteAllTables;
-(void)createTablesFromDefination:(NSDictionary*)dbSkleton andHandler:(QueryCompletionHandler)handler;
-(void)createTable:(NSString*)tableName andFields:(NSDictionary*)fields andCompletionHandler:(QueryCompletionHandler)handler;
-(void)insertTableFromType:(NSDictionary*)dbSkleton andOprationType:(OprationType)opration  andHandler:(QueryCompletionHandler)handler;
*/
@end
