//
//  MeliDevIdentity.m
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import "MeliDevIdentity.h"
#import "Meli.h"

@interface MeliDevIdentity()
    
@property (nonatomic, copy) NSString * clientId;
@property (copy, nonatomic) NSString * userId;
@property (nonatomic, strong, copy) MeliDevAccessToken * accessToken;

@end

@implementation MeliDevIdentity

- (NSString *) getMeliDevAccessTokenValue {
    return [self.accessToken getAccessTokenValue];
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
    
    NSLog(@"%@", @"The identity was saved correctly");
}

+ (MeliDevIdentity *) restoreIdentity: (NSString *) clientId {
    
    MeliDevIdentity * identity = nil;

    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSString *clientIdSaved = [defaults valueForKey: CLIENT_ID];
    
    // check if the clientId was modified
    if(![clientIdSaved isEqualToString:clientId]) {
        return nil;
    }
    
    NSString * accessTokenValue = [defaults valueForKey:ACCESS_TOKEN];
    NSString * expiresInValue = [defaults valueForKey:EXPIRES_IN];
    
    MeliDevAccessToken *accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresInValue];
    
    if(![accessToken isTokenExpired]) {
        identity = [[MeliDevIdentity alloc]init];
        NSString *userId = [defaults valueForKey: USER_ID];
        identity.clientId = clientId;
        identity.userId = userId;
        identity.accessToken = accessToken;
    }
    return identity;
}

@end
