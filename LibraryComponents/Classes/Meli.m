//
//  Meli.m
//  Pods
//
//  Created by Ignacio Giagante on 6/9/16.
//
//

#import "Meli.h"
#import "MeliDevIdentity.h"
#import "MeliDevLoginViewController.h"
#import "MeliDevUtils.h"
#import "MeliDevErrors.h"

static NSString const * MELI_REDIRECT_URL_KEY = @"MeliRedirectUrl";

static NSString const * APP_ID_NOT_DEFINED_KEY = @"App ID is not defined at info.plist";
static NSString const * REDIRECT_URL_NOT_DEFINED_KEY = @"Redirect URL is not defined at info.plist";
static NSString const * APP_ID_IS_NOT_NUMERIC_KEY = @"App ID is not numeric";
static NSString const * REDIRECT_URL_IS_NOT_VALID_KEY = @"Redirect URL is not valid";

@interface Meli ()

@end

@implementation Meli

static NSString * _clientId;
static NSString * _redirectUrl;

static MeliDevIdentity * identity;
static NSDictionary *dictionary;
static BOOL isSDKInitialized = NO;

+ (MeliDevIdentity *) getIdentity {
    
    identity = [MeliDevIdentity restoreIdentity: _clientId];
    
    if(identity.clientId) {
        return identity;
    } else {
        return nil;
    }
}

+ (NSString *) getClientId {
    return _clientId;
}

+ (NSString *) getRedirectUrl {
    return _redirectUrl;
}

+ (void) startSDK: (NSString *) clientId withRedirectUrl:(NSString *) redirectUrl error:(NSError **) error {
    
    [self verifyAppID:clientId error: &error];
    [self verifyRedirectUrl:redirectUrl error: &error];
    
    _clientId = clientId;
    _redirectUrl = redirectUrl;
    
    isSDKInitialized = YES;
}

+ (void) verifyAppID: (NSString *) appId error:(NSError **) error {
    
    if(appId == nil) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: APP_ID_NOT_DEFINED_KEY};
        
        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:AppIdIsNotInitializedError
                                 userInfo:userInfo];
    } else if( [MeliDevUtils isNumeric: appId] ) {
        NSLog(@"App ID correct %@", appId);
    } else {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: APP_ID_IS_NOT_NUMERIC_KEY};

        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:AppIdNotValidError
                                 userInfo:userInfo];
    }
    
}

+ (void) verifyRedirectUrl: (NSString *) redirectUrl error:(NSError **) error {
    
    if(redirectUrl == nil) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: REDIRECT_URL_NOT_DEFINED_KEY};
        
        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:RedirectUrlIsNotInitializedError
                                 userInfo:userInfo];
    } else if( [MeliDevUtils validateUrl: redirectUrl] ) {
        NSLog(@"Redirect URL is valid %@", redirectUrl);
    } else {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: REDIRECT_URL_IS_NOT_VALID_KEY};
        
        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:RedirectUrlNotValidError
                                 userInfo:userInfo];
    }
}

+ (void) startLogin: (UIViewController *) clientViewController {
    
        MeliDevLoginViewController * loginViewController = [[MeliDevLoginViewController alloc] initWithRedirectUrl: _redirectUrl];
        loginViewController.appId = _clientId;
        
        loginViewController.onLoginCompleted = ^(NSDictionary *data){
            [data setValue: _clientId forKey:MELI_APP_ID_KEY];
            [MeliDevIdentity createIdentity:data];
        };
        
        loginViewController.onErrorDetected = ^(NSString *error){
            NSLog(@"%@", error);
        };
        
        [clientViewController.navigationController pushViewController:loginViewController animated:YES];
}

@end
