//
//  BOGameViewController.m
//  YWBioDemo
//
//  Created by Yiwei Huang on 7/11/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import "BOGameViewController.h"
#import "GOGameViewController.h"
#import "BOConstant.h"
#import "BODataManager.h"

#import "YWHiddenButton.h"
#import "YWShapedButton.h"

#import "BOGameLogicProtocol.h"

@interface BOGameViewController () <BOGameLogicDelegate>

@property (nonatomic,strong) BOGameLogicProtocol * gameLogicProtocol;


@end

@implementation BOGameViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setUpNavigationItems];
    
    //load first card
    [self fetchNewCard];
    
    //delegate
    self.gameLogicProtocol = [[BOGameLogicProtocol alloc]init];
    self.gameLogicProtocol.delegate = self;
}

- (void)setUpNavigationItems {
    
    //UIBarButtonItem * geoButton = [[UIBarButtonItem alloc]initWithTitle:@"GEO" style:UIBarButtonItemStylePlain target:self action:@selector(showNextVC)];
    //self.navigationItem.leftBarButtonItem = geoButton;
    
    UIBarButtonItem * nextButton = [[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(fetchNewCard)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
}

- (void)fetchNewCard {
    [self resetForNewCard];
    
    [self initParameters];
    [self fetchData];
    [self updateBioViews];
}

- (void)resetForNewCard {
    [self resetLogic];
    [self resetVariables];
    [self resetViews];
}

- (void)resetLogic {
    self.debugInfoLabel.text = @"";
    
    [self.gameLogicProtocol.delegate willResetGameLogic];
}

- (void)resetVariables {


    self.isAnswerImageHit = NO;
    self.touchInsideHiddenArea = NO;
    self.hiddenButton = nil;
    self.numberOfCandidates = 0;
}

- (void)resetViews {
    [self clearShapeButtons];
    [self resetCue];
}

- (void)initParameters {
    self.shapedButtons = [NSMutableArray array];
}



- (void)updateBioViews {
    
    [self updateQuestionTop];
    [self configShapedButtonsProgramatically];

#if allowHiddenButton
    
#else
    self.hiddenButtonOnNib.hidden = YES;
    self.hiddenButtonOnNib = nil;
    
#endif

}

#pragma mark - button management

- (void)configShapedButtonsProgramatically {
    
    //[self initShapedButtonsWithImage];
    //[self addShapedButtonToView];
    
    [self initShapedButtonsWithImageWithConstraints];
    
    
    
}



- (void)initShapedButtonsWithImageWithConstraints {
    
    [self initShapedButtonsWithImage];
    [self addShapedsButtonToView];
    [self addConstraintsToShapedButtons];
}

- (void)addShapedsButtonToView {
    //Process from the last object in the Collection to ensure z hierachy
    for (NSInteger i = self.shapedButtons.count -1 ; i >=0 ;i--) {
        
        [self.bioImageCanvas addSubview:self.shapedButtons[i]];
    }
}

- (void)initShapedButtonsWithImage {
    
    for (NSInteger i = 0 ; i < self.numberOfCandidates ; i++) {
        YWShapedButton * aShapeButton = [[YWShapedButton alloc]initWithFrame:CGRectMake(0, 0, self.bioImageCanvas.bounds.size.width, self.bioImageCanvas.bounds.size.height)];
        NSString * bioImageName = self.candidiateNames[i];
        UIImage * bioImage = [UIImage imageNamed:bioImageName];
        
        [aShapeButton setImage:bioImage forState:UIControlStateNormal];
        [aShapeButton addTarget:self action:@selector(shapedButtonHit:) forControlEvents:UIControlEventTouchUpInside];
        [aShapeButton loadDataWithImageName:bioImageName atLevel:i correctImageName:self.correctImageName];
        
        //TODO: Need a way to ensure the vertical z hiearchy
        [self.shapedButtons addObject:aShapeButton];

    }
}


- (void)addConstraintsToShapedButtons {
    
    for (YWShapedButton * aShapeButton in self.shapedButtons) {
        [self addEqualHeightEqualWidthContraints:self.bioImageCanvas relatedToView:aShapeButton];
    }
}

- (void)addEqualHeightEqualWidthContraints:(UIView *)superview relatedToView: (UIView *) subview {
    
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeWidth relatedBy:0 toItem:superview attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeTop relatedBy:0 toItem:superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint * leading = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    
    [superview addConstraint:width];
    [superview addConstraint:height];
    [superview addConstraint:top];
    [superview addConstraint:leading];
}


- (void)configHiddenButtonProgramatically {

    self.hiddenButton = [[YWHiddenButton alloc] initWithFrame:self.bioImageCanvas.frame];
    UIImage * hiddenImage = [UIImage imageNamed:self.hiddenImageName];
    [self.hiddenButton setImage:hiddenImage forState:UIControlStateNormal];
    
    [self.hiddenButton addTarget:self action:@selector(hiddenAreaHit:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.bioImageCanvas addSubview:self.hiddenButton];
    [self.bioImageCanvas bringSubviewToFront:self.hiddenButton];
}

- (void)disableInteractionShapedButtons {
    for (YWShapedButton * button in self.shapedButtons) {
        button.userInteractionEnabled = NO;
    }
}

- (void)enableInteractionShapedButtons {
    for (YWShapedButton * button in self.shapedButtons) {
        button.userInteractionEnabled = YES;
    }
}

#pragma mark - view rendering


- (void)updateQuestionTop {
    self.questionTop.text = self.questionTopText;
}

- (void)showNextVC {
    
    GOGameViewController * gvc = [[GOGameViewController alloc]initWithNibName:@"GOGameViewController" bundle:nil];
    [self.navigationController pushViewController:gvc animated:NO];
    
}



#pragma mark - hittest

- (IBAction)hiddenButtonOnNibHit:(id)sender {
    self.touchInsideHiddenArea = YES;
    self.hiddenButtonOnNib.hidden = NO;
    self.hiddenButtonOnNib.highlighted = YES;
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         self.hiddenButtonOnNib.alpha = 0.1;
                         
                     }
                     completion:^(BOOL finished){
                         self.hiddenButtonOnNib.hidden =YES;
                         self.hiddenButtonOnNib.highlighted = NO;
                         self.hiddenButtonOnNib.alpha = 1.0;
                     }];

    
}

- (void)hiddenAreaHit: (id) sender {
    self.touchInsideHiddenArea = YES;
}

- (void)shapedButtonHit: (id) sender {
    
    if ([sender isKindOfClass:[YWShapedButton class]]) {
        
        YWShapedButton * tappedSBtn = (YWShapedButton *)sender;
        
        if (tappedSBtn.isAnswer) {
            
            self.isAnswerImageHit = YES;
            
            [self.gameLogicProtocol.delegate didAnswerCorrect:YES];
            
            
        } else {
            
            [self.gameLogicProtocol.delegate didAnswerCorrect:NO];
        }
        
        [self.gameLogicProtocol.delegate didFinishAnswer:YES];
    }
}

#pragma mark - view effects

- (void)showCorrectAnswer {
    
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self dimImagesExceptAnswer];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)dimImagesExceptAnswer {
    for (YWShapedButton * shapedButton in self.shapedButtons) {
        if (!shapedButton.isAnswer) {
            shapedButton.alpha = 0.2;
        }
    }
}

