//
//  DpTableViewCell.h
//  myDmeo
//
//  Created by Eddy on 15-6-14.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DpTableViewDelegate<NSObject>
- (void)PhotoClicked:(int)index;
@end

@interface DpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImageView;//等级
@property (weak, nonatomic) IBOutlet UIImageView *praiseImageView;//点赞
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;//手机号码
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;//日期
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;//点赞数量
@property (weak, nonatomic) IBOutlet UITextView *textView;//留言
@property (nonatomic) int praiseNum;//点赞个数
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *shareImage;
@property (strong,nonatomic) id<DpTableViewDelegate> delegate;

@end
