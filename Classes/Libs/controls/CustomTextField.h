//
//  customTextField.h
//  customTextField
//
//  Created by Mittal J. Banker on 12/05/16.
//  Copyright © 2016 digicorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CustomTextField : UITextField<UITextFieldDelegate>
{
    
}
@property(nonatomic)IBInspectable int minLength;
@property(nonatomic)IBInspectable int maxLength;
@property(nonatomic)IBInspectable UIColor *fillColor;
@property(assign)IBInspectable BOOL isAlphanumeric;
@end
