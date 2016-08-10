//
//  YWShapedButton.h
//  ShapedButtonDemo
//
//  Inspiered by OBShapedButton - by Ole BegemannOctober, 2009
//
//  Created by Yiwei Huang on 6/28/16.
//
//

#import <UIKit/UIKit.h>


// -[UIView hitTest:withEvent: ignores views that an alpha level less than 0.1.
// So we will do the same and treat pixels with alpha < 0.1 as transparent.
#define kAlphaThreshold (0.1f)

@interface YWShapedButton : UIButton

@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,assign) NSInteger level;
@property (nonatomic,assign) BOOL isAnswer;

- (void) loadDataWithImageName:(NSString *) imageName
                       atLevel:(NSInteger) level
              correctImageName:(NSString *) correctImageName;

@end
