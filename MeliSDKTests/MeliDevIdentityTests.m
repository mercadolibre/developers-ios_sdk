//
//  MeliDevIdentityTests.m
//  MeliDevSDK
//
//  Created by Ignacio Giagante on 22/9/16.
//  Copyright © 2016 Mercado Libre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MeliDevIdentity.h"

static NSString * MELI_APP_ID = @"MeliAppId";
static NSString * const ACCESS_TOKEN = @"access_token";
static NSString * const EXPIRES_IN = @"expires_in";
static NSString * const USER_ID = @"user_id";

static NSString * MELI_APP_ID_VALUE = @"7230677288562808";
static NSString * OTHER_MELI_APP_ID_VALUE = @"5197208004815569";
static NSString * USER_ID_VALUE = @"2277711";
static NSString * ACCESS_TOKEN_VALUE = @"token";
static NSString * EXPIRES_IN_VALUE = @"21600";

@interface MeliDevIdentityTests : XCTestCase

@end

@implementation MeliDevIdentityTests

- (void)setUp {
    
    [super setUp];
    
    NSMutableDictionary *loginData = [[NSMutableDictionary alloc] init];
    [loginData setValue: USER_ID_VALUE forKey: USER_ID];
    [loginData setValue: ACCESS_TOKEN_VALUE forKey: ACCESS_TOKEN];
    [loginData setValue: EXPIRES_IN_VALUE forKey: EXPIRES_IN];
    
    [MeliDevIdentity createIdentity:loginData clientId:MELI_APP_ID_VALUE];
}

- (void) testRestoreMeliDevIdentity_withLoginData_shouldReturnMeliDevIdentity {
    
    MeliDevIdentity * identity = [MeliDevIdentity restoreIdentity: MELI_APP_ID_VALUE];
    
    XCTAssertNotNil(identity, @"The identity should not be nil");
    XCTAssertTrue([identity.accessTokenValue isEqualToString: ACCESS_TOKEN_VALUE]);
}

- (void) testRestoreMeliDevIdentity_withClientIdChanged_shouldReturnNil {
    
    MeliDevIdentity * identity = [MeliDevIdentity restoreIdentity: OTHER_MELI_APP_ID_VALUE];
    XCTAssertNil(identity, @"The identity should be nil");
}

@end
