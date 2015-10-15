//
//  presentViewController.m
//  lazyweather
//
//  Created by 陆非凡 on 15/9/10.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import "presentViewController.h"

@interface presentViewController ()<UIScrollViewDelegate>


@end

@implementation presentViewController
{
    CGSize iOSDeviceScreenSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closepresent)];
    [self.close addGestureRecognizer:gesture1];
    self.close.userInteractionEnabled=YES;
    iOSDeviceScreenSize = [UIScreen mainScreen].bounds.size;
    // Do any additional setup after loading the view, typically from a nib.
    NSString *name1 = [self wenzichuli:[self.objects[0] valueForKey:@"weather"]];
    NSString *name2 = [self wenzichuli:[self.objects[1] valueForKey:@"weather"]];
    NSString *name3 = [self wenzichuli:[self.objects[2] valueForKey:@"weather"]];
    NSString *name4 = [self wenzichuli:[self.objects[3] valueForKey:@"weather"]];
    NSString *name5 = [self wenzichuli:[self.objects[4] valueForKey:@"weather"]];
    NSString *name6 = [self wenzichuli:[self.objects[5] valueForKey:@"weather"]];
    _scrollview.contentSize = CGSizeMake(iOSDeviceScreenSize.width*6, iOSDeviceScreenSize.height);
    _scrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view0.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name1]];
    [_scrollview addSubview:view0];
    UIView *view01 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name1 view:view01];
    [_scrollview addSubview:view01];
    UITextView *textView0 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView0 num:0];
    [view01 addSubview:textView0];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name2]];
    [_scrollview addSubview:view1];
    UIView *view11 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name2 view:view11];
    [_scrollview addSubview:view11];
    UITextView *textView1 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView1 num:1];
    [view11 addSubview:textView1];
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*2, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name3]];
    [_scrollview addSubview:view2];
    UIView *view21 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*2, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name3 view:view21];
    [_scrollview addSubview:view21];
    UITextView *textView2 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView2 num:2];
    [view21 addSubview:textView2];
    
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*3, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name4]];
    [_scrollview addSubview:view3];
    UIView *view31 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*3, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name4 view:view31];
    [_scrollview addSubview:view31];
    UITextView *textView3 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView3 num:3];
    [view31 addSubview:textView3];
    
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*4, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name5]];
    [_scrollview addSubview:view4];
    UIView *view41 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*4, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name5 view:view41];
    [_scrollview addSubview:view41];
    UITextView *textView4 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView4 num:4];
    [view41 addSubview:textView4];
    
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*5, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name6]];
    [_scrollview addSubview:view5];
    UIView *view51 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*5, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    [self panduan:name6 view:view51];
    [_scrollview addSubview:view51];
    UITextView *textView5 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    [self textSet:textView5 num:5];
    [view51 addSubview:textView5];
    
    _scrollview.delegate = self;
    
    int pagenum = [[self.objects lastObject] intValue];
    [_scrollview setContentOffset:CGPointMake(0+320*pagenum,0) animated:YES];
}

//文字数据处理
-(NSString *)wenzichuli:(NSString *)string
{
    if([string rangeOfString:@"转"].location != NSNotFound){
        NSRange range = [string rangeOfString:@"转"];
        NSString *aaaa = [string substringFromIndex:range.location+1];
        NSString *cccc = [NSString stringWithFormat:@"%@-",aaaa];
    return cccc;
    }
    else{
        NSString *cccc = [NSString stringWithFormat:@"%@-",string];
        return cccc;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//关闭按钮
-(void)closepresent
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)panduan:(NSString*)string view:(UIView *)view
{
    if([string  isEqual: @"晴-"])
        view.backgroundColor = [UIColor colorWithRed:240.0/255 green:128.0/255 blue:128.0/255 alpha:0.7];
    if([string isEqual:@"多云-"])
        view.backgroundColor = [UIColor colorWithRed:0.0/255 green:191.0/255 blue:225.0/255 alpha:0.7];
    if([string rangeOfString:@"雨"].location != NSNotFound)
        view.backgroundColor = [UIColor colorWithRed:138.0/255 green:43.0/255 blue:226.0/255 alpha:0.7];
}

-(void)textSet:(UITextView *)textView num:(int)i
{
    textView.text = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@",[self.objects[i] valueForKey:@"days"],[self.objects[i] valueForKey:@"week"],[self.objects[i] valueForKey:@"weather"],[self.objects[i] valueForKey:@"temperature"]];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:20];
    textView.textColor = [UIColor whiteColor];
}
#pragma mark ---------------UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat painyi = _scrollview.contentOffset.x / iOSDeviceScreenSize.width;
    self.pageControl.currentPage = painyi;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
