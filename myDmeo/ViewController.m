//
//  ViewController.m
//  myDmeo
//
//  Created by Eddy on 15-6-11.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "ViewController.h"
#import "MyDIYTableViewCell.h"
#import "ImgLookViewController.h"
#import "LocationViewController.h"

@interface ViewController ()
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@property (strong,nonatomic) NSMutableDictionary *exp;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIPageControl *pagecontrol;
@property (strong,nonatomic) NSTimer *myTimer;
@end

@implementation ViewController

#pragma mark - scrollView
//tableView头部添加分页显示图片
- (void)addPageView
{
    CGRect rectView = self.view.frame;
    CGFloat width = rectView.size.width;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(width*3, 200);
    self.scrollView.delegate = self;
    float x = 0;
    for (int i=1; i<=3; i++)
    {
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(x, 0, width, 200)];
        NSString *imagename=[NSString stringWithFormat:@"0%d.jpg",i];
        imageview.image=[UIImage imageNamed:imagename];
        imageview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapImageClick:)];
        [imageview addGestureRecognizer:singleTap];
        [self.scrollView addSubview:imageview];
        x += width;
    }
    self.tableView.tableHeaderView = self.scrollView;
    
    self.pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake(165, 180, 60, 20)];
    self.pagecontrol.numberOfPages = 3;//总页数
    self.pagecontrol.currentPage = 0;//当前页
    //设置pageControl中点的间距为16
    //self.pagecontrol.bounds = CGRectMake(0, 0, 16*(self.pagecontrol.numberOfPages-1), 16);
    //self.pagecontrol.backgroundColor = [UIColor grayColor];
    //[self.pagecontrol.layer setCornerRadius:4];//设置圆角
    [self.pagecontrol addTarget:self
                         action:@selector(pageControlChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.pagecontrol];
    
    //设置定时器，使图片自动滚动
    self.myTimer=[NSTimer scheduledTimerWithTimeInterval:2.0f
                                                  target:self
                                                selector:@selector(scrollToNextPage:)
                                                userInfo:nil
                                                 repeats:YES];
}
- (void)handleTapImageClick:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"TapImageClick!");
}
-(void)scrollToNextPage:(id)sender
{
    int pageNum = (int)self.pagecontrol.currentPage;
    pageNum++;
    if (pageNum == self.pagecontrol.numberOfPages)
    {
        pageNum = 0;
    }
    CGRect rect = self.scrollView.frame;
    rect.origin.x = pageNum * rect.size.width;
    [self.scrollView scrollRectToVisible:rect animated:YES];
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
        int page= self.scrollView.contentOffset.x/viewSize.width;
        self.pagecontrol.currentPage = page;
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    [self.myTimer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    self.myTimer=[NSTimer scheduledTimerWithTimeInterval:2.0f
//                                                  target:self
//                                                selector:@selector(scrollToNextPage:)
//                                                userInfo:nil
//                                                 repeats:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
#pragma mark

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSString *strData = [NSString stringWithFormat:@"it-%zi",i];
        [self.dataArray addObject:strData];
    }
    self.exp = [NSMutableDictionary dictionary];
    //设置tableview的Rect，解决导航条隐藏留下的空隙
    CGRect rect = CGRectMake(self.view.frame.origin.x, -20, self.view.frame.size.width, self.view.frame.size.height+20);
    self.tableView = [[UITableView alloc] initWithFrame:rect
                                                  style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    //UIView *bgView = [[UIView alloc] init];
    //bgView.frame = CGRectMake(0, 0, 375, 100);
    //bgView.backgroundColor = [UIColor yellowColor];
    //[UIColor colorWithRed:209 green:216 blue:226 alpha:0]
    //self.tableView.backgroundView = bgView;
    //self.tableView.tableHeaderView = bgView;
    //self.tableView.tableFooterView = bgView;
    [self addPageView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[DpTableViewCell class]
           forCellReuseIdentifier:@"dpCellIndentifier"];
    
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    //隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    self.title = @"产品信息";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - dataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 11;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"--section---%zi",section);
    switch (section)
    {
        case 0:
        {
            return 0;
        }
        case 1:
        case 7:
        case 9:
        case 10:
        {
            return 1;
        }
        case 6:
        {
            return 2;
        }
        case 2:
        case 3:
        case 4:
        case 5:
        {
            NSString *indexsection = [NSString stringWithFormat:@"%zi",section];
            BOOL b = [[self.exp objectForKey:indexsection] boolValue];
            if ([self.exp objectForKey:indexsection] && b)
            {
                return self.dataArray.count;
            }
        }
        default:
        {
            
            break;
        }
    }
    
    return 0;
}
-(void)click:(UIButton *)btn
{
    NSString *indexSection = [NSString stringWithFormat:@"%zi",btn.tag];
    if ([self.exp objectForKey:indexSection]) {//如果有这个section
        
        BOOL b = [[self.exp objectForKey:indexSection] boolValue];
        [self.exp removeAllObjects];
        if(b){
            [ self.exp setObject:[NSNumber numberWithBool:NO] forKey:indexSection];
        }
        else {
            [ self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
        }
        
    }
    else{
        [self.exp removeAllObjects];
        [self.exp setObject:[NSNumber numberWithBool:YES] forKey:indexSection];
    }
    
    [self.tableView reloadData];
}
-(void)topViewBtnClick:(UIButton *)btn
{
    NSString *btnTiter;
    if (btn.tag == 11)
    {
        self.title = @"";
        ImgLookViewController *imgLookView = [[ImgLookViewController alloc] init];
        [self.navigationController pushViewController:imgLookView animated:YES];
    }
    else
    {
        if (btn.tag == 10) {
            btnTiter = @"点评";
        }
        else if(btn.tag == 12)
        {
            btnTiter = @"周边";
        }
        else
        {
            btnTiter = @"简介";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:btnTiter
                                                       delegate:nil
                                              cancelButtonTitle:@"yes,I do"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"--->section-->%zi---row-->%zi",indexPath.section,indexPath.row);
    UITableViewCell *cell = nil;
    if (indexPath.section >= 2 && indexPath.section <= 5)
    {
        static NSString *myDIYcellIdentify = @"myDIYTableIndentifier";
        cell = [tableView dequeueReusableCellWithIdentifier:myDIYcellIdentify];
        if (cell == nil)
        {
            cell = (MyDIYTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"MyDIYTableViewCell" owner:self options:nil][0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消选择状态
        }
    }
    else if (indexPath.section == 6)
    {
        DpTableViewCell *DpCell = [tableView dequeueReusableCellWithIdentifier:@"dpCellIndentifier"
                                               forIndexPath:indexPath];
        DpCell.delegate = self;
        cell = DpCell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        static NSString *cellIdentify = @"cell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:cellIdentify];
            cell.textLabel.numberOfLines = 0;//文本换行
            UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 10, 20, 20)];
            cellLabel.text = @"》";
            [cell.contentView addSubview:cellLabel];
        }
        if (indexPath.section == 1)
        {
            cell.imageView.image = [UIImage imageNamed:@"star"];
        }
        else
        {
            cell.imageView.image = nil;
        }
        if (indexPath.section == 10)
        {
            cell.textLabel.text = @"在线客服";
        }
        else if (indexPath.section == 9)
        {
            cell.textLabel.text = @"查看全部须知";
        }
        else if (indexPath.section == 7)
        {
            cell.textLabel.text = @"查看全部点评";
        }
        else if (indexPath.section == 1)
        {
            cell.textLabel.text = @"广州市天河区棠东东路御景创业园B座321";
        }
        else
        {
            cell.textLabel.text = @"TableViewCell";
        }
        
    }
    return cell;
}
#pragma mark - 代理方法
//头部
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *topView = [[UIView alloc] init];
        [topView setBackgroundColor:[UIColor yellowColor]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TopImg"]];
        CGRect b = self.view.bounds;
        CGFloat width = CGRectGetWidth(b);
        [imgView setFrame:CGRectMake(0, 0, width, 160)];
        [topView addSubview:imgView];
        CGFloat btnWidth = width/4;
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
        for (int i = 0; i < 4; i++) {
            NSString *imgname = [NSString stringWithFormat:@"btn%d",i];
            UIImage *img = [UIImage imageNamed:imgname];
            [array addObject:img];
        }
        for (int i = 0;i < 4; i++)
        {
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *strTitle = nil;
            btn1.tag = i+10;
            [btn1 setTitle:strTitle forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(topViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn1 setFrame:CGRectMake(i * btnWidth, 160, btnWidth, 55)];
            [btn1 setBackgroundColor:[UIColor whiteColor]];
            [btn1 setBackgroundImage:[array objectAtIndex:i]
                            forState:UIControlStateNormal];
            [topView addSubview:btn1];
        }
        return  topView;
    }
    if (section == 1)
    {
        UIView *firstView = [[UIView alloc] init];
        [firstView setBackgroundColor:[UIColor whiteColor]];
        
        CGRect rect = CGRectMake(30, 6, 90, 25);
        UIImageView *imgViewleft = [[UIImageView alloc] initWithFrame:rect];
        imgViewleft.image = [UIImage imageNamed:@"yesleft"];
        //UIImageView添加点击响应事件(点击手势响应处理)
        imgViewleft.tag = 100;
        imgViewleft.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [imgViewleft addGestureRecognizer:singleTap1];
        [firstView addSubview:imgViewleft];
        
        rect = CGRectMake(220, 6, 90, 26);
        UIImageView *imgViewright = [[UIImageView alloc] initWithFrame:rect];
        imgViewright.image = [UIImage imageNamed:@"yesright"];
        imgViewright.tag = 101;
        imgViewright.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        [imgViewright addGestureRecognizer:singleTap2];
        [firstView addSubview:imgViewright];
        return firstView;
    }
    if (section == 8)
    {
        UIView *view8 = [[UIView alloc] init];
        [view8 setBackgroundColor:[UIColor whiteColor]];
        CGFloat width = self.view.frame.size.width;
        CGRect rect = CGRectMake(0, 0, width, 55);
        UIImageView *imgViewxz = [[UIImageView alloc] initWithFrame:rect];
        imgViewxz.image = [UIImage imageNamed:@"xuzhi"];
        [view8 addSubview:imgViewxz];
        
        rect = CGRectMake(10, 55, width, 195);
        UITextView *textView = [[UITextView alloc] initWithFrame:rect];
        NSString *strtext = @"世界，你好\n开放时间：\n9：30 - 18：30\n取票地点：\n你好，世界\n......";
        textView.editable = NO;
        textView.selectable = NO;
        //设置字体和行间距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 10;//字体行间距
        NSDictionary * attributes = @{
                                      NSFontAttributeName:[UIFont fontWithName:@"Arial" size:18],
                                      NSParagraphStyleAttributeName:paragraphStyle};
        textView.attributedText = [[NSAttributedString alloc] initWithString:strtext attributes:attributes];

        [view8 addSubview:textView];
        return view8;
    }
    if (section == 6) {
        UIView *view6 = [[UIView alloc] init];
        [view6 setBackgroundColor:[UIColor yellowColor]];
        CGFloat width = self.view.frame.size.width;
        CGRect rect6 = CGRectMake(0, 0, width, 55);
        UIImageView *imgViewdp = [[UIImageView alloc] initWithFrame:rect6];
        imgViewdp.image = [UIImage imageNamed:@"dp"];
        [view6 addSubview:imgViewdp];
        return view6;
    }
    if (section == 7 || section == 9 || section == 10) {
        return nil;
    }
    if (section >= 2 && section <= 5)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn setTitle:nil forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [btn setBackgroundColor:[UIColor whiteColor]];
        
        NSString *indexSection = [NSString stringWithFormat:@"%zi",btn.tag];
        BOOL b = [[self.exp objectForKey:indexSection] boolValue];
        if(b){
            [btn setBackgroundImage:[UIImage imageNamed:@"btnS2"]
                           forState:UIControlStateNormal];
        }
        else {
            [btn setBackgroundImage:[UIImage imageNamed:@"btnS1"]
                           forState:UIControlStateNormal];
        }
        
        return btn;
    }
    
    UIView *defultView = [[UIView alloc] init];
    [defultView setBackgroundColor:[UIColor whiteColor]];
    return defultView;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *imageView = [gestureRecognizer view];
    NSArray *array = [NSArray arrayWithObjects:@"入园保证",@"快速入园", nil];
    int index = 0;
    if (imageView.tag == 100)
    {
        index = 0;
    }
    else if (imageView.tag == 101)
    {
        index = 1;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:[array objectAtIndex:index]
                                                   delegate:nil
                                          cancelButtonTitle:@"yes,I do"
                                          otherButtonTitles:nil];
    [alert show];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSLog(@"heightForHeaderInSection-->%zi",section);
    if (section == 0) {
        return 215;
    }
    if (section == 8) {
        return 250;
    }
    if (section == 6) {
        return 50;
    }
    if (section == 7 || section == 9 || section == 10) {
        return 0.1;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section >= 2 && section <= 4)
    {
        return 0.6;
    }
    if (section == 6 || section == 8) {
        return 0.1;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath--->seciont-%zi--row---%zi",indexPath.section,indexPath.row);
    if (indexPath.section == 1) {
        return 50;
    }
    if (indexPath.section >= 2 && indexPath.section <= 5) {
        return 75;
    }
    if (indexPath.section == 6) {
        return 230;
    }
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"__%@",indexPath);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 10)
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"在线客服"
                                                                 delegate:self
                                                        cancelButtonTitle:@"退出"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"国内用户",@"国外用户",nil];
        [actionSheet showInView:self.view];
    }
    else if(indexPath.section == 1 && indexPath.row == 0)
    {
        //地图位置定位
        self.title = @"";
        LocationViewController *locationViewCtrl = [[LocationViewController alloc] init];
        [self.navigationController pushViewController:locationViewCtrl animated:YES];
    }

}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}
#pragma mark

- (void)PhotoClicked:(int)index
{
    self.title = @"";
    photoViewController *photoView = [[photoViewController alloc] initWithIndex:index];
    [self.navigationController pushViewController:photoView animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}
@end
