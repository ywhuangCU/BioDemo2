//
//  YWBioDemoUITests.m
//  YWBioDemoUITests
//
//  Created by Yiwei Huang on 7/11/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BOGameViewController.h"

@interface YWBioDemoUITests : XCTestCase {
    XCUIApplication *app;
    UIViewController * navVC;
}

@end

@implementation YWBioDemoUITests
- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app = [[XCUIApplication alloc] init];
    [app launch];
    
    
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    //navVC = nil;
    //app = nil;
    [super tearDown];
}



- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    
//    XCUIElement *button = app.buttons[@"03 plasma membrane 1 normal"];
//    [button tap];
//    [[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"BOGameView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element pressForDuration:0.5];
//    [button tap];
    
    XCUIElement * window = [app.windows elementBoundByIndex:0];
    XCUIElement * element = app.buttons[@"03 plasma membrane 1 normal"];
    XCTAssert(CGRectContainsRect(window.frame, element.frame));
    
}

- (void) testNavControllerInit {
    navVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    XCTAssertNotNil(navVC,@"navVC not init");
}

- (void) testDetectNavController {
    XCTAssertTrue([navVC isKindOfClass:[UINavigationController class]], @"navVC not a UINavigationVC");
}

//- (void) testPotatoHit {
//    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationFaceUp;
//
//    [[[[[[[[[app.otherElements containingType:XCUIElementTypeNavigationBar identifier:@"BOGameView"] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"02 central microtubule 1 potat"] elementBoundByIndex:0] tap];
//    
//    
//}

@end
