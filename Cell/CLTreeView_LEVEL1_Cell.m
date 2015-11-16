//
//  CLTreeView_LEVEL1_Cell.m
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "CLTreeView_LEVEL1_Cell.h"

@implementation CLTreeView_LEVEL1_Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重新描绘cell
- (void)drawRect:(CGRect)rect
{
    int addX = _node.nodeLevel*25; //根据节点所在的层次计算平移距离
    CGRect imgFrame = _arrowView.frame;
    imgFrame.origin.x = 14 + addX;
    _arrowView.frame = imgFrame;
    
    CGRect nameFrame = _name.frame;
    nameFrame.origin.x = 40 + addX;
    _name.frame = nameFrame;
}


@end
