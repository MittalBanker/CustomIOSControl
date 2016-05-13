//
//  DBManager.m
//  Cinescape
//
//  Created by digicorp on 28/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedObj;

@implementation DBManager

@synthesize dbPath;


+(void)initialize{
    sharedObj=[[DBManager alloc] init];
}

+(DBManager*)sharedManager{
    return sharedObj;
}

-(id)init{
    if(self=[super init]) {
        /*documentsDirectory_Statement;
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",DOCUMENTS_FOLDER,DB_NAME]];
        if (fileExists) {
            documentsDirectory=[DOCUMENTS_FOLDER stringByAppendingPathComponent:@"voicetation.sqlite"];
            if(DEBUG_MODE) NSLog(@"%@",documentsDirectory);
        }else{
            documentsDirectory=[documentsDirectory stringByAppendingPathComponent:@"voicetation.sqlite"];
        }
        self.dbPath=documentsDirectory;
        NSFileManager *fm=[NSFileManager defaultManager];
        if(![fm fileExistsAtPath:self.dbPath]) {
            NSString *localDB=[[NSBundle mainBundle] pathForResource:DB_NAME ofType:@"sqlite"];
            NSError *err;
            if(![fm copyItemAtPath:localDB toPath:self.dbPath error:&err]){
                //NSLog(@"Error in creating DB -> %@",err);
            }
        }
        if(sqlite3_open([self.dbPath UTF8String], &database) !=SQLITE_OK){
            //NSLog(@"error while opening database.");
        } else {
            sqlite3_close(database);
        }*/
    }
    return self;
}

