//
//  presentViewController.h
//  lazyweather
//
//  Created by 陆非凡 on 15/9/10.
//  Copyright (c) 2015年 陆非凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface presentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *close;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong,nonatomic) NSMutableArray *objects;
@end
