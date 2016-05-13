//
//  APIRequester.h
//
//  Created by Kevin on 01/27/2016.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// Configuration keys
extern NSString *const ApiBaseUrl;                          // REQUIRED: base api url (e.g., http://localhost:3000/api )
extern NSString *const ApiAFHttpRequestOperationManager;    // REQUIRED: AFHttpRequestOperationManager object
extern NSString *const ApiDefaultAFHttpRequestOperationManager; // default AFHttpRequestOperationManager object with JSON serializer and 60sec request timeout configuration

typedef void(^ApiSuccess)(id response);
typedef void(^ApiError)(NSError* error);

@interface Api : NSObject

/**
 Configure api with base url and AFHttpRequestOperationManager
 @param settings - Dictionary with basic settings
*/
+ (void)configure:(NSDictionary *)settings;
+ (instancetype)sharedInstance;

- (void)cancelAllRequest;
- (void)post:(NSString*)api parameter:(NSDictionary*)para success:(ApiSuccess)success error:(ApiError)error;

@end
