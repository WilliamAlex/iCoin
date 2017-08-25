//
//  ABLeftMenuViewController.m
//  icoins
//
//  Created by Alex Williams on 2017/8/19.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABLeftMenuViewController.h"

@interface ABLeftMenuViewController ()<UITableViewDataSource, UITableViewDelegate>
{

    UITableView *walletTableView;   // 定义tableView
    NSMutableArray *dataArray;      // 数据源数组
}
    
@end

@implementation ABLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, navHight-1, ABScreenWidth, 1.0)];
    sepView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sepView];
    
    // 创建tabelView
    walletTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHight, ABScreenWidth, ABScreenHeight) style:UITableViewStylePlain];
    walletTableView.delegate = self;
    walletTableView.dataSource = self;
    walletTableView.tableFooterView = [UIView new];
    [self.view addSubview:walletTableView];
    
    // 绑定数据源
    [self loadDataMoadel];
}
    
- (void)loadDataMoadel {

    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    // Todo: 加载数据模型(后台请求的数据)
    NSArray *groupNames = @[@[@"张无忌",@"狄云",@"狄青",@"李慕白",@"张飞"],@[@"李宗宪",@"张学良",@"嬴政",@"大禹"],@[@"陆小凤",@"大大大",@"李云龙",@"李自成"],@[@"魏征",@"白展堂",@"花无缺",@"王刚"]];
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        
        ABCoinGroup *group1 = [[ABCoinGroup alloc] initWithItem:name];
        [dataArray addObject:group1];
    }
}
    
#pragma mark UITableViewDataSource
//这是tabview创建多少组的回调
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return dataArray.count;
}
//这是每个组有多少联系人的回调
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ABCoinGroup *group = dataArray[section];
    return group.isFolded? 0: group.size;
}
    
    //将tabview的cell与数据模型绑定起来
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    //将模型里的数据赋值给cell
    ABCoinGroup *group = dataArray[indexPath.section];
    NSArray *arr=group.items;
    cell.textLabel.text = arr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark UITableViewDelegate
//对hearderView进行编辑
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //首先创建一个大的view，nameview
    UIView *nameView=[[UIView alloc]init];
    
    //将分组的名字nameLabel添加到nameview上
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, self.view.frame.size.width, 40)];
    [nameView addSubview:nameLabel];
    nameView.layer.borderWidth=0.2;
    nameView.layer.borderColor=[UIColor grayColor].CGColor;
    NSArray *nameArray=@[@"BTC钱包",@"ETH钱包",@"ETC钱包",@"LTC钱包"];
    nameLabel.text=nameArray[section];
    
    //添加一个button用于响应点击事件（展开还是收起）
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, self.view.frame.size.width, 40);
    [nameView addSubview:button];
    button.tag = 200 + section;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //将显示展开还是收起的状态通过三角符号显示出来
    UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    fuhao.tag=section;
    [nameView addSubview:fuhao];
    
    //根据模型里面的展开还是收起变换图片
    ABCoinGroup *group = dataArray[section];
    if (group.isFolded==YES) {
        fuhao.image=[UIImage imageNamed:@"right_arrow"];
    }else{
        fuhao.image=[UIImage imageNamed:@"down_arrow"];
    }
    //返回nameView
    return nameView;
}

    //设置headerView高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
    //设置cell的高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"你点击了%ld", indexPath.row);
}
    
    
    //button的响应点击事件
- (void) buttonClicked:(UIButton *)sender {
    
    //改变模型数据里面的展开收起状态
    ABCoinGroup *group2 = dataArray[sender.tag - 200];
    group2.folded = !group2.isFolded;
    [walletTableView reloadData];
}


@end
