//
//  Utility.h
//  Template
//
//  Created by Himanshu H. Padia on 01/04/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#
@interface Utility : NSObject <MBProgressHUDDelegate>

@property (nonatomic, strong) Reachability *internetReachability;
@property (nonatomic, strong) Reachability *hostReachability;

+(Utility *)sharedUtility;

/**
 to get Device Udid call
 @return Device UDID in string format
 */
-(NSString*)getDeviceUdid;

/**
 Displays a simple HUD window containing a progress indicator.
 @param msg Proper string message
 @param presentView Present view (eg. self.view)
 */
-(void)showProgressHUD:(NSString*)msg view:(UIView *)presentView;
/**
 Hide the MBProgressHUD
 */
-(void)hideProgressHUD;

/**
 to get Path of the passed PList file name
 @param plistName pass the PList file name in string
 @return return PList file path
 */
-(NSString *)getPathOfPList:(NSString *)plistName;

/**
 write content/data to PList file
 @param value pass the PList content/data
 @param plistFileName pass the PList file name in string
 */
-(void)writeToPList:(id)value plistFileName:(NSString *)plistName;

/**
 to read the content/data of the passed Plist file name
 @param plistName pass the plist file name in string
 @return return PList content/data
 */
-(NSArray *)readFromPList:(NSString *)plistName;

/**
 to set device default volume
 @param value pass the volume value in float
 */
-(void)setVolume:(float)value;

/**
 to get current volume value
 @return current volume value
 */
-(float)getGlobalVolume;

/**
 to check internet connection
 @return Internet avaiablility
 */
-(BOOL)isConnectedToInternet;

/**
 to convert in Abbreviation Number (eg. 10K, 20M, 30B)
 @param num pass the number in int
 @return return Abbreviated Number in string format
 */
-(NSString *)abbreviateNumber:(int)num;

/**
 to convert time to UTC time
 @param strDate pass the date in string format
 @return return UTC date in string format
 */
-(NSString*)convertToUTCTime:(NSString*)strDate;
- (void)proximityChanged:(NSNotification *)notification;
- (void)volumeChanged:(NSNotification *)notification;
-(void)reachabilityChanged:(NSNotification *)note ;
@end
