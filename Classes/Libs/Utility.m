//
//  Utility.m
//  Template
//
//  Created by Himanshu H. Padia on 01/04/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import "Utility.h"

@implementation Utility
{
    MBProgressHUD *HUD;
    BOOL isAPIServerAvaiable;
    BOOL isInternetConnectionAvaiable;
    NSDateFormatter *commonDateFormatter;
    NSDate *myDate;
}

+(Utility *)sharedUtility {
    static dispatch_once_t pred = 0;
    __strong static Utility * _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)initAudioDeclatation {
    // Audio
    [AVAudioSession sharedInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioRouteChangeListenerCallback:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:nil];
    UIDevice *device = [UIDevice currentDevice];
    device.proximityMonitoringEnabled = YES;
    if (device.proximityMonitoringEnabled == YES)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityChanged:) name:@"UIDeviceProximityStateDidChangeNotification" object:device];
    } else {
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)                                                      name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
}

- (void)initReachabilityDeclaration {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    isInternetConnectionAvaiable = NO;
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    NSURL *url = [NSURL URLWithString:APP_API_URL];
    NSString* remoteHostName = [url host];
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self initAudioDeclatation];
        [self initReachabilityDeclaration];
        
        // NSDateFormatter Variable
        commonDateFormatter = [[NSDateFormatter alloc] init];
        [commonDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [commonDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    return self;
}

#pragma mark - get udid number

-(NSString*)getDeviceUdid {
    NSString *uniqueId = nil;
    NSUUID *vendorId = [[UIDevice currentDevice] identifierForVendor];
    uniqueId = [vendorId UUIDString];
    return  uniqueId;
}

#pragma mark - MBProgressHUD show/Hide

-(void)showProgressHUD:(NSString*)msg view:(UIView *)presentView {
    if(HUD!=nil) {
        [HUD removeFromSuperview];
        HUD=nil;
    }
    HUD = [[MBProgressHUD alloc] initWithView:presentView];
    HUD.labelText = msg;
    HUD.labelFont = [UIFont fontWithName:@"Helvetica Neue" size:10.0];
    HUD.delegate = self;
    [presentView addSubview:HUD];
    [HUD show:YES];
}

-(void)hideProgressHUD {
    [HUD hide:YES];
    if(HUD!=nil) {
        [HUD removeFromSuperview];
        HUD=nil;
    }
}

#pragma mark - PList Read/Write Function

-(NSString *)getPathOfPList:(NSString *)plistName {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFileName = [NSString stringWithFormat:@"%@.plist",plistName];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:plistFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath: plistPath]) {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        [fileManager copyItemAtPath:bundle toPath: plistPath error:&error];
    }
    return plistPath;
}

-(void)writeToPList:(id)value plistFileName:(NSString *)plistName {
    NSString *plistPath = [self getPathOfPList:plistName];
    if (plistPath == nil) {
        return;
    }
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    NSMutableArray *newArr  = nil;
    newArr = [[self readFromPList:plistName] mutableCopy];
    if (![newArr containsObject:value]) {
        [newArr addObject:value];
        [data setObject:newArr forKey:@"hearedPosts"];
        [data writeToFile: plistPath atomically:YES];
    }
}

-(NSArray *)readFromPList:(NSString *)plistName {
    NSString *plistPath = [self getPathOfPList:plistName];
    if (plistPath == nil) {
        return nil;
    }
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: plistPath];
    NSArray *arr = nil;
    arr = [[savedStock objectForKey:@"hearedPosts"] copy];
    return arr;
}

#pragma mark - sound and volume functions

// If the user pulls out he headphone jack, stop playing.
-(void)audioRouteChangeListenerCallback:(NSNotification*)notification
{
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            if(DEBUG_MODE)
            {
                NSLog(@"AVAudioSessionRouteChangeReasonNewDeviceAvailable");
                NSLog(@"Headphone/Line plugged in");
            }
            // Write required condition
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:
            if(DEBUG_MODE){
                NSLog(@"AVAudioSessionRouteChangeReasonOldDeviceUnavailable");
                NSLog(@"Headphone/Line was pulled. Stopping player....");
            }
            // Write required condition
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            if(DEBUG_MODE) NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            // Write required condition
            break;
            
        case AVAudioSessionRouteChangeReasonOverride:
            // Write required condition
            break;
    }
}

