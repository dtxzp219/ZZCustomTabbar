//
//  UIView+Addition.h
//  Line0New
//
//  Created by line0 on 13-5-17.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)
- (UIView *)subViewWithTag:(int)tag;
- (void)removeAllSubviews;
- (void)removeSubviewWithTag:(int)tag;
- (void)removeSubviewExceptTag:(int)tag;
@end
