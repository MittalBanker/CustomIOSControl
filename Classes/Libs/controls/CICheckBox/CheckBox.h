//
//  CheckBox.h
//  Template
//
//  Created by Riddhi R. Makvana on 16/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBox : UIControl
{
    
}
-(void)setChecked:(BOOL)isChecked;
-(void)setEnabled:(BOOL)isEnabled;
-(void)setText:(NSString *)stringValue;

@property IBInspectable UIColor *checkColor;
@property IBInspectable UIColor *boxFillColor;
@property IBInspectable UIColor *boxBorderColor;
@property IBInspectable UIFont *labelFont;
@property IBInspectable UIColor *labelTextColor;

@property IBInspectable BOOL isEnabled;
@property IBInspectable BOOL isChecked;
@property IBInspectable BOOL showTextLabel;
@property (nonatomic, strong) IBInspectable  NSString *text;

@end
