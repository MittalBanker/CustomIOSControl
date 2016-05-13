//
//  customTextField.m
//  customTextField
//
//  Created by Mittal J. Banker on 12/05/16.
//  Copyright © 2016 digicorp. All rights reserved.
//

#import "CustomTextField.h"
int maxlength;
@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder]) {
        // Do something
        
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet] ;

    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    if (newLength > maxlength) {
        if([string length] > maxlength){
            textField.text = [string substringToIndex:maxlength];
        }
        return NO;
    }
    if(self.isAlphanumeric){
        return ([string rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);

    }
    return true;
}

- (void)drawRect:(CGRect)rect {
    self.backgroundColor = self.fillColor;
    maxlength = self.maxLength;
}

-(BOOL)isAlphaNumericOnly:(NSString *)input
{
    NSString *alphaNum = @"[a-zA-Z0-9]+";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaNum];
    
    return [regexTest evaluateWithObject:input];
}
@end
