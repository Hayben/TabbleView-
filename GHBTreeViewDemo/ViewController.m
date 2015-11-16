//
//  ViewController.m
//  GHBTreeViewDemo
//
//  Created by 123 on 15/11/12.
//  Copyright © 2015年 haibin. All rights reserved.
//

#import "ViewController.h"
#import "GHBTree.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *dataArray;//保存全部数据
@property (nonatomic,strong) NSArray *displayArray;//保存要显示在界面上的数据的数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTestData];
    [self reloadDataForDisplayArray];
    _myTableView.tableFooterView = [UIView new];
}
- (void)loadDataForTreeViewCell:(UITableViewCell *)cell with:(GHBTreeViewNode *)node{
    if (node.nodeType == 0) {
        CLTreeView_LEVEL0_Model *nodeData = node.nodeData;
        ((GHBTreeView_LEVEL0_Cell *)cell).name.text = nodeData.name;
        if (nodeData.headImgPath != nil) {
            //本地图片
            ((GHBTreeView_LEVEL0_Cell *)cell).imageView.image = [UIImage imageNamed:nodeData.headImgPath];
        }else if (nodeData.headImgUrl !=nil){
            ((GHBTreeView_LEVEL0_Cell *)cell).imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]];
        }
    }
    else if (node.nodeType == 1){
        CLTreeView_LEVEL1_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL1_Cell *)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL1_Cell *)cell).sonCount.text = nodeData.sonCnt;
    }else{
        CLTreeView_LEVEL2_Model *nodeData = node.nodeData;
        ((CLTreeView_LEVEL2_Cell *)cell).name.text = nodeData.name;
        ((CLTreeView_LEVEL2_Cell *)cell).signture.text = nodeData.signture;
        if(nodeData.headImgPath != nil){
            //本地图片
            [((CLTreeView_LEVEL2_Cell*)cell).headImg setImage:[UIImage imageNamed:nodeData.headImgPath]];
        }
        if (nodeData.headImgUrl != nil) {
            //加载图片，这里是同步操作。建议使用SDWebImage异步加载图片
            ((CLTreeView_LEVEL2_Cell *)cell).imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"level0cell";
    static NSString *indentifier1 = @"level1cell";
    static NSString *indentifier2 = @"level2cell";
    
    GHBTreeViewNode *node = [_displayArray objectAtIndex:indexPath.row];
    if (node.nodeType == 0) {//类型为0的cell
        GHBTreeView_LEVEL0_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];//重新给cell装载数据
        [cell setNeedsDisplay];//重新描绘cell
        return cell;
    }else if (node.nodeType == 1){//类型为1的cell
        CLTreeView_LEVEL1_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier1];
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }else{//类型为2的cell
        CLTreeView_LEVEL2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier2];
        cell.node = node;
        [self loadDataForTreeViewCell:cell with:node];
        [cell setNeedsDisplay];
        return cell;
    }
}
/*---------------------------------------
 修改cell的状态(关闭或打开)
 --------------------------------------- */
