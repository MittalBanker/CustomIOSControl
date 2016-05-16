//
//  CustomView.m
//  Template
//
//  Created by Riddhi R. Makvana on 13/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import "CustomView.h"
IB_DESIGNABLE
@implementation CustomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    return self;
}
-(void)drawRect:(CGRect)rect{
    self.layer.cornerRadius = _cornerRadius;
    [[self layer]setBorderWidth:_borderWidth];
    [[self layer] setBorderColor:_borderColor.CGColor];
    
    
    [self.layer setMasksToBounds:YES];
}

@end