- (void)volumeChanged:(NSNotification *)notification {
    float volume = [[[notification userInfo]
                     objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    if(DEBUG_MODE) NSLog(@"%f",volume);
    [self setVolume:volume];
    // Do stuff with volume
}

-(void)setVolume:(float)value {
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:@"volume"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(float)getGlobalVolume {
    return  [[NSUserDefaults standardUserDefaults] floatForKey:@"volume"] ;
}

#pragma mark - proximity method

- (void)proximityChanged:(NSNotification *)notification {
    if(DEBUG_MODE) NSLog(@"proximity changed called");
    UIDevice *device = [notification object];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL success;
    success = [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    if(device.proximityState == 1){
        if(DEBUG_MODE) NSLog(@"bool %s", success ? "true" : "false");
        [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
        [audioSession setActive:YES error:nil];
    } else {
        if(DEBUG_MODE)  NSLog(@"bool %s", success ? "true" : "false");
        [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
        [audioSession setActive:YES error:nil];
    }
}

#pragma mark - Reachablity method

-(BOOL)isConnectedToInternet {
    return isAPIServerAvaiable;
}

-(void)reachabilityChanged:(NSNotification *)note {
    if(DEBUG_MODE) NSLog(@"reachabilityChanged");
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

-(void)updateInterfaceWithReachability:(Reachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    if (reachability == self.hostReachability) {
        if (netStatus == NotReachable) {
            isAPIServerAvaiable = NO;
        } else {
            isAPIServerAvaiable = YES;
        }
    } else if (reachability == self.internetReachability) {
        if (netStatus == NotReachable) {
            isInternetConnectionAvaiable = NO;
        } else {
            isInternetConnectionAvaiable = YES;
        }
    }
}

#pragma mark - Convert Large Number To Small

-(NSString *)abbreviateNumber:(int)num {
    NSString *abbrevNum;
    float number = (float)num;
    //Prevent numbers smaller than 1000 to return NULL
    if (num >= 1000) {
        NSArray *abbrev = @[@"K", @"M", @"B"];
        for (int i = (int)(abbrev.count - 1); i >= 0; i--) {
            // Convert array index to "1000", "1000000", etc
            int size = pow(10,(i+1)*3);
            if(size <= number) {
                // Removed the round and dec to make sure small numbers are included like: 1.1K instead of 1K
                number = number/size;
                NSString *numberString = [self floatToString:number];
                // Add the letter for the abbreviation
                abbrevNum = [NSString stringWithFormat:@"%@%@", numberString, [abbrev objectAtIndex:i]];
            }
        }
    } else {
        
        // Numbers like: 999 returns 999 instead of NULL
        abbrevNum = [NSString stringWithFormat:@"%d", (int)number];
    }
    return abbrevNum;
}

// CONVERT NUMBER FROM FLOAT TO STRING
- (NSString *)floatToString:(float)val {
    NSString *ret = [NSString stringWithFormat:@"%.1f", val];
    unichar c = [ret characterAtIndex:[ret length] - 1];
    while (c == 48) { // 0
        ret = [ret substringToIndex:[ret length] - 1];
        c = [ret characterAtIndex:[ret length] - 1];
        //After finding the "." we know that everything left is the decimal number, so get a substring excluding the "."
        if(c == 46) { // .
            ret = [ret substringToIndex:[ret length] - 1];
        }
    }
    return ret;
}

#pragma mark - Time converter method

// CONVERT TIME TO UTC
-(NSString*)convertToUTCTime:(NSString*)strDate {
    //create the formatter for parsing
    NSDate *currentDate = [NSDate date];
    myDate = [commonDateFormatter dateFromString: strDate];
    NSTimeInterval distanceBetweenDates = [currentDate timeIntervalSinceDate:myDate];
    return [self stringFromTimeInterval:distanceBetweenDates];
}

// CALCULATE TIME INTERVAL LIKE NOW, ..DAYS AGO
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    if (hours > 24) {
        NSInteger days = hours/24;
        if (days > 30) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEE d MMM YY, h:mm a"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            NSString *daydate = [dateFormatter stringFromDate:myDate];
            return daydate;
        } else {
            return [NSString stringWithFormat:@" %2ldd",(long)days];
        }
    } else {
        if (hours == 0 && minutes < 1) {
            return [NSString stringWithFormat:@"Now"];
        } else if (hours == 0 && minutes < 60) {
            return [NSString stringWithFormat:@"%2ldm ",(long)minutes];
        } else {
            return [NSString stringWithFormat:@" %2ldh",(long)hours];
        }
    }
}

@end
