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
typedef void (^OnLoginCompleted)(NSDictionary *);

/**
 *  Block used as a callback when the login process has finished with errors.
 *
 *  @param error message
 */
typedef void (^OnLoginErrorDetected)(NSString *);

@interface MeliDevLoginViewController : UIViewController <UIWebViewDelegate>

/**
 *  Represent the application identifier provided by the client application.
 */
@property (copy) NSString * appId;

@property (nonatomic, copy) OnLoginCompleted onLoginCompleted;

@property (nonatomic, copy) OnLoginErrorDetected onErrorDetected;

/**
 *  Create a MeliDevLoginViewController instance.
 *
 *  @param redirectUrl            represents the application's redirect URL provided by the client application.
 */
- (instancetype) initWithRedirectUrl: (NSString *) redirectUrl;

/**
 *  Get Identity data in order to create the Identity.
 *
 *  @param urlParams              represents all the params information needed to create the identity.
 */
- (void) getIdentityData: (NSString *) urlParams;

/**
 *  Check if all properties related to the identity are provided properly.
 *
 *  @param data                    represents the data which will be associated with the Identity Instance.
 */
- (BOOL) checkIfPropertiesExist: (NSDictionary *) data;

@end
