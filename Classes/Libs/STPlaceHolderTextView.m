//
//  STPlaceHolderTextView.m
//  
//
//  Created by digicorp on 21/10/13.
//  Copyright (c) 2013 digicorp. All rights reserved.
//

#import "STPlaceHolderTextView.h"
#define ADDRESS @" Address"
@implementation STPlaceHolderTextView

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    if (!self.placeholderColor) {
        [self setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        [self setPlaceholderColor:[UIColor colorWithRed:244.00 green:244.00 blue:245.0 alpha:1.0] ];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
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

- (void)textChanged:(NSNotification *)notification
{
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
    }
    
    [super drawRect:rect];
}

@end