- (void)reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt = 0;
    for (GHBTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if (cnt == row) {
            node.isExpanded = !node.isExpanded;
        }
        ++cnt;
        if (node.isExpanded) {
            for (GHBTreeViewNode *node2 in node.sonNodes) {
                [tmp addObject:node2];
                if (cnt == row) {
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if (node2.isExpanded) {
                    for (GHBTreeViewNode *node3 in node2.sonNodes) {
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}

/*---------------------------------------
 处理cell选中事件，需要自定义的部分
 --------------------------------------- */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GHBTreeViewNode *node = _displayArray[indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];
    if (node.nodeType == 2) {
        //处理子节点选中，此处自己定义
    }else{
        GHBTreeView_LEVEL0_Cell *cell = (GHBTreeView_LEVEL0_Cell *)[tableView cellForRowAtIndexPath:indexPath];
        if (cell.node.isExpanded) {
            [self rotateArrow:cell with:M_PI_2];
        }else{
            [self rotateArrow:cell with:0];
        }
        
    }
}
/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(GHBTreeView_LEVEL0_Cell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.arrowView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}
- (void)addTestData{
    GHBTreeViewNode *node0 = [[GHBTreeViewNode alloc]init];
    node0.nodeLevel = 0;
    node0.nodeType = 0;
    node0.sonNodes = nil;
    node0.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp0 = [[CLTreeView_LEVEL0_Model alloc]init];
    tmp0.name = @"收藏";
    tmp0.headImgPath = @"contacts_collect.png";
    tmp0.headImgUrl = nil;
    node0.nodeData = tmp0;
    
    GHBTreeViewNode *node1 = [[GHBTreeViewNode alloc]init];
    node1.nodeLevel = 0;
    node1.nodeType = 0;
    node1.sonNodes = nil;
    node1.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp1 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp1.name = @"软件技术";
    tmp1.headImgPath = @"contacts_major.png";
    tmp1.headImgUrl = nil;
    node1.nodeData = tmp1;
    
    GHBTreeViewNode *node2 = [[GHBTreeViewNode alloc]init];
    node2.nodeLevel = 0;
    node2.nodeType = 0;
    node2.sonNodes = nil;
    node2.isExpanded = FALSE;
    CLTreeView_LEVEL0_Model *tmp2 =[[CLTreeView_LEVEL0_Model alloc]init];
    tmp2.name = @"信息工程";
    tmp2.headImgPath = @"contacts_major.png";
    tmp2.headImgUrl = nil;
    node2.nodeData = tmp2;
    
    GHBTreeViewNode *node3 = [[GHBTreeViewNode alloc]init];
    node3.nodeLevel = 1;
    node3.nodeType = 1;
    node3.sonNodes = nil;
    node3.isExpanded = FALSE;
    CLTreeView_LEVEL1_Model *tmp3 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp3.name = @"软件技术1班";
    tmp3.sonCnt = @"3";
    node3.nodeData = tmp3;
    
    GHBTreeViewNode *node4 = [[GHBTreeViewNode alloc]init];
    node4.nodeLevel = 1;
    node4.nodeType = 1;
    node4.sonNodes = nil;
    node4.isExpanded = FALSE;
    CLTreeView_LEVEL1_Model *tmp4 =[[CLTreeView_LEVEL1_Model alloc]init];
    tmp4.name = @"软件技术2班";
    tmp4.sonCnt = @"1";
    node4.nodeData = tmp4;
    
    GHBTreeViewNode *node5 = [[GHBTreeViewNode alloc]init];
    node5.nodeLevel = 2;
    node5.nodeType = 2;
    node5.sonNodes = nil;
    node5.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp5 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp5.name = @"flywarrior";
    tmp5.signture = @"老是失眠怎么办啊";
    tmp5.headImgPath = @"head1.jpg";
    tmp5.headImgUrl = nil;
    node5.nodeData = tmp5;
    
    GHBTreeViewNode *node6 = [[GHBTreeViewNode alloc]init];
    node6.nodeLevel = 2;
    node6.nodeType = 2;
    node6.sonNodes = nil;
    node6.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp6 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp6.name = @"flywarrior2";
    tmp6.signture = @"用头用力撞下键盘就好了。";
    tmp6.headImgPath = @"head2.jpg";
    tmp6.headImgUrl = nil;
    node6.nodeData = tmp6;
    
    GHBTreeViewNode *node7 = [[GHBTreeViewNode alloc]init];
    node7.nodeLevel = 2;
    node7.nodeType = 2;
    node7.sonNodes = nil;
    node7.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp7 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp7.name = @"李四";
    tmp7.signture = @"说的好有道理，我竟无言以对。";
    tmp7.headImgPath = @"head3.jpg";
    tmp7.headImgUrl = nil;
    node7.nodeData = tmp7;
    
    GHBTreeViewNode *node8 = [[GHBTreeViewNode alloc]init];
    node8.nodeLevel = 2;
    node8.nodeType = 2;
    node8.sonNodes = nil;
    node8.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp8 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp8.name = @"田七";
    tmp8.signture = @"肚子好饿啊。。。";
    tmp8.headImgPath = @"head4.jpg";
    tmp8.headImgUrl = nil;
    node8.nodeData = tmp8;
    
    GHBTreeViewNode *node9 = [[GHBTreeViewNode alloc]init];
    node9.nodeLevel = 2;
    node9.nodeType = 2;
    node9.sonNodes = nil;
    node9.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp9 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp9.name = @"王大锤";
    tmp9.signture = @"走向人生巅峰！";
    tmp9.headImgPath = @"head5.jpg";
    tmp9.headImgUrl = nil;
    node9.nodeData = tmp9;
    
    GHBTreeViewNode *node10 = [[GHBTreeViewNode alloc]init];
    node10.nodeLevel = 2;
    node10.nodeType = 2;
    node10.sonNodes = nil;
    node10.isExpanded = FALSE;
    CLTreeView_LEVEL2_Model *tmp10 =[[CLTreeView_LEVEL2_Model alloc]init];
    tmp10.name = @"孔连顺";
    tmp10.signture = @"锤锤。。。";
    tmp10.headImgPath = @"head6.jpg";
    tmp10.headImgUrl = nil;
    node10.nodeData = tmp10;
    
    node0.sonNodes = [NSMutableArray arrayWithObjects:node8,node9, nil];
    node1.sonNodes = [NSMutableArray arrayWithObjects:node3,node4, nil];
    node3.sonNodes = [NSMutableArray arrayWithObjects:node5,node7,node10, nil];
    node4.sonNodes = [NSMutableArray arrayWithObjects:node6, nil];
    _dataArray = [NSMutableArray arrayWithObjects:node0,node1,node2, nil];
    
}
/*---------------------------------------
 初始化将要显示的cell的数据
 --------------------------------------- */
- (void)reloadDataForDisplayArray{
    NSMutableArray *tmp = [NSMutableArray new];
    for (GHBTreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if (node.isExpanded) {
            for (GHBTreeViewNode *node2 in node.sonNodes ) {
                [tmp addObject:node2];
                if (node2.isExpanded) {
                    for (GHBTreeViewNode *node3 in node2.sonNodes) {
                        [tmp addObject:node3];
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

@end