- (void)clearShapeButtons {
    //Remove included objects from superview before reset the array to nil
    for (YWShapedButton * button in self.shapedButtons) {
        [button removeFromSuperview];
    }
    
    self.shapedButtons = nil;
}

- (void)showCueCorrect {
    
    [self paintFrameOnBackground:[UIColor greenColor]];

}

- (void)showCueWrong {
    
    [self paintFrameOnBackground:[UIColor redColor]];

}

- (void)resetCue {
    self.BackgroundImageView.layer.borderWidth = 0.0;
    self.BackgroundImageView.layer.borderColor = [UIColor clearColor].CGColor;
    self.BackgroundImageView.alpha = 1.0;

}

- (void) paintTransparentBackGroundColor:(UIColor *) color {
    self.BackgroundImageView.backgroundColor = color;
    self.BackgroundImageView.alpha = 0.1;
}

- (void) paintFrameOnBackground:(UIColor *) color {
    self.BackgroundImageView.layer.borderWidth = 5.0;
    self.BackgroundImageView.layer.borderColor = color.CGColor;
    self.BackgroundImageView.alpha = 0.6;
}

#pragma mark - Card Data
- (void)fetchData {
    NSDictionary * cardData = [[BODataManager defaultManager] fetchFakeCard];
    [self readData:cardData];
}

- (void)readData:(NSDictionary *) cardData {
    self.hiddenImageName = cardData[kBOHiddenImageName];
    self.correctImageName= cardData[kBOCorrectImageName];
    
    self.candidiateNames = cardData[kBOCandidiateNames];
    
    self.numberOfCandidates = self.candidiateNames.count;
    self.questionTopText = cardData[kBOQuestionTopText];
    
}



#pragma mark - logic delegate
- (void)willResetGameLogic {
    [self enableInteractionShapedButtons];
    self.debugInfoLabel.text = @"";
}


- (void)didFinishAnswer:(BOOL) isFinished {
    
    if (isFinished) {

        NSLog(@"user finished answering.");
        [self disableInteractionShapedButtons];
        [self.gameLogicProtocol.delegate willShowCorrectAnswer];
    }
    
}

- (void)didAnswerCorrect:(BOOL)isAnswerCorrect {
    
    if (isAnswerCorrect) {
        
        NSLog(@"user got the answer right");
        [self showCueCorrect];
    } else {
        
        NSLog(@"user got the answer wrong");
        [self showCueWrong];
    }
    
}

- (void)willShowCorrectAnswer {
    [self showCorrectAnswer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end
