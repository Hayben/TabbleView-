//
//  CLTreeView_LEVEL2_Cell.m
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "CLTreeView_LEVEL2_Cell.h"

@implementation CLTreeView_LEVEL2_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect
{
    int addX = _node.nodeLevel-1;
    addX = (addX<0?1:addX)*25; //根据节点所在的层次计算平移距离
    CGRect imgFrame = _headImg.frame;
    imgFrame.origin.x = 14 + addX;
    _headImg.frame = imgFrame;
    
    CGRect nameFrame = _name.frame;
    nameFrame.origin.x = 62 + addX;
    _name.frame = nameFrame;
    
    CGRect signtureFrame = _signture.frame;
    signtureFrame.origin.x = 62 + addX;
    _signture.frame = signtureFrame;
}

@end
