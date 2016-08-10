//
//  YWPotatoButton.m
//  ShapedButtonDemo
//
//  Created by Yiwei Huang on 6/28/16.
//
//

#import "YWHiddenButton.h"

@implementation YWHiddenButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //NSLog(@"Hittest");
    return [self hiddenhitTest:point withEvent:event];
}

- (UIView *)hiddenhitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //NSLog(@"Hidden Hittest");
    if (!self.isUserInteractionEnabled || self.alpha <= 0.01) {
        return nil;
    }
    
    if ([self pointInside:point withEvent:event]) {
        for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
            CGPoint convertedPoint = [subview convertPoint:point fromView:self];
            UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
            if (hitTestView) {
                if (hitTestView.hidden == YES) {
                    hitTestView.hidden = NO;
                }
                return hitTestView;
            }
        }
        return self;
    }
    return nil;
}


@end
