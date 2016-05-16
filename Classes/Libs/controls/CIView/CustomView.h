//
//  CustomView.h
//  Template
//
//  Created by Riddhi R. Makvana on 13/05/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface CustomView : UIView

@property(assign)IBInspectable CGFloat cornerRadius;
@property(assign)IBInspectable int borderWidth;
@property (nonatomic,retain)IBInspectable UIColor *borderColor;


@end
