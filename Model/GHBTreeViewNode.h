//
//  GHBTreeViewNode.h
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHBTreeViewNode : NSObject

@property (nonatomic) int nodeLevel;//节点所在层次
@property (nonatomic) int nodeType;//节点类型
@property (nonatomic) id nodeData;//节点数据
@property (nonatomic) BOOL isExpanded;//节点是否展开
@property (nonatomic,strong) NSMutableArray *sonNodes;//子节点

@end
