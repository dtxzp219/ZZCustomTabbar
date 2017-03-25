//
//  FLTabberView.h
//  FirstLive
//
//  Created by xmm on 16/3/16.
//  Copyright © 2016年 zhang. All rights reserved.
//

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "UIView+Addition.h"
@interface FLTabberView : UIView
/**
 *  tabbar 的index
 */
@property (nonatomic,assign)int selectIndex;
/**
 *  选中按钮的文字颜色 非必须请在内部实现
 */
@property (nonatomic,strong)UIColor *textSelectColor;
/**
 *  未选中按钮的文字颜色  默认 灰色  非必须请在内部实现
 */
@property (nonatomic,strong)UIColor *textColor;

/**
 *  viewController 的navigationCOntroller
 */
@property (nonatomic,strong)UINavigationController *navigationController;
//首页的跟视图 的类名
@property (nonatomic,strong)NSArray *homeVCArray;
/**
 *  需要登录才可以使用的模块的 序号 非必填
 */
@property (nonatomic,strong)NSArray *needLoginArray;
/**
 *  获取tabbar对象
 *
 *  @return 返回tabbar 对象
 */
+(FLTabberView *)shareTabbar;
/**
 *  创建tabbar 的视图 并赋值  如果不需要更换视图请在内部实现
 *
 *  @param imageArr  tabbar 按钮图片的数组
 *  @param selectArr tabbar 按钮选中图片的数组
 *  @param nameArr   按钮名称
 *  @param select    初始选择的 tabbar
 */
-(void)initTabbarWithNoSelectImage:(NSArray *)imageArr SelectImage:(NSArray *)selectArr buttonName:(NSArray *)nameArr andWithSelectItem:(int)select;
@end
