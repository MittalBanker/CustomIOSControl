//
//  RMIntroView.h
//  RMIntroView
//
//  Created by Riddhi R. Makvana on 18/05/16.
//  Copyright © 2016 Digi-corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CIIntroView : UIView <UIScrollViewDelegate , UIGestureRecognizerDelegate>
{
    UISwipeGestureRecognizer *swipeRight;
    UISwipeGestureRecognizer *swipeLeft;
    int selectedPage;
    int kNumberOfPages;
    NSMutableDictionary *arrAppIntroduction;
    NSMutableArray *arrHeightOfText;
    IBOutlet  UIPageControl *pageControl;
    int margin;
   
}
@property (nonatomic) CGFloat maxHeight;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *vwSubScrollView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIButton *btnDone;
@property (nonatomic) BOOL showTitleLabel;



@end
