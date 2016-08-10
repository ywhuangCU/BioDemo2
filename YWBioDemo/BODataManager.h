//
//  BODataManager.h
//  YWBioDemo
//
//  Created by Yiwei Huang on 7/28/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BODataManager : NSObject

+ (instancetype) defaultManager;

- (NSDictionary *) fetchFakeCard;

@end
