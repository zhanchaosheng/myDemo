//
//  ImgLookViewController.m
//  myDmeo
//
//  Created by Eddy on 15-6-12.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "ImgLookViewController.h"
#import "myCollectionViewCell.h"

@interface ImgLookViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) int imgNum;

@end

@implementation ImgLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = NO;
    //控制当前控制器对应的导航条显示的内容
    self.navigationItem.title = @"图片展示";
    
    //修改返回按钮显示的内容
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回一" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    self.imgNum = 7;
    
    //注册collectionViewCell类
    [self.collectionView registerClass:[myCollectionViewCell class]
            forCellWithReuseIdentifier:@"myCollectionViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0)
    {
        self.imgNum = 7;
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        self.imgNum = 4;
    }
    else
    {
        self.imgNum = 5;
    }
    [self.collectionView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgNum;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCollectionViewCell *myCell = (myCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionViewCell" forIndexPath:indexPath];

//    NSString *imgName = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
//    myCell.ImageView.image = [UIImage imageNamed:imgName];
    return myCell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *msg = [NSString stringWithFormat:@"Select Item At %ld ",(long)indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"yes,I do"
                                          otherButtonTitles:nil];
    [alert show];
    return;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - UICollectViewDelegeteLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(98, 98);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

@end
