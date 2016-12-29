//
//  MeliDevUtilsTests.m
//  MeliDevSDK
//
//  Created by Ignacio Giagante on 22/9/16.
//  Copyright © 2016 Mercado Libre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MeliDevUtils.h"

@interface MeliDevUtilsTests : XCTestCase

@end

@implementation MeliDevUtilsTests


- (void)testValidateUrl_withValidUrl_shouldReturnYes {
    
    NSString * url = @"http://www.example.com";
    XCTAssertTrue([MeliDevUtils validateUrl:url]);
}

- (void)testValidateUrl_withInvalidUrl_shouldReturnNo {
    
    NSString * url = @"www.example.com";
    XCTAssertFalse([MeliDevUtils validateUrl:url]);
}

- (void)testIsNumeric_withValidNumber_shouldReturnYes {
    
    NSString * number = @"4523623462345";
    XCTAssertTrue([MeliDevUtils isNumeric: number]);
}

- (void)testIsNumeric_withInvalidNumber_shouldReturnNo {
    
    NSString * number = @"45236adr/23462345";
    XCTAssertFalse([MeliDevUtils isNumeric: number]);
}


@end
