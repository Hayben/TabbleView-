//
//  CLTreeView_LEVEL2_Cell.h
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBTreeViewNode.h"
@interface CLTreeView_LEVEL2_Cell : UITableViewCell
@property (retain,strong,nonatomic) GHBTreeViewNode *node;//data
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *signture;

@end
