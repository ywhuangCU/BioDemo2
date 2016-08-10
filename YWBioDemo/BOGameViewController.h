//
//  BOGameViewController.h
//  YWBioDemo
//
//  Created by Yiwei Huang on 7/11/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import"YWPotatoButton.h"
@class YWHiddenButton;
@class YWShapedButton;
@class BOGameLogicProtocol;



#define allowHiddenButton 0

@interface BOGameViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIView *bioImageCanvas;
@property (weak, nonatomic) IBOutlet YWHiddenButton *hiddenButtonOnNib;
@property (weak, nonatomic) IBOutlet UILabel *questionTop;
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImageView;

//Buttons
@property (nonatomic, strong) YWHiddenButton * hiddenButton;
@property (nonatomic, strong) NSMutableArray<YWShapedButton *> * shapedButtons;


//logic
@property (nonatomic, assign) NSInteger numberOfCandidates;
@property (nonatomic, assign) BOOL isAnswerImageHit;
@property (nonatomic, assign) BOOL touchInsideHiddenArea;



//data
@property (nonatomic, copy) NSString * questionTopText;
@property (nonatomic, copy) NSString * hiddenImageName;
@property (nonatomic, copy) NSString * correctImageName;
@property (nonatomic, strong) NSArray<NSString *> * candidiateNames;

//TODO: Gameplay / Logic Delegate




//Unit Test
@property (weak, nonatomic) IBOutlet UILabel * debugInfoLabel;



@end
