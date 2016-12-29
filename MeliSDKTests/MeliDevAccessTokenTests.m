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
