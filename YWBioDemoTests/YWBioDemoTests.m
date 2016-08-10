//
//  YWBioDemoTests.m
//  YWBioDemoTests
//
//  Created by Yiwei Huang on 7/11/16.
//  Copyright © 2016 ywh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BOGameViewController.h"

@interface YWBioDemoTests : XCTestCase  

@property (nonatomic,strong) BOGameViewController * vc;

@end

@implementation YWBioDemoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
//    app = [[XCUIApplication alloc] init];
//    [app launch];
    //self.vc = [[BOGameViewController alloc]init];
    self.vc = [[BOGameViewController alloc]initWithNibName:@"BOGameViewController" bundle:nil];
    [self.vc performSelectorOnMainThread:@selector(view) withObject:nil waitUntilDone:YES];
   
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    [super tearDown];
    
}


- (void)testThatViewLoads {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
    //XCTAssertEqual(self.bioVC.touchInsidePotato, NO);
    
    
}

-(void)testDataLoaded {
    XCTAssert(self.vc.candidiateNames.count > 0);
}

-(void)testDataConsistencyOfNumofCandidates {
    
    XCTAssertEqual(self.vc.numberOfCandidates, self.vc.candidiateNames.count);
}

- (void)testParentViewHasbioImageCanvas{
    
    NSArray *subviews = self.vc.view.subviews;
    XCTAssertTrue([subviews containsObject:self.vc.bioImageCanvas], @"View does not have a imageCanvas");
}

- (void)testBioImageCanvasLoads {
    XCTAssertNotNil(self.vc.bioImageCanvas, @"ImageCanvas not initiated");
}


- (void)testCanvasHasHiddenArea {
    NSArray * subviews = self.vc.bioImageCanvas.subviews;
    XCTAssertTrue([subviews containsObject:self.vc.hiddenButtonOnNib], @"No hidden area found");
}

- (void)testHiddenAreaLoads {
    XCTAssertNotNil(self.vc.hiddenButtonOnNib, @"HiddenButon not initiated");
}

- (void)testPotatoHit {
    [(UIButton *)self.vc.hiddenButtonOnNib sendActionsForControlEvents:UIControlEventTouchUpInside];
    XCTAssertTrue(self.vc.touchInsideHiddenArea);
}

- (void)testCanvasHasMultipleViews {
    NSArray * subviews = self.vc.bioImageCanvas.subviews;
    XCTAssertTrue(subviews.count >= self.vc.numberOfCandidates);
    
}

- (void)testCanvasHasShapeButtons {
    NSArray * subviews = self.vc.bioImageCanvas.subviews;
    for (NSInteger i = 0; i < self.vc.shapedButtons.count; i++) {
          XCTAssertTrue([subviews containsObject:self.vc.shapedButtons[i]]);
    }
  
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
