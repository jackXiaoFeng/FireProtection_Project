//
//  PageImageScrollView.m
//  Uzai
//
//  Created by UZAI on 14-8-1.
//
//

#import "PageImageScrollView.h"
#import "UIImageView+WebCache.h"
// #import "ChoicenessModel.h"
@interface PageImageScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray * imageArrayList;
@end
@implementation PageImageScrollView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initWithImageUIShow
{
    [self setUserInteractionEnabled:YES];
    self.scrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    

    _pageControll = [[DDPageControl alloc] init];
    [_pageControll setCenter: CGPointMake(self.center.x, self.bounds.size.height-10.0f)] ;
    [_pageControll addTarget: self action: @selector(pageControlPageChanged:) forControlEvents: UIControlEventValueChanged] ;
    [_pageControll setDefersCurrentPageDisplay: YES] ;
    [_pageControll setType: DDPageControlTypeOnFullOffEmpty] ;
    [_pageControll setOnColor: [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1]] ;
    [_pageControll setOffColor: [UIColor UIColorFromRGB:COLOR_APP_MAIN alpha:1]] ;
    [_pageControll setIndicatorDiameter: 5] ;
    [_pageControll setIndicatorSpace: 5] ;
    [self addSubview: _pageControll] ;
}
#pragma mark -
#pragma mark Required Methods
- (void)reloadUzaiPageScrollView :(NSArray *)imageArray
{
    [self initWithImageUIShow];
    
    for (UIView *subview in _scrollView.subviews) {
        if (subview.tag == 404) {
            [subview removeFromSuperview];
        }
    }
    if ([imageArray count] == 0) {
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
        _scrollView.scrollEnabled = NO;
        _scrollView.pagingEnabled = NO;
        
        _pageControll.numberOfPages = 0;
        _pageControll.currentPage = 0;
    }
    else {
        
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        
        CGFloat width = _scrollView.frame.size.width;
        CGFloat height = _scrollView.frame.size.height;
        
        //ChoicenessListsAdvesModel * firstModel =[imageArray lastObject];
        UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0, width, height)];
        firstImageView.clipsToBounds = YES;
        //firstImageView.image = DEF_IMAGENAME("");
        //[firstImageView sd_setImageWithURL:[NSURL URLWithString:firstModel.advesImgs] placeholderImage:[UIImage imageNamed:@"icon_home-page_-loading-figure_h"]];
        [firstImageView setBackgroundColor:[UIColor whiteColor]];
        firstImageView.tag = 404;
        [_scrollView addSubview:firstImageView];
        
        for (int i = 0; i < imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * (i + 1), 0, width, height)];

            //ChoicenessListsAdvesModel * imageIndex =[imageArray objectAtIndex:i];
            //[imageView sd_setImageWithURL:[NSURL URLWithString:imageIndex.advesImgs] placeholderImage:[UIImage imageNamed:@"icon_home-page_-loading-figure_h"]];
            imageView.clipsToBounds = YES;
            [imageView setBackgroundColor:[UIColor whiteColor]];
            imageView.tag = 404;
            [_scrollView addSubview:imageView];
        }
        
        //ChoicenessListsAdvesModel * lastModel=[imageArray objectAtIndex:0];
        UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * (imageArray.count + 1), 0, width, height)];
        //[lastImageView sd_setImageWithURL:[NSURL URLWithString:lastModel.advesImgs] placeholderImage:[UIImage imageNamed:@"icon_home-page_-loading-figure_h"]];
        [lastImageView setBackgroundColor:[UIColor whiteColor]];
        
        lastImageView.tag = 404;
        lastImageView.clipsToBounds = YES;
        [_scrollView addSubview:lastImageView];
        
        [_scrollView setContentSize:CGSizeMake(width * (imageArray.count + 2), height)];
        [_scrollView scrollRectToVisible:CGRectMake(width, 0.0, width, height) animated:YES];
        
        _pageControll.numberOfPages = imageArray.count;
        _pageControll.currentPage = 0;
        
        if (_timer != nil) {
            [_timer invalidate];
            _timer = nil;
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollViewScrollToNextPage:) userInfo:nil repeats:YES];
    }
    
    UITapGestureRecognizer *aTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    aTap.numberOfTapsRequired=1;
    [_scrollView addGestureRecognizer:aTap];
    
    _imageArrayList = imageArray;
}

- (void)pageControlPageChanged:(id)sender
{
    DDPageControl *thePageControl = (DDPageControl *)sender ;
    // we need to scroll to the new index
    [_scrollView setContentOffset: CGPointMake(_scrollView.bounds.size.width * thePageControl.currentPage, _scrollView.contentOffset.y) animated: YES] ;
}

- (void)scrollViewScrollToNextPage:(NSTimer *)timer
{
    [_pageControll updateCurrentPageDisplay];
    
    NSUInteger currentPage = _pageControll.currentPage;
    CGSize size = _scrollView.frame.size;
    CGRect rect = CGRectMake((currentPage + 2) * size.width, 0, size.width, size.height);
    [_scrollView scrollRectToVisible:rect animated:YES];
    
    currentPage ++;
    if (currentPage == [_imageArrayList count]) {
        CGRect lastRect = CGRectMake(size.width * ([_imageArrayList count] + 1), 0.0, size.width, size.height);
        _pageControll.currentPage = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_scrollView scrollRectToVisible:lastRect animated:YES];
        });
        return;
    }
    _pageControll.currentPage = currentPage;
}
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_pageControll updateCurrentPageDisplay];
    
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_pageControll updateCurrentPageDisplay];
    
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(scrollViewScrollToNextPage:) userInfo:nil repeats:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_pageControll updateCurrentPageDisplay];
    
    CGFloat width = scrollView.frame.size.width;
    NSUInteger currentPage = floor((scrollView.contentOffset.x - width / 2) / width) + 1;
    if (currentPage == 0) {
        _pageControll.currentPage = 0;
    }
    else if (currentPage == [_imageArrayList count] + 1) {
        if (scrollView.contentOffset.x >= ([_imageArrayList count] + 1) * width - 1) {
            [scrollView scrollRectToVisible:CGRectMake(width, 0.0, width, scrollView.frame.size.height) animated:NO];
        }
        return;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pageControll updateCurrentPageDisplay];
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat heigth = scrollView.frame.size.height;
    
    NSUInteger currentPage = floor((scrollView.contentOffset.x - width / 2) / width) + 1;
    
    if (currentPage == 0) {
        [scrollView scrollRectToVisible:CGRectMake(width * [_imageArrayList count], 0.0, width, heigth) animated:NO];
        _pageControll.currentPage = [_imageArrayList count] - 1;
        
        return;
    }
    else if (currentPage == [_imageArrayList count] + 1) {
        [scrollView scrollRectToVisible:CGRectMake(width, 0.0, width, heigth) animated:NO];
        _pageControll.currentPage = 0;
        
        return;
    }
    
    _pageControll.currentPage = currentPage - 1;
}
-(void)tapImage:(UITapGestureRecognizer *)aTap
{ 
    if (_pageControll.currentPage >= 0) {
        
        //得到被单击的视图
//        ChoicenessListsAdvesModel *  indexAdvModel = _imageArrayList[_pageControll.currentPage];
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:DEF_ChoiceNotFiction object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:indexAdvModel, @"Model",nil]];
    }
}


@end
