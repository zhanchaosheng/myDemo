//
//  DpTableViewCell.m
//  myDmeo
//
//  Created by Eddy on 15-6-14.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "DpTableViewCell.h"

@implementation DpTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.praiseNum = 0;
    self.praiseLabel.text = [NSString stringWithFormat:@"%d",self.praiseNum];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageViewTap:)];
    self.praiseImageView.userInteractionEnabled = YES;
    [self.praiseImageView addGestureRecognizer:singleTap];
    
    for (int i = 0; i<self.shareImage.count; i++) {
        UITapGestureRecognizer *tapGRgn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareImageClick:)];
        UIImageView *imageView = [self.shareImage objectAtIndex:i];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tapGRgn];
    }
}

- (void)shareImageClick:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = [gestureRecognizer view];
    int index = (int)(view.tag - 20);
    if ([self.delegate respondsToSelector:@selector(PhotoClicked:)])
    {
        [self.delegate PhotoClicked:index];
    }
}

- (void)handleImageViewTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIView *view = [gestureRecognizer view];
    if (view.tag == 110) {
        self.praiseNum++;
        self.praiseLabel.text = [NSString stringWithFormat:@"%d",self.praiseNum];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //加载cell对应的xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DpTableViewCell" owner:self options:nil];
        //加载失败返回
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        //xib中的view不属于UITableViewCell类，则返回
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UITableViewCell class]])
        {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

@end
