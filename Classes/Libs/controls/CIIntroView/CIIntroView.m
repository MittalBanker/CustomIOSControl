//
//  RMIntroView.m
//  RMIntroView
//
//  Created by Riddhi R. Makvana on 18/05/16.
//  Copyright © 2016 Digi-corp. All rights reserved.
//

#import "CIIntroView.h"
@implementation CIIntroView{
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
    }

    return  self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    [self initializeView];
    }
    return self;
}


#pragma mark - INIT METHOD

-(void)initializeView {
    margin = 10;
    CGFloat originWidth = self.frame.size.width;
    CGFloat originHeight = self.frame.size.height;
    arrHeightOfText = [[NSMutableArray alloc]init];
    arrAppIntroduction = [self readAppIntroduction];
    [self heightOfAllLabelText:arrAppIntroduction];

    //UIBUTTON INIT
    self.btnDone = [[UIButton alloc]initWithFrame:CGRectMake(0 + margin, (self.frame.size.height - 20)-margin*2, originWidth-margin*2, 30)];
    [self.btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [self.btnDone setTitleColor: [UIColor  whiteColor] forState:UIControlStateNormal];
    [self.btnDone setTitleColor: [UIColor whiteColor]forState:UIControlStateSelected];
    [self.btnDone setBackgroundColor:[UIColor colorWithRed:0.129 green:0.588 blue:0.953 alpha:1.000]];
    [self.btnDone addTarget:self action:@selector(btnDoneTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnDone];
    
    //UIPAGECONTROLLER INIT
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0 + margin,(self.btnDone.frame.origin.y - margin) - 20 ,originWidth - margin*2, 20)];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [pageControl setNumberOfPages: [arrAppIntroduction count]] ;
    [pageControl setCurrentPage: 0] ;
    [pageControl setDefersCurrentPageDisplay: YES] ;
    [pageControl addTarget:self action:@selector(pageChanged) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: pageControl];
    
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0+margin , (pageControl.frame.origin.y - margin - 60) + margin * 3, originWidth - margin*2 , self.maxHeight + 10 )];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:[UIColor grayColor]];
    [self.titleLabel setNumberOfLines:2];
    UIFont * boldFont = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    [self.titleLabel setFont:boldFont];

    [self addSubview:_titleLabel];
    
    CGFloat allheight = (self.titleLabel.frame.size.height + self.btnDone.frame.size.height + pageControl.frame.size.height);
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,originWidth,(originHeight - (allheight + margin*4)))];
    self.scrollView.delegate = self;
    [self.scrollView setPagingEnabled:TRUE];

    swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate =self;
    [self.titleLabel.superview addGestureRecognizer:swipeRight];
    
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    [self.titleLabel.superview addGestureRecognizer:swipeLeft];
    
    [self addSubview:self.scrollView];
    
    kNumberOfPages = 0;
    selectedPage = 0;
    [[self.scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    float width = self.frame.size.width;
    float height = self.scrollView.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(width*[[arrAppIntroduction allValues] count], height)];
    [self.scrollView setShowsVerticalScrollIndicator:false];
    
    int calculated_x = 0;
    int calculated_y = 0;
    UIImageView *image_appIntro;
    for (int i=0; i < [[arrAppIntroduction allValues] count]; i++) {
        image_appIntro = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[[arrAppIntroduction objectForKey:[NSString stringWithFormat:@"%d",i]]objectForKey:@"imageName"]]];
        [image_appIntro setTag:i];
        [image_appIntro setClipsToBounds:YES];
        [image_appIntro setFrame:CGRectMake(calculated_x, calculated_y, width, self.frame.size.height)];
        [self.scrollView addSubview:image_appIntro];
        calculated_x += width;
    }
    [self doanimation];
}

#pragma mark - BUTTON TAPPED
-(IBAction)btnDoneTapped:(id)sender{
    //
}

#pragma mark - READ DATA FROM INFOP.PLIST
-(NSMutableDictionary*)readAppIntroduction{
    NSMutableDictionary *ar = [NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CIIntroDetail" ofType:@"plist"]];
    return ar;
}

#pragma mark - CALCULATE UILABLE TEXT HEIGHT
-(void)heightOfAllLabelText : (NSMutableDictionary*)textLable{
    
    for (int i=0; i<=textLable.count; i++) {
     
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[[textLable objectForKey:[NSString stringWithFormat:@"%d",i]]objectForKey:@"title"]] attributes:nil];
        
        NSAttributedString *attributedText = message;
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){300, MAXFLOAT}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];//you need to specify the some width, height will be calculated
        CGFloat requiredHeight = rect.size.height;
        [arrHeightOfText addObject:[NSNumber numberWithFloat:requiredHeight]];

    }
    NSNumber * max = [arrHeightOfText valueForKeyPath:@"@max.intValue"];
    float maxFloat = [max floatValue];
    self.maxHeight = maxFloat;
}

#pragma mark - CUSTOM METHODS

-(void)doanimation{
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.titleLabel setText:[[arrAppIntroduction objectForKey:[NSString stringWithFormat:@"%d",selectedPage]]objectForKey:@"title"]];
        self.titleLabel.alpha = 1;
    }];
}

-(NSString*)newLineToString:(NSString*)str
{
    NSString *string = @"";
    NSArray *chunks = [str componentsSeparatedByString: @"\\n"];
    
    for(id str in chunks){
        if([string isEqualToString:@""]){
            string = [NSString stringWithFormat:@"%@",str];
        }else{
            string = [NSString stringWithFormat:@"%@\n%@",string,str];
        }
    }
    return string;
}

-(void)scrollThroughtimer{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * selectedPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - SCROLLVIEW DELEGATES METHODS

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    float fractionalPage = self.scrollView.contentOffset.x / pageWidth ;
    NSInteger nearestNumber = lround(fractionalPage) ;
    if (pageControl.currentPage != nearestNumber)
    {
        pageControl.currentPage = nearestNumber ;
        selectedPage = (int)pageControl.currentPage;
        // if we are dragging, we want to update the page control directly during the drag
        if (self.scrollView.dragging)
            [pageControl updateCurrentPageDisplay] ;

        self.titleLabel.alpha = 0;
        [self doanimation];
        
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    // if we are animating (triggered by clicking on the page control), we update the page control
    [pageControl updateCurrentPageDisplay] ;
}

#pragma mark - PAGE CONTROLL CHANGED EVENT METHODS

- (void)pageChanged {
    
    int pageNumber = pageControl.currentPage;
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width*pageNumber;
    frame.origin.y=0;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - swipe Gesture ActionMethod
-(void)swipeToRight:(UISwipeGestureRecognizer*)gesture
{
    if(selectedPage!=0){
        selectedPage = selectedPage-1;
        [self performSelector:@selector(scrollThroughtimer) withObject:self afterDelay:0.1];
    }
    
}

-(void)swipeToLeft:(UISwipeGestureRecognizer*)gesture
{
    if(selectedPage!=3){
        selectedPage = selectedPage+1;
        [self performSelector:@selector(scrollThroughtimer) withObject:self afterDelay:0.1];
    }
}


@end
