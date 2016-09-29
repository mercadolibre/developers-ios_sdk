//
//  MeliDevIdentity.m
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import "MeliDevIdentity.h"
#import "Meli.h"

@implementation MeliDevIdentity

- (NSString *) getMeliDevAccessTokenValue {
    return _accessToken.accessTokenValue;
}

+ (void) createIdentity:(NSDictionary *) loginData {
    
    MeliDevIdentity * identity = [[MeliDevIdentity alloc]init];
    identity.userId = [loginData valueForKey:USER_ID];
    
    NSString * accessTokenValue = [loginData valueForKey:ACCESS_TOKEN];
    NSString * expiresInValue = [loginData valueForKey:EXPIRES_IN];
    
    MeliDevAccessToken *accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresInValue];
    identity.accessToken = accessToken;
    
    identity.clientId = [loginData valueForKey: MELI_APP_ID_KEY];
    
    [identity storeIdentity];
}

- (void) storeIdentity {
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    
    [defaults setValue:_clientId forKey:CLIENT_ID];
    [defaults setValue:_userId forKey:USER_ID];
    [defaults setValue:_accessToken.accessTokenValue forKey:ACCESS_TOKEN];
    [defaults setValue:_accessToken.expiresInValue forKey:EXPIRES_IN];
    
    NSLog(@"Client Id: %@", _clientId);
    NSLog(@"Access Token: %@", _accessToken.accessTokenValue);
    NSLog(@"Expires In: %@", _accessToken.expiresInValue);
    NSLog(@"%@", @"The identity was saved correctly");
}

+ (MeliDevIdentity *) restoreIdentity: (NSString *) clientId {

    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSString *clientIdSaved = [defaults valueForKey: CLIENT_ID];
    
    // check if the clientId was modified
    if(![clientIdSaved isEqualToString:clientId]) {
        return nil;
    }
    
    MeliDevIdentity * identity = [[MeliDevIdentity alloc]init];
    identity.clientId = clientId;
    
    NSString * accessTokenValue = [defaults valueForKey:ACCESS_TOKEN];
    NSString * expiresInValue = [defaults valueForKey:EXPIRES_IN];
    
    MeliDevAccessToken *accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresInValue];
    identity.accessToken = accessToken;
    
    if([accessToken isTokenExpired]) {
        identity = nil;
    }
    
    return identity;
}

@end
