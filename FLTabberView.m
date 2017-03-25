//
//  FLTabberView.m
//  FirstLive
//
//  Created by xmm on 16/3/16.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "FLTabberView.h"

static FLTabberView *_tabbarView;

@implementation FLTabberView
{
    int cacheButtonClick; //每次点击button 的index
}
+(FLTabberView *)shareTabbar
{
    if(!_tabbarView)
    {
        _tabbarView =[[FLTabberView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-49, Main_Screen_Width, 49)];
        NSArray *imageArray=[NSArray arrayWithObjects:@"home_img_home",@"home_img_market",@"home_img_trade", @"home_img_live",@"home_img_mine",nil];
        NSArray *selImageArray=[NSArray arrayWithObjects:@"home_img_homeSel",@"home_img_marketSel",@"home_img_tradeSel",@"home_img_liveSel", @"home_img_mineSel",nil];
        NSArray *nameArray=[NSArray arrayWithObjects:@"首页",@"行情",@"交易",@"直播", @"我的",nil];
        
#pragma mark 这里设置tabbar 的根视图
        _tabbarView.homeVCArray=[NSArray arrayWithObjects:@"FLHomeViewController",@"FLHangQingViewController",@"FLTradeViewController",@"FLLiveListViewController", @"FLMineViewController",nil];
        _tabbarView.needLoginArray=[NSArray arrayWithObjects:@"2",@"4", nil];
        _tabbarView.backgroundColor=[UIColor whiteColor];
        _tabbarView.textColor=[UIColor colorWithRed:0.36 green:0.37 blue:0.37 alpha:1];
        _tabbarView.textSelectColor=[UIColor colorWithRed:0.96 green:0.27 blue:0.22 alpha:1];
        [_tabbarView initTabbarWithNoSelectImage:imageArray SelectImage:selImageArray buttonName:nameArray andWithSelectItem:0];
    }
    return _tabbarView;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.alpha=0.9;
        
        
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess:) name:UserLoginSuccessNotification object:nil];
    }
    return self;
}
-(void)initTabbarWithNoSelectImage:(NSArray *)imageArr SelectImage:(NSArray *)selectArr buttonName:(NSArray *)nameArr andWithSelectItem:(int)select
{
    [self removeAllSubviews];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
    line.backgroundColor=[UIColor colorWithRed:0.61 green:0.62 blue:0.62 alpha:1];
    [self addSubview:line];
    
    
    /// tabBar上每个item的宽度
    float itemWidth = Main_Screen_Width/imageArr.count;
    
    /// 创建每个item
    for (int i=0; i<imageArr.count; i++)
    {
        UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth*i, 0.5, itemWidth, HEIGHT(self)-20 )];
        itemButton.adjustsImageWhenHighlighted = NO;
        [itemButton setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [itemButton setImage:[UIImage imageNamed:selectArr[i]] forState:UIControlStateSelected];
        [itemButton addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        itemButton.tag =10000+i;
        [self addSubview:itemButton];
        
        UIButton *labelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        labelBtn.frame=CGRectMake(itemButton.left, itemButton.bottom, itemButton.width, 20);
        [labelBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        [self addSubview:labelBtn];
        
        
        [labelBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        [labelBtn setTitle:nameArr[i] forState:UIControlStateSelected];
        [labelBtn setTitleColor:self.textSelectColor forState:UIControlStateSelected];
        [labelBtn addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        [labelBtn setTitleColor:self.textColor forState:UIControlStateNormal];
        labelBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        
        labelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
        
        labelBtn.tag=1000+i;
        [self addSubview:labelBtn];
        if (i == select) {
            itemButton.selected = YES;
            labelBtn.selected=YES;
        }
        else
        {
            itemButton.selected = NO;
            labelBtn.selected=NO;
        }
    }
//    UIWindow *window=[[UIApplication sharedApplication].delegate window];
//    [window addSubview:self];
}
-(void)labelClick:(UIButton *)btn
{
    self.selectIndex=(int)btn.tag-1000;
}
- (void)itemClick:(UIButton *)item
{
    self.selectIndex=(int)item.tag-10000;
}
/**
 *  重写selectINdex 方法并进行跳转
 *
 *  @param selectIndex 设置的select
 */
-(void)setSelectIndex:(int)selectIndex
{
    _selectIndex=selectIndex;
    
    BOOL isNeedLogin=NO;
    NSLog(@"%@",self.needLoginArray);
    if (self.needLoginArray) {
        //判断有没有需要登录的controller
        for (int i=0; i<self.needLoginArray.count; i++) {
            if (_selectIndex==[self.needLoginArray[i] intValue]) {
                isNeedLogin=YES;
            }
        }
    }
    
    BOOL isLogin= [FLUserCenterModel sharedUserCenter].isLogin;
    
    if (isNeedLogin == YES && isLogin == NO) {
        //没有登陆
        //没有登陆
            cacheButtonClick=self.selectIndex;
            FLLoginViewController *login=[[FLLoginViewController alloc]init];
            FLNavigationController *navi=[[FLNavigationController alloc]initWithRootViewController:login];
            UIViewController *vc11=[self.navigationController.viewControllers lastObject];
            [vc11 presentViewController:navi animated:YES completion:nil];
    }
    else
    {
        [self setButtonSelect];

        NSLog(@"selectindex %d  cacheIndex %d  lastVC %@",_selectIndex,cacheButtonClick,self.navigationController.viewControllers);
        
        BOOL flag=YES;
        for (int i=0 ;i<self.navigationController.viewControllers.count;i++) {
            UIViewController *controller=self.navigationController.viewControllers[i];
            NSString *className=[NSString stringWithUTF8String:object_getClassName(controller)];
            if ([className isEqualToString:self.homeVCArray[selectIndex]]) {
                flag=NO;
                [self.navigationController popToViewController:controller animated:NO];
            }
        }
        if (flag) {
            UIViewController *vc=[[NSClassFromString(self.homeVCArray[_selectIndex]) alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
    
}
-(void)setButtonSelect
{
    //设置按钮的选中状态
    for (int i=0; i<self.homeVCArray.count; i++) {
        UIButton *btn1=(UIButton *)[self viewWithTag:10000+i];
        btn1.selected=NO;
        UIButton *btn2=(UIButton *)[self viewWithTag:1000+i];
        btn2.selected=NO;
    }
    UIButton *btn1=(UIButton *)[self viewWithTag:1000+_selectIndex];
    btn1.selected=YES;
    UIButton *btn2=(UIButton *)[self viewWithTag:10000+_selectIndex];
    btn2.selected=YES;
}
/**
 *  登陆成功的通知
 *
 *  @param noti 通知
 */
-(void)loginSuccess:(NSNotification *)noti
{
    UIViewController *controller=[self.navigationController.viewControllers lastObject];
    NSString *className=[NSString stringWithUTF8String:object_getClassName(controller)];
    NSLog(@"%@",className);
    NSLog(@"loginSuccess %@",self.navigationController.viewControllers);
    //所以的登录 如果是从 tabbar 进去的 都是从SSGSHomeViewController 里push 过去的 所以判断navigationCOntrollers 最后一个是不是SSGSHomeViewController 就可以决定是否执行self.selectIndex 的set方法
    for (int i=0; i<self.homeVCArray.count; i++) {
        if ([className isEqualToString:self.homeVCArray[i]]) {
            self.selectIndex=cacheButtonClick;
        }
        
    }
    
}
//重写setHidden 方法
-(void)setHidden:(BOOL)hidden
{
    float height=Main_Screen_Height>Main_Screen_Width?Main_Screen_Height:Main_Screen_Width;
    if (hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, height, self.width, self.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.frame=CGRectMake(0, height-49, self.width, self.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UserLoginSuccessNotification object:nil];
    
}

@end
