//
//  CustomTextView.h
//  Template
//
//  Created by Mittal J. Banker on 13/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import <Foundation/Foundation.h>

IB_DESIGNABLE
@interface CustomTextView : UITextView
{
    
}
@property(nonatomic)IBInspectable int maxLength;
@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
-(void)textChanged:(NSNotification*)notification;
@property (nonatomic, retain) UILabel *placeHolderLabel;
@property(assign)IBInspectable BOOL characterCountDisplayed;
@property (nonatomic, retain) UILabel *characterCountLabel;
@end