/*-(void)deleteAllTables{
    NSArray *arrForTableName = [[self fetchTableNames] copy];
    for (NSString *tableName in arrForTableName) {
        [self dropData:tableName];
    }
}

-(NSMutableArray *)fetchTableNames
{
    sqlite3_stmt* statement = nil;
    NSString *query = @"SELECT name FROM sqlite_master WHERE type='table'";
    const char *drop_stmt = [query UTF8String];
    int retVal = 0;
    if(sqlite3_open([self.dbPath UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, drop_stmt, -1, &statement, NULL)==SQLITE_OK){
            retVal = sqlite3_prepare_v2(database,
                                        [query UTF8String],
                                        -1,
                                        &statement,
                                        NULL);
        }
    }
    NSMutableArray *selectedRecords = [NSMutableArray array];
    if ( retVal == (int) SQLITE_OK )
    {
        while(sqlite3_step(statement) == SQLITE_ROW )
        {
            NSString *value = [NSString stringWithCString:(const char *)sqlite3_column_text(statement, 0)
                                                 encoding:NSUTF8StringEncoding];
            [selectedRecords addObject:value];
        }
    }
    
    sqlite3_clear_bindings(statement);
    sqlite3_finalize(statement);
    
    return selectedRecords;
}

- (void) dropData:(NSString *)tableName
{
    sqlite3_stmt *statement = nil;
    NSString *sql_stmt = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
    const char *drop_stmt = [sql_stmt UTF8String];
    if(sqlite3_open([self.dbPath UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, drop_stmt, -1, &statement, NULL)==SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"Dropped table %@",tableName);
            } else
            {
                NSLog(@"Didn't Drop table %@",tableName);
            }
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

-(NSArray*)getCountries{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    [ar removeAllObjects];
    NSString *strQuery=[NSString stringWithFormat:@"SELECT id,status,name,phonecode FROM %@ where status=1",TABLE_COUNTRY];
    const char *query=[strQuery UTF8String];
    sqlite3_stmt *compiledStmt;
    if(sqlite3_open([self.dbPath UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, query, -1, &compiledStmt, NULL)==SQLITE_OK){
            while (sqlite3_step(compiledStmt)==SQLITE_ROW) {
                [ar addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:\
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 0)],@"id",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 1)],@"status",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 2)],@"name",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 3)],@"phonecode",
                               nil]];
            }
        } else {
            if (DEBUG_MODE) {
                NSLog(@"Invalid query getCategory");
            }
        }
    }else {
        if (DEBUG_MODE) {
            NSLog(@"error while opening database.");
        }
    }
    NSArray *arToReturn=([ar count]>0)?[NSArray arrayWithArray:ar]:nil;
    ar=nil;
    return arToReturn;
}

-(NSArray*)getFilterData:(NSString*)subCategoriesId{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    [ar removeAllObjects];
    NSString *strQuery=[NSString stringWithFormat:@"select pfs.id,pfs.name,pfs.category_id,pfc.name as categoryname from  post_filter_categories pfc INNER JOIN  post_filter_sub_categories pfs ON pfs.category_id =pfc.id  where pfs.id IN(%@) ORDER BY categoryname asc",subCategoriesId];
    const char *query=[strQuery UTF8String];
    sqlite3_stmt *compiledStmt;
    if(sqlite3_open([self.dbPath UTF8String], &database)==SQLITE_OK) {
        if(sqlite3_prepare_v2(database, query, -1, &compiledStmt, NULL)==SQLITE_OK){
            while (sqlite3_step(compiledStmt)==SQLITE_ROW) {
                [ar addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:\
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 0)],@"id",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 1)],@"name",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 2)],@"category_id",
                               [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStmt, 3)],@"categoryname",
                               nil]];
            }
        } else {
            if (DEBUG_MODE) {
                NSLog(@"Invalid query getFilterSubCategories");
            }
        }
    }else {
        if (DEBUG_MODE) {
            NSLog(@"error while opening database.");
        }
    }
    NSArray *arToReturn=([ar count]>0)?[NSArray arrayWithArray:ar]:nil;
    ar=nil;
    return arToReturn;
    
}

#pragma mark -

-(void)createTablesFromDefination:(NSDictionary*)dbSkleton andHandler:(QueryCompletionHandler)handler{
    
    for (NSString *tblName in dbSkleton) {
        if ([[dbSkleton valueForKey:tblName] count] > 0) {
            [self createTable:tblName andFields:[dbSkleton valueForKey:tblName] andCompletionHandler:^(BOOL success) {
                NSLog(@"Table Created: %@",tblName);
            }];
        }
    }
    handler(TRUE);
}

-(void)createTable:(NSString*)tableName andFields:(NSDictionary*)fields andCompletionHandler:(QueryCompletionHandler)handler{
    NSMutableString *query =[[NSMutableString alloc]init];
    for (NSString *column in fields) {
        [query appendString:[NSString stringWithFormat:@"%@ ",column]];
        [query appendString:[self getAttributeFromColumnName:column]];
        [query appendString:[NSString stringWithFormat:@","]];
    }
    [query deleteCharactersInRange:NSMakeRange([query length]-1, 1)]; // remove last comma from query
    
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@);",tableName, query];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    [queue inDatabase:^(FMDatabase *db) {
        
        BOOL worked = [db executeUpdate:sql];
        if (worked) {
            if(DEBUG_MODE){
                NSLog(@"%@",sql);
                NSLog(@"%@",tableName);
            }
        }
        handler(worked);
    }];
    [queue close];
}


#pragma mark  Insert Table Statement

-(void)insertTableFromType:(NSDictionary*)dbSkleton andOprationType:(OprationType)opration  andHandler:(QueryCompletionHandler)handler{
    for (NSString *tblName in dbSkleton) {
        if ([[dbSkleton valueForKey:tblName] count] > 0) {
            [self insertOrReplaceInBatchIntoTable:tblName andRecords:[dbSkleton valueForKey:tblName] withCompletionHandler:^(BOOL success) {
                
                if (DEBUG_MODE) {
                    NSLog(@"Batch Insert Completed for table:%@",tblName);
                }
            }];
        }
    }
    handler(TRUE);
}

-(void)insertOrReplaceInBatchIntoTable:(NSString*)tableName andRecords:(NSArray*)records withCompletionHandler:(QueryCompletionHandler)handler
{
    if ([records count] > 0) {
        NSMutableString *query =[[NSMutableString alloc]init];
        NSMutableString *queryValues =[[NSMutableString alloc]init];
        
        NSDictionary *columnDictinary = [records objectAtIndex:0];
        for (NSString *column in columnDictinary) {
            [query appendString:[NSString stringWithFormat:@"%@",column]];
            [query appendString:[NSString stringWithFormat:@","]];
            [queryValues appendString:[NSString stringWithFormat:@":%@",column]];
            [queryValues appendString:[NSString stringWithFormat:@","]];
        }
        
        // remove last comma from query
        
        if (query.length > 0) {
            [query deleteCharactersInRange:NSMakeRange([query length]-1, 1)];
        }
        if (queryValues.length > 0) {
            [queryValues deleteCharactersInRange:NSMakeRange([queryValues length]-1, 1)];
        }
        
        
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)",tableName,query,queryValues];
        
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        [queue inDatabase:^(FMDatabase *db) {
            for (int index = 0; index < records.count; index++) {
                NSDictionary *recordDictinary = [records objectAtIndex:index];
                
                [db executeUpdate:insertQuery withParameterDictionary:recordDictinary];
            }
            
        }];
        [queue close];
    }
}

-(NSString*)getAttributeFromColumnName:(NSString*)columnName{
    NSString *attribute = @"VARCHAR";
    if ([columnName isEqualToString:@"id"]) {
        attribute = @"INTEGER PRIMARY KEY ASC";
    }
    return attribute;
}

//==============================================================================================
- (void)dealloc {
    
    if(dbPath!=nil) {  dbPath=nil; }
    
}*/
@end