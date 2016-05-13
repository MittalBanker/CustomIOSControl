//
//  STPlaceHolderTextView.h
//  
//
//  Created by digicorp on 21/10/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;
@property (nonatomic)BOOL isAddress;
-(void)textChanged:(NSNotification*)notification;
@property (nonatomic, retain) UILabel *placeHolderLabel;
-(void)refreshUI;
@end
