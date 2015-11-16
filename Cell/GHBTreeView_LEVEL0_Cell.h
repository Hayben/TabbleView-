//
//  GHBTreeView_LEVEL0_Cell.h
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHBTreeViewNode.h"
@interface GHBTreeView_LEVEL0_Cell : UITableViewCell

@property (retain,strong,nonatomic) GHBTreeViewNode *node;//data
 
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
