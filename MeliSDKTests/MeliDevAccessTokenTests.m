//
//  MeliDevAccessTokenTests.m
//  MeliDevSDK
//
//  Created by Ignacio Giagante on 22/9/16.
//  Copyright © 2016 Mercado Libre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MeliDevAccessToken.h"

@interface MeliDevAccessTokenTests : XCTestCase

@end

@implementation MeliDevAccessTokenTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsTokenExpired_withTokenExpired_shouldReturnYes {
    
    NSString * accessTokenValue = @"TOKEN";
    NSString * expiresIn = @"-5000";
    
    MeliDevAccessToken * accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresIn];
    
    XCTAssertTrue([accessToken isTokenExpired]);
}

- (void)testIsTokenExpired_withNoTokenExpired_shouldReturnNo {
    
    NSString * accessTokenValue = @"TOKEN";
    NSString * expiresIn = @"21600";
    
    MeliDevAccessToken * accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresIn];
    
    XCTAssertFalse([accessToken isTokenExpired]);
}


@end
