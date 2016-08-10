//
//  BOFakeGamePlayDelegate.h
//  YWBioDemo
//
//  Created by Yiwei Huang on 8/1/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <Foundation/Foundation.h>

//Gameplay protocol
@protocol GamePlayDelegate;
//@class SPCard;
@class BOFakeCard;

@interface BOFakeGamePlayDelegate : NSObject

//delegate instance
@property (nonatomic, weak) id <GamePlayDelegate> delegate;

@end

@protocol GamePlayDelegate <NSObject>

@required
//provide the card currently in play
- (BOFakeCard *)currentCard;
//provide the current phase of play
- (enum SPStudyPhase)currentPhase;
//process end of card play
- (void)didFinishCard;
//process skip question request
- (void)didSkipCard;
//process the pause request
- (void)didPauseGameplay;
//reset inactivity count-down timer
- (void)keepActive;


@optional
- (void)freezeGameplay;
- (void)activateGameplay;
//for moduleList in practice
- (void)selectModule:(NSString *)moduleID;
- (BOOL)shouldAutorotate;

@end

