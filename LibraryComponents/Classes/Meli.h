//
//  Meli.h
//  Pods
//
//  Created by Ignacio Giagante on 6/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevIdentity.h"
#import "MeliDevAsyncHttpOperation.h"
#import "MeliDevSyncHttpOperation.h"

@interface Meli : NSObject

/**
 *  Get an Identity if this exists. In the other hand, it return nil.
 *
 */
+ (nonnull MeliDevIdentity *) getIdentity;

/**
 *  Configure values needed by the SDK in order to execute all the tasks.
 *
 *  @param clientId                    represents the application identifier provided by the client application
 *  @param redirectUrl                 represents the application's redirect URL provided by the client application
 */
+ (void) initializeSDK: (nonnull NSString *) clientId withRedirectUrl:(nonnull NSString *) redirectUrl error:(NSError * _Nonnull * _Nonnull) error;

/**
 *  Starts the Login process by calling the proper SDK behavior. The UIViewController provided
 *  in this method will be used to start the MeliDevLoginViewController. If the process is completed properly, a new
 *  identity will be created and the MeliDevLoginViewController will be poped from navigation view controller's stack. 
 *  In case there was an error, it will be notify through the block onErrorDetected.
 *  Note that if the login process has been executed successfully at least once on the device, an identity exists, so
 *  it should ask for it instead of calling the startLogin method.
 *
 *  @param clientViewController - an UIViewController that will be used as process initializer.
 *  @param succesBlock - block used as a callback when the login process was success.
 *  @param errorBlock - block used as a callback when the login process has failed.
 */
+ (void) startLogin: (nonnull UIViewController *) clientViewController withSuccesBlock: (nonnull void (^)()) successBlock withErrorBlock: (nonnull void (^)(NSError * _Nonnull)) errorBlock;
    
+ (nullable NSString *) get: (nonnull NSString *)path error: (NSError * _Nonnull * _Nonnull) error;
+ (nullable NSString *) getAuth: (nonnull NSString *)path withIdentity: (MeliDevIdentity * _Nullable) identity error: (NSError * _Nonnull * _Nonnull) error;
+ (nullable NSString *) post:(nonnull NSString *)path withBody:(nonnull NSData *)body withIdentity: (MeliDevIdentity * _Nullable) identity error: (NSError * _Nonnull * _Nonnull) error;
+ (nullable NSString *) put:(nonnull NSString *)path withBody:(nonnull NSData *)body withIdentity: (MeliDevIdentity * _Nullable) identity error: (NSError * _Nonnull * _Nonnull) error;
+ (nullable NSString *) delete: (nonnull NSString *)path withIdentity: (MeliDevIdentity * _Nullable) identity error: (NSError * _Nonnull * _Nonnull) error;
    
+ (void) asyncGet: (nonnull NSString *)path successBlock:(nonnull AsyncHttpOperationSuccessBlock) successBlock failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;
+ (void) asyncGetAuth: (nonnull NSString *)path withIdentity: (MeliDevIdentity * _Nullable) identity successBlock:(nonnull AsyncHttpOperationSuccessBlock) successBlock failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;
+ (void) asyncPost: (nonnull NSString *)path withBody:(nonnull NSData*) body withIdentity: (MeliDevIdentity * _Nullable) identity operationBlock:(nonnull AsyncHttpOperationBlock) operationBlock;
+ (void) asyncPut: (nonnull NSString *)path withBody:(nonnull NSData*) body withIdentity: (MeliDevIdentity * _Nullable) identity operationBlock:(nonnull AsyncHttpOperationBlock) operationBlock;
+ (void) asyncDelete: (nonnull NSString *)path withIdentity: (MeliDevIdentity * _Nullable) identity successBlock:(nonnull AsyncHttpOperationSuccessBlock) successBlock failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;
@end
