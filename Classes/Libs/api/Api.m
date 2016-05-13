//
//  APIRequester.m
//
//  Created by Kevin on 01/27/2016
//

#import "Api.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

NSString *const ApiBaseUrl = @"api_baseurl";
NSString *const ApiAFHttpRequestOperationManager = @"api_afhttprequestoperationmanager";
NSString *const ApiDefaultAFHttpRequestOperationManager = @"api_defaultafhttprequestoperationmanager";

static NSString *const ERR_API_CONFIG = @"Api configuration error";

static AFHTTPRequestOperationManager *defaultManager = nil;
static NSUInteger defaultRequestTimeoutInSec = 30;

static AFHTTPRequestOperationManager *manager = nil;
static NSString *baseUrl = nil;
static BOOL configured = false;

BOOL debug = false;

@implementation Api

+ (void) initialize {
	if (self == [NSObject class]) {
		// Once-only initializion
	}
	
	// Initialization for this class and any subclasses
	if(defaultManager == nil) {
		defaultManager = [AFHTTPRequestOperationManager manager];
		defaultManager.requestSerializer = [AFJSONRequestSerializer serializer];
		defaultManager.requestSerializer.timeoutInterval = defaultRequestTimeoutInSec;
	}
}

/**
 Configure Api shared instance
 */
+ (void)configure:(NSDictionary *)settings {
	
	if(configured) {
		[NSException raise:ERR_API_CONFIG format:@"Api is already configured"];
		return;
	}
	
	// setup base url
	if([settings hasKey:ApiBaseUrl] == false || settings[ApiAFHttpRequestOperationManager] == nil) {
		[NSException raise:ERR_API_CONFIG format:@"ApiBaseUrl is required"];
		return;
	} else if([self validateUrl:settings[ApiBaseUrl]] == false) {
		[NSException raise:ERR_API_CONFIG format:@"ApiBaseUrl is invalid"];
		return;
	}
	baseUrl = settings[ApiBaseUrl];
	
	// setup AFHttpRequestOperationManager
	if([settings hasKey:ApiAFHttpRequestOperationManager] == false || settings[ApiAFHttpRequestOperationManager] == nil) {
		[NSException raise:ERR_API_CONFIG format:@"ApiAFHttpRequestOperationManager is required"];
		return;
	} else if(![[settings[ApiAFHttpRequestOperationManager] description] isEqualToString:ApiDefaultAFHttpRequestOperationManager] && [settings[ApiAFHttpRequestOperationManager] isKindOfClass:[AFHTTPRequestOperationManager class]] == false) {
		[NSException raise:ERR_API_CONFIG format:@"AFHttpRequestOperationManager object is invalid"];
		return;
	}
	
	if([[settings[ApiAFHttpRequestOperationManager] description] isEqualToString:ApiDefaultAFHttpRequestOperationManager]) {
		manager = defaultManager;
	} else {
		manager = settings[ApiAFHttpRequestOperationManager];
	}
	
	
	configured = true;
}

+(instancetype)sharedInstance {
	if(configured == false) {
		[NSException raise:ERR_API_CONFIG format:@"Please configure api using [Api configure:] method."];
		return nil;
	}
	
	static dispatch_once_t pred;
	static Api *instance = nil;
	dispatch_once(&pred, ^{
		instance = [[self alloc] init];
	});
	return instance;
}

/**
 Post api request
 */
-(void)post:(NSString*)api parameter:(NSDictionary*)para success:(ApiSuccess)success error:(ApiError)error
{
	NSString *baseAPIURL = baseUrl;
	NSString *apiURL = [NSString stringWithFormat:@"%@%@", baseAPIURL, api];
	if(debug) NSLog(@"Request: %@", para);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[manager POST:apiURL
	   parameters:para
		  success:^(AFHTTPRequestOperation *operation, id responseObject) {
			  if(debug) NSLog(@"Response: %@", responseObject);
			  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
																 options:0
																   error:nil];
					
			  if (! jsonData) {
				  //NSLog(@"Got an error: %@", error);
			  } else {
				  // NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
				  //  NSLog(jsonString);
			  }
			  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			  if(success)
				  success(responseObject);
		  }
		  failure:^(AFHTTPRequestOperation *operation, NSError *err) {
			  if(debug) NSLog(@"Error: %@", err);
			  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			  if(error)
				  error(err);
		  }];
}

-(void)get:(NSString*)api parameter:(NSDictionary*)para success:(ApiSuccess)success error:(ApiError)error {
	NSString *baseAPIURL = baseUrl;
	NSString *apiURL = [NSString stringWithFormat:@"%@%@", baseAPIURL, api];
	if(debug) NSLog(@"Request: %@", para);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	[manager GET:apiURL
	  parameters:para
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
			 if(debug) NSLog(@"Response: %@", responseObject);
			 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
																options:0
																  error:nil];
			 
			 if (! jsonData) {
				 //NSLog(@"Got an error: %@", error);
			 } else {
				 // NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
				 //  NSLog(jsonString);
			 }
			 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			 if(success)
				 success(responseObject);
		 }
		 failure:^(AFHTTPRequestOperation *operation, NSError *err) {
			 if(debug) NSLog(@"Error: %@", err);
			 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
			 if(error)
				 error(err);
		 }];
}

-(void)cancelAllRequest
{
	[manager.operationQueue cancelAllOperations];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"Api: Url(%@), RequestManager(%@)", baseUrl, [manager description]];
}

# pragma mark - Utility methods

+ (BOOL) validateUrl: (NSString *) candidate {
	//    NSString *urlRegEx =
	//    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
	//    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
	//    return [urlTest evaluateWithObject:candidate];
	
	NSURL *candidateURL = [NSURL URLWithString:candidate];
	// WARNING > "test" is an URL according to RFCs, being just a path
	// so you still should check scheme and all other NSURL attributes you need
	if (candidateURL && candidateURL.scheme && candidateURL.host) {
		// candidate is a well-formed url with:
		//  - a scheme (like http://)
		//  - a host (like stackoverflow.com)
		return true;
	}
	return false;
}

@end
