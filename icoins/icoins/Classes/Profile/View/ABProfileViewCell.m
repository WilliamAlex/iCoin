//
//  ABProfileViewCell.m
//  icoins
//
//  Created by Alex Williams on 2017/8/21.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#import "ABProfileViewCell.h"


static NSInteger SwitchTag = 0;
@implementation ABProfileViewCell



#pragma mark - 懒加载
- (UIImageView *)arrow
{
    if (!_arrow) {
        
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_me_jiantou"]];
    }
    return _arrow;
}

- (UISwitch *)sw
{
    if (!_sw) {
        
        _sw = [[UISwitch alloc] init];
        _sw.tag = 1;
        [_sw addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _sw;
}

- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] init];
        _label.font = AdaptedFontSize(15);
    }
    return _label;
}

//监听开关状态的改变
- (void)switchValueChanged:(UISwitch *)sw
{
    TableViewCellItemSwitch *item = (TableViewCellItemSwitch *)self.item;
    if ([self.delegate respondsToSelector:@selector(settingCellChangeSwitchItem:)])
    {
        [self.delegate settingCellChangeSwitchItem:item];
    }
}

+ (instancetype)settingItemCell:(UITableView *)tableView
{
    static NSString *ID = @"TableViewCell";
    
    ABProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[ABProfileViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


//重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置cell选中的背景颜色
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = WGRGBColor(227, 221, 221);
        self.selectedBackgroundView = backgroundView;
        
        //设置文本的颜色
        self.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.detailTextLabel.textColor = [UIColor colorWithHexString:@"969696"];
        
        //设置文本的字体
        self.textLabel.font = AdaptedFontSize(15);
        self.detailTextLabel.font = AdaptedFontSize(15);
        
        //设置时间右对齐
        self.label.textAlignment = NSTextAlignmentRight;
        self.label.textColor = [UIColor colorWithHexString:@"969696"];
        [self.contentView addSubview:self.lineView];
    }
    
    return self;
}

- (void)setItem:(TableViewCellItem *)item
{
    _item = item;
    
    self.textLabel.text = item.title;
    self.imageView.image = item.icon ? [UIImage imageNamed:item.icon] : nil;
    self.detailTextLabel.text = item.detailText;
    
    if ([item isKindOfClass:[TableViewCellItemArrow class]])
    {
        // 右侧是箭头
        UIImage *arrowImg = [UIImage imageNamed:@"btn_jiantou"];
        self.accessoryView = [[UIImageView alloc] initWithImage:arrowImg];
    }
    else if ([item isKindOfClass:[TableViewCellItemSwitch class]])
    {  // Switch 开关
        
        SwitchTag ++;
        UISwitch *mySwitch = [UISwitch new];
        mySwitch.tag = SwitchTag;
        [mySwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        // 设置开关的状态
        mySwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:self.item.title];
        self.accessoryView = mySwitch;
        self.selectionStyle = UITableViewCellSelectionStyleNone;  //设置Cell选中的样式
        
    }
    else if ([item isKindOfClass:[TableViewCellItemLabel class]])
    {
        self.label.text = [(TableViewCellItemLabel *)item label];
        self.accessoryView = self.label;
    }
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    
    self.lineView.hidden = _showBottomLine ? NO : YES;      //关闭隐藏分割线
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    WS(ws)
    CGFloat lineX = self.textLabel.frame.origin.x;
    CGFloat lineW = self.frame.size.width - lineX;
    CGFloat lineH = 1;
    CGFloat lineY = self.frame.size.height - lineH;
    self.lineView.frame = CGRectMake(lineX, lineY, lineW, lineH);
    
    // 修改accessoryView的frame
    CGRect adjustedFrame = self.accessoryView.frame;
    adjustedFrame.origin.x += 5.0f;
    self.accessoryView.frame = adjustedFrame;
    
    // label
    CGSize labelSize = [[ABGlobalMethods shareManager] getAutoLayoutWidthAndHeightWithLabel:_label font:15];
    
    _label.ab_width = labelSize.width;
    _label.ab_height = labelSize.height;
    _label.ab_x = CGRectGetMaxX(self.contentView.frame) - labelSize.width;
    _label.ab_y = self.contentView.ab_centerY - labelSize.height/2;
}


@end
