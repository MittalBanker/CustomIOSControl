//
//  CustomTextView.m
//  Template
//
//  Created by Mittal J. Banker on 13/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView
int characterCount;
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:self.placeholder];
        [self setPlaceholderColor:[UIColor colorWithRed:244.00 green:244.00 blue:245.0 alpha:1.0] ];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
    }
    if (!self.placeholderColor) {
        [self setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        [self setPlaceholderColor:[UIColor colorWithRed:244.00 green:244.00 blue:245.0 alpha:1.0] ];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
  
    
    self.textAlignment = NSTextAlignmentLeft;
    _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
}
- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:self.placeholder];
        [self setPlaceholderColor: [UIColor colorWithRed:244.00 green:244.00 blue:245.0 alpha:1.0] ];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(UITextView *)textView
{
    characterCount = self.maxLength - (int)[[textView text] length];
    [self.characterCountLabel setText:[NSString stringWithFormat:@"%d", characterCount]];
    
    
    if([[self placeholder] length] == 0)
    {
        return;
    }
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
    // Check if the count is over the limit
    if(characterCount < 0) {
        // Change the color
        [self.characterCountLabel setTextColor:[UIColor redColor]];
    }
    else if(characterCount < 20) {
        // Change the color to yellow
        [self.characterCountLabel setTextColor:[UIColor orangeColor]];
    }
    else {
        // Set normal color
        [self.characterCountLabel setTextColor:[UIColor blackColor]];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([[textView text] length] - range.length + text.length > _maxLength) {
        return NO;
    }
     return TRUE;
}
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

-(void)setIsAddress:(BOOL)boolText{
    
    [self setPlaceholder:self.placeholder];
    
}
- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if (_placeHolderLabel == nil )
        {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(2,15,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = [UIColor colorWithRed:207.00/255.00 green:207.00/255.00 blue:212.00/255.00 alpha:1.0];
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            
            
            [self addSubview:_placeHolderLabel];
            
        }
        if(self.characterCountDisplayed==TRUE){
            if (_characterCountLabel == nil ){
                self.characterCountLabel = [[UILabel alloc] init];
                self.characterCountLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
                self.characterCountLabel.frame = CGRectMake(self.frame.size.width-70, 0, 63, 20);
                [self.characterCountLabel setTextAlignment:NSTextAlignmentRight];
                [self.characterCountLabel setFont:[UIFont boldSystemFontOfSize:13]];
                [self.characterCountLabel setBackgroundColor:[UIColor clearColor]];
                [self.characterCountLabel setText:[NSString stringWithFormat:@"%d", characterCount]];
                [self.characterCountLabel setTextColor:[UIColor grayColor]];
                _characterCountLabel.tag = 1000;
                [self addSubview:self.characterCountLabel];
            }
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [_placeHolderLabel setFrame:CGRectMake(_placeHolderLabel.frame.origin.x,_placeHolderLabel.frame.origin.y,self.bounds.size.width - 16,_placeHolderLabel.frame.size.height)];
        
        self.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
        [[self viewWithTag:1000] setAlpha:1];
    }
    
    [super drawRect:rect];
}

@end
