//
//  UIView+Addition.m
//  Line0New
//
//  Created by line0 on 13-5-17.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (UIView *)subViewWithTag:(int)tag
{
	for (UIView *v in self.subviews)
    {
		if (v.tag == tag)
        {
			return v;
		}
	}
	return nil;
}

- (void)removeAllSubviews{
    for (UIView *temp in self.subviews) {
        [temp removeFromSuperview];
    }
}

- (void)removeSubviewWithTag:(int)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptTag:(int)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag!=tag) {
            [temp removeFromSuperview];
        }
    }
}

@end
