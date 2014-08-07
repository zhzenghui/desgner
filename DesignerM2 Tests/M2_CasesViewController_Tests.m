//
//  M2_CasesViewController.m
//  Designer
//
//  Created by bejoy on 14/8/1.
//  Copyright (c) 2014年 zeng hui. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "M2_CasesViewController_Private.h"


@interface M2_CasesViewController_Tests : XCTestCase


@property (nonatomic, strong) M2_CasesViewController *vc;

 @end

@implementation M2_CasesViewController_Tests

- (void)setUp
{
    [super setUp];

    self.vc = [[M2_CasesViewController alloc] initWithNibName:@"M2_CasesViewController" bundle:nil];
    

}

- (void)tearDown
{

    self.vc = nil;
    [super tearDown];
}

- (void)testThatViewLoads
{

    XCTAssertNotNil(self.vc.view, @"view not initiated properly");
    
}


- (void)testThatUICollectionView
{
    
    XCTAssertNotNil(self.vc, @"vc  not init");
}


- (void)testThatMdict
{
    
    XCTAssertNotNil(self.vc.dataMDict, @"vc  not init");
}


@end
