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
    _scrollview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name1]];
    _scrollview.contentSize = CGSizeMake(iOSDeviceScreenSize.width*6, iOSDeviceScreenSize.height);
    _scrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name2]];
    [_scrollview addSubview:view1];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*2, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name3]];
    [_scrollview addSubview:view2];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*3, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name4]];
    [_scrollview addSubview:view3];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*4, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name5]];
    [_scrollview addSubview:view4];
    UIView *view5 = [[UIView alloc]initWithFrame:CGRectMake(iOSDeviceScreenSize.width*5, 0, iOSDeviceScreenSize.width, iOSDeviceScreenSize.height)];
    view5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:name6]];
    [_scrollview addSubview:view5];
    _scrollview.delegate = self;
    UITextView *textView1 = [[UITextView alloc]initWithFrame:CGRectMake(20, 160, 300, 300)];
    textView1.text = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@",[self.objects[0] valueForKey:@"days"],[self.objects[0] valueForKey:@"week"],[self.objects[0] valueForKey:@"weather"],[self.objects[0] valueForKey:@"temperature"]];
    textView1.backgroundColor = [UIColor clearColor];
    [_scrollview addSubview:textView1];
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
