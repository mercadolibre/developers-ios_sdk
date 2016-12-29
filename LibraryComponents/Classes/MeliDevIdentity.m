//
//  MeliDevIdentity.m
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import "MeliDevIdentity.h"
#import "Meli.h"

static NSString * const APP_ID = @"app_id";
static NSString * const ACCESS_TOKEN = @"access_token";
static NSString * const EXPIRES_IN = @"expires_in";
static NSString * const USER_ID = @"user_id";

@interface MeliDevIdentity()

@property (copy, nonatomic) NSString * userId;
@property (nonatomic, strong, copy) MeliDevAccessToken * accessToken;

@end

@implementation MeliDevIdentity

- (NSString *) accessTokenValue {
    return [self.accessToken accessTokenValue];
}

+ (BOOL) identityCanBeCreated: (NSDictionary *) data {
    return [data objectForKey:USER_ID] != nil && [data objectForKey:ACCESS_TOKEN] != nil && [data objectForKey:EXPIRES_IN] != nil;
}

+ (BOOL) createIdentity:(NSDictionary *) loginData appId: (NSString *) appId {
    
    if([self identityCanBeCreated:loginData]) {
        
        MeliDevIdentity * identity = [[MeliDevIdentity alloc]init];
        identity.userId = [loginData valueForKey:USER_ID];
        
        NSString * accessTokenValue = [loginData valueForKey:ACCESS_TOKEN];
        NSString * expiresInValue = [loginData valueForKey:EXPIRES_IN];
        
        MeliDevAccessToken *accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresInValue];
        identity.accessToken = accessToken;
        
        [identity storeIdentityWithClientId: appId];
        
        return YES;
    }
    
    return NO;
}

- (void) storeIdentityWithClientId: (NSString *) appId {
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    
    [defaults setValue: appId forKey: APP_ID];
    [defaults setValue: self.userId forKey: USER_ID];
    [defaults setValue: [self.accessToken accessTokenValue] forKey: ACCESS_TOKEN];
    [defaults setValue: [self.accessToken expiresIn] forKey: EXPIRES_IN];
    
    NSLog(@"%@", @"The identity was saved correctly");
}

+ (MeliDevIdentity *) restoreIdentity: (NSString *) clientId {
    
    MeliDevIdentity * identity = nil;

    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSString *clientIdSaved = [defaults valueForKey: APP_ID];
    
    // check if the clientId was modified
    if(![clientIdSaved isEqualToString:clientId]) {
        return nil;
    }
    
    NSString * accessTokenValue = [defaults valueForKey:ACCESS_TOKEN];
    NSString * expiresInValue = [defaults valueForKey:EXPIRES_IN];
    
    MeliDevAccessToken *accessToken = [[MeliDevAccessToken alloc] initWithMeliDevAccessToken:accessTokenValue andExpiresIn:expiresInValue];
    
    if(![accessToken isTokenExpired]) {
        identity = [[MeliDevIdentity alloc]init];
        identity.userId = [defaults valueForKey: USER_ID];
        identity.accessToken = accessToken;
    }
    return identity;
}

@end
