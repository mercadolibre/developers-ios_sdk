//
//  MeliDevLoginViewController.h
//  Pods
//
//  Created by Ignacio Giagante on 12/9/16.
//
//

#import <UIKit/UIKit.h>

/**
 *  Block used as a callback when the login process is completed successfully.
 *
 *  @param dictionary with login's data
 */
typedef void (^OnLoginCompleted)();

/**
 *  Block used as a callback when the login process has finished with errors.
 *
 *  @param error message
 */
typedef void (^OnLoginErrorDetected)(NSError *);

@interface MeliDevLoginViewController : UIViewController

@property (nonatomic, copy) OnLoginCompleted onLoginCompleted;
@property (nonatomic, copy) OnLoginErrorDetected onErrorDetected;

/**
 *  Create a MeliDevLoginViewController instance.
 *
 *  @param appId                    represent the application identifier provided by the client application.
 *  @param redirectUrl              represent the application's redirect URL provided by the client application.
 */
- (instancetype) initWithAppId: (NSString *) appId andRedirectUrl: (NSString *) redirectUrl;

/**
 *  Get Identity data in order to create the Identity.
 *
 *  @param urlParams                    represents all the params information needed to create the identity.
 */
- (void *) getIdentityData: (NSString *) urlParams;

@end
