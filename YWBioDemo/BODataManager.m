//
//  BODataManager.m
//  YWBioDemo
//
//  Created by Yiwei Huang on 7/28/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import "BODataManager.h"
#import "BOConstant.h"

@interface BODataManager ()

@property (nonatomic, assign) NSInteger fakeCardNumber;
@property (nonatomic, assign) NSInteger currentFakeCardNumber;

@end

@implementation BODataManager

+ (instancetype) defaultManager {
    
    static BODataManager * dataManager;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        
        dataManager = [[self alloc]init];
        
    });
    
    return dataManager;
}

- (NSDictionary *)fetchFakeCard {
    
    self.fakeCardNumber = 2;
    
    NSDictionary * cardData = [NSMutableDictionary dictionary];
    
    NSString * methodName = [NSString stringWithFormat:@"createFakeCard%ld",self.currentFakeCardNumber];
    
    
    if ([self respondsToSelector:NSSelectorFromString(methodName)]) {
        cardData = [self performSelector:NSSelectorFromString(methodName)];
    } else {
        cardData = [self createFakeCard0];
    }
    
    self.currentFakeCardNumber++;
    
    if (self.currentFakeCardNumber >= self.fakeCardNumber) {
        self.currentFakeCardNumber = 0;
    }
    
    return cardData;
}



- (NSDictionary *) createFakeCard0 {
    
    
    NSDictionary * fakeCard = @{
                                kBOHiddenImageName : @"02-central-microtubule_1-circle",
                                kBOCorrectImageName : @"02-central-microtubule",
                                
                                kBOCandidiateNames : @[@"01-outer-microtubule",
                                                       @"02-central-microtubule",
                                                       @"03-plasma-membrane",
                                                       @"04-protein-cross-linking-outer-doublets",
                                                       @"05-dynein-proteins",
                                                       @"06-radial-spoke"],
                                
                                kBONumberOfCandidates : @"6",
                                kBOQuestionTopText : @"Tap on the central microTubule"
                                
                                };
    return fakeCard;
}

- (NSDictionary *) createFakeCard1 {
    
    
    NSDictionary * fakeCard = @{
                                kBOHiddenImageName : @"03-plasma-membrane",
                                kBOCorrectImageName : @"03-plasma-membrane",
                                
                                kBOCandidiateNames : @[@"01-outer-microtubule",
                                                       @"02-central-microtubule",
                                                       @"03-plasma-membrane",
                                                       @"04-protein-cross-linking-outer-doublets",
                                                       @"05-dynein-proteins",
                                                       @"06-radial-spoke"],
                                
                                kBONumberOfCandidates : @"6",
                                kBOQuestionTopText : @"Tap on the membrane"
                                
                                };
    return fakeCard;
}


- (NSDictionary *) createFakeCard2 {
    
    
    NSDictionary * fakeCard = @{
                                kBOHiddenImageName : @"CA_ShapedButton-01",
                                kBOCorrectImageName : @"CA_ShapedButton-01",
                                
                                kBOCandidiateNames : @[@"CA_ShapedButton-01",
                                                       @"UT_shapedButton-01",
                                                       @"NV_shapedButton-01",
                                                       @"AZ_shapedButton-01"
                                                      ],
                                
                                kBONumberOfCandidates : @"4",
                                kBOQuestionTopText : @"Tap on California"
                                
                                };
    return fakeCard;
}

- (NSDictionary *) createFakeCard99 {
    
    
    NSDictionary * fakeCard = @{
                                kBOHiddenImageName : @"02-central-microtubule_1-circle",
                                kBOCorrectImageName : @"02-central-microtubule_1-normal",
                                
                                kBOCandidiateNames : @[@"01-outer-microtubule_1-normal",
                                                       @"02-central-microtubule_1-normal",
                                                       @"03-plasma-membrane_1-normal",
                                                       @"04-protein-cross-linking-outer-doublets_1-normal"],
                                
                                kBONumberOfCandidates : @"4",
                                kBOQuestionTopText : @"Tap on the microTubule"
                                
                                };
    return fakeCard;
}

@end

