//
//  photoViewController.m
//  myDmeo
//
//  Created by Eddy on 15-6-16.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController ()
@property (strong,nonatomic) UIPageControl *pagecontrol;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (nonatomic) NSInteger ImgIndex;
@end

@implementation photoViewController

- (id)initWithIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        self.ImgIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = NO;
    //控制当前控制器对应的导航条显示的内容
    self.navigationItem.title = @"图片浏览";
    CGRect rectScreen = [UIScreen mainScreen].applicationFrame;
    CGRect rect = CGRectMake(0, 64, rectScreen.size.width, rectScreen.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.contentSize = CGSizeMake(rect.size.width*3, self.scrollView.contentSize.height);
    //如果scrollView的父视图被导航条控制则必须设置以下属性
    self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    float x = 0;
    for (int i=1; i<=3; i++)
    {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, rect.size.width, rect.size.height)];
        NSString *imagename = [NSString stringWithFormat:@"1%d.jpg",i];
        imageview.image = [UIImage imageNamed:imagename];
//        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFit;//图片自适应
        [self.scrollView addSubview:imageview];
        x += rect.size.width;
    }
    self.scrollView.contentOffset = CGPointMake(rect.size.width*self.ImgIndex,self.scrollView.contentOffset.y);
    [self.view addSubview:self.scrollView];
    
    self.pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(floor(rectScreen.size.width/2)-55, rect.origin.y+20, 60, 20)];
    self.pagecontrol.numberOfPages = 3;//总页数
    self.pagecontrol.currentPage = self.ImgIndex;//当前页
    [self.pagecontrol addTarget:self
                         action:@selector(pageControlChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pagecontrol];
    
}

- (void)pageControlChange:(UIPageControl *)sender
{
    int pageNum = (int)self.pagecontrol.currentPage;
    CGSize viewSize = self.scrollView.frame.size;
    [self.scrollView setContentOffset:CGPointMake(pageNum*viewSize.width, 0)];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {
        CGSize viewSize = self.scrollView.frame.size;
        int page = self.scrollView.contentOffset.x/viewSize.width;
        self.pagecontrol.currentPage = page;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
