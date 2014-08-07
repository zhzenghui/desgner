//
//  DesignerM2_Tests.m
//  DesignerM2 Tests
//
//  Created by bejoy on 14/8/1.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "M2_MainViewController.h"


@interface DesignerM2_Tests : XCTestCase


@property(nonatomic, retain) M2_MainViewController *mainViewController;

@end

@implementation DesignerM2_Tests

- (void)setUp
{
    [super setUp];

    self.mainViewController = [[M2_MainViewController alloc] initWithNibName:@"M2_MainViewController" bundle:nil];
}

- (void)tearDown
{

    self.mainViewController  = nil;
    [super tearDown];
}

- (void)testExample
{

    XCTAssertNotNil(self.mainViewController.view, @"view not initiated properly");

}

@end
