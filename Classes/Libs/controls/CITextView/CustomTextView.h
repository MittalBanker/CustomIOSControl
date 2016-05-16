//
//  CustomTextView.h
//  Template
//
//  Created by Mittal J. Banker on 13/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import <Foundation/Foundation.h>

IB_DESIGNABLE
@interface CustomTextView : UITextView <UITextViewDelegate>
{
    
}
@property(assign)IBInspectable int borderWidth;
@property(nonatomic)IBInspectable int maxLength;

@property(assign)IBInspectable CGFloat cornerRadius;

@property (nonatomic,retain)IBInspectable UIColor *borderColor;
@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) UILabel *characterCountLabel;

@property(assign)IBInspectable BOOL characterCountDisplayed;
-(void)textChanged:(NSNotification*)notification;
@end
