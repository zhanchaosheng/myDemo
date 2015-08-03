//
//  myCollectionViewCell.m
//  myDmeo
//
//  Created by Eddy on 15-6-12.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "myCollectionViewCell.h"

@implementation myCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //加载cell对应的xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"myCollectionViewCell" owner:self options:nil];
        //加载失败返回
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        //xib中的view不属于UICollectionViewCell类，则返回
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}
@end
