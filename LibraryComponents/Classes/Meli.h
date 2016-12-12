//
//  Meli.h
//  Pods
//
//  Created by Ignacio Giagante on 6/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevIdentity.h"

static NSString * const MELI_DEV_SUCCESS = @"success";
static NSString * const MELI_APP_ID_KEY = @"MeliAppId";

@interface Meli : NSObject

/**
 *  Get an Identity if this exists. In the other hand, it returns nil.
 *
 */
+ (MeliDevIdentity *) getIdentity;

/**
 *  Configure values needed by the SDK in order to execute all the tasks.
 *
 *  @param clientId                    represents the application identifier provided by the client application
 *  @param redirectUrl                 represents the application's redirect URL provided by the client application
 */
+ (void) startSDK: (NSString *) clientId withRedirectUrl:(NSString *) redirectUrl error:(NSError **) error;

/**
 *  Starts the Login process by calling the proper SDK behavior. The UIViewController provided
 *  in this method will be used to start the MeliDevLoginViewController. If the process is completed properly, a new
 *  identity will be created and the MeliDevLoginViewController will be poped from navigation view controller's stack. 
 *  In case there was an error, it will be notified through the block onErrorDetected.
 *  Note that if the login process has been executed successfully at least once on the device, an identity exists, so
 *  it should ask for it instead of calling the startLogin method.
 *
 *  @param clientViewController - an UIViewController that will be used as process initializer.
 */
+ (void) startLogin: (UIViewController *) clientViewController;

@end
