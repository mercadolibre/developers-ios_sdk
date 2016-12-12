//
//  MeliDevAccessToken.h
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import <Foundation/Foundation.h>

/**
 *  Model class that contains information about the Access Token that is
 *  provided by the MercadoLibre Oauth API.
 */
@interface MeliDevAccessToken : NSObject

@property (copy) NSString * accessTokenValue;
@property (copy) NSString * expiresInValue;

/**
 *  Create a MeliDevAccessToken instance.
 *
 *  @param token                    represents the token value.
 *  @param expiresIn                represents the token's expiration time.
 */
- (instancetype) initWithMeliDevAccessToken: (NSString *) token andExpiresIn: (NSString *) expiresIn;

/**
 *  Verify if the token has been expired.
 *
 */
- (BOOL) isTokenExpired;

@end
