# Api
Api class is a helper class to consume the web-services.

## How to use?

1. Configure

  ```objective-c
  - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
      ...
      [Api configure:@{
        ApiBaseUrl: @"http://192.168.0.91:3000",
        ApiAFHttpRequestOperationManager: ApiDefaultAFHttpRequestOperationManager
      }];
      ...
      return YES;
  }
  ```
2. Use it

  ```objective-c
  [[Api sharedInstance] post:@"/api/login"
      parameter:@{@"username":@"user123", @"password":@"pass123"}
        success:^(id response) {
          NSLog(@"%@", response);
        }
        error:^(NSError *error) {
          NSLog(@"%@", error);
        }];
  ```

## Configuration Parameters

Parameter                          | Description                                              | Required/Optional
---------------------------------- | -------------------------------------------------------- | -----------------
`ApiBaseUrl`                       | Base url to call the api                                 | Required
`ApiAFHttpRequestOperationManager` | Request operation manager object of AFNetworking library | Required

## Dependency

* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [ObjectiveSugar](https://github.com/supermarin/ObjectiveSugar)
