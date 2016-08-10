//
//  BOGameplayDelegate.h
//  YWBioDemo
//
//  Created by Yiwei Huang on 8/1/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BOGameViewController;

@protocol BOGameLogicDelegate;

@interface BOGameLogicProtocol : NSObject

@property (nonatomic, weak) id <BOGameLogicDelegate> delegate;

@end

@protocol BOGameLogicDelegate <NSObject>

@required

- (void)willResetGameLogic;
- (void)didFinishAnswer:(BOOL) isFinished;
- (void)didAnswerCorrect:(BOOL) isAnswerCorrect;
- (void)willShowCorrectAnswer;

@optional

@end
