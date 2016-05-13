//
//  Constants.h
//  Template
//
//  Created by Kevin B. Adesara on 1/27/16.
//  Copyright © 2016 Digicorp. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define DOCUMENTS_FOLDER [NSTemporaryDirectory() stringByAppendingPathComponent:@"/myTmp/"]
#define DB_NAME @"voicetation"
#define DEBUG_MODE NO
#define TABLE_COUNTRY @"countries"
#define TABLE_FILTER_CATEGORY @"post_filter_categories"
#define TABLE_FILTER_SUBCATEGORY @"post_filter_sub_categories"

//#define APP_DELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define APP_UTILITY (Utility *)[Utility sharedUtility]

#define APP_API_URL @"https://www.google.co.in/"

#endif /* Constants_h */
