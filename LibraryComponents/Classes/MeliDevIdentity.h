//
//  MeliDevIdentity.h
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevAccessToken.h"

/**
 * Model class that represents the identity of the user. It contains
 * information related to the user and the access tokens granted to the client
 * application.
 */
@interface MeliDevIdentity : NSObject

/**
 *  Represent the application identifier provided by the client application.
 */
@property (nonatomic, readonly) NSString * clientId;

/**
 *  Represent the user identifier who provides permissions to the client application.
 */
@property (nonatomic, readonly) NSString * userId;

@property (nonatomic, strong, readonly) MeliDevAccessToken * accessToken;

/**
 *  Create an Identity and store it in User Defaults.
 *
 *  @param loginData                    data related to login process
 */
+ (BOOL) createIdentity:(NSDictionary *) loginData clientId: (NSString *) clientId;

/**
 *  Attempt to restore the identity from User Defaults. In case the App Id was changed after an Identity was stored,
 *  it will be return nil.
 *
 *  @param clientId                    represents the app id's client
 */
+ (MeliDevIdentity *) restoreIdentity: (NSString *) clientId;

/**
 *  Retrieve Access Token Value.
 *
 */
- (NSString *) accessTokenValue;

@end
