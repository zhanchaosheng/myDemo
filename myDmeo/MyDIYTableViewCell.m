//
//  MyDIYTableViewCell.m
//  myDmeo
//
//  Created by Eddy on 15-6-11.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "MyDIYTableViewCell.h"

@implementation MyDIYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClick:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"预定"
                                                   delegate:nil
                                          cancelButtonTitle:@"是的，知道了"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
