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

static NSString const * SDK_IS_NOT_INITIALIZED = @"The SDK should be initialized";


@implementation Meli

static NSString * _clientId;
static NSString * _redirectUrl;

static MeliDevIdentity * identity;
static NSDictionary *dictionary;
static BOOL isSDKInitialized = NO;
    
static MeliDevAsyncHttpOperation * meliDevAsyncHttpOperation;
static MeliDevSyncHttpOperation * meliDevSyncHttpOperation;

+ (MeliDevIdentity *) getIdentity {
    
    if(!identity) {
        
        identity = [MeliDevIdentity restoreIdentity: _clientId];
        
        if(identity) {
            
            meliDevSyncHttpOperation = [[MeliDevSyncHttpOperation alloc] initWithIdentity: identity];
            meliDevAsyncHttpOperation = [[MeliDevAsyncHttpOperation alloc] initWithIdentity: identity];
        }
    }
    
    return identity;
}

+ (NSString *) getClientId {
    return _clientId;
}

+ (NSString *) getRedirectUrl {
    return _redirectUrl;
}

+ (void) startSDK: (NSString *) clientId withRedirectUrl:(NSString *) redirectUrl error:(NSError **) error {
    
    [self verifyAppID:clientId error: error];
    [self verifyRedirectUrl:redirectUrl error: error];
    
    _clientId = clientId;
    _redirectUrl = redirectUrl;
    
    if(*error == nil) {
        isSDKInitialized = YES;
    }
}

+ (void) verifyAppID: (NSString *) appId error:(NSError **) error {
    
    if(appId == nil) {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: APP_ID_NOT_DEFINED_KEY};
        
        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:AppIdIsNotInitializedError
                                 userInfo:userInfo];
    }
    
    if( ![MeliDevUtils isNumeric: appId] ) {
        
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
    }
    
    if( ![MeliDevUtils validateUrl: redirectUrl] ) {
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: REDIRECT_URL_IS_NOT_VALID_KEY};
        
        *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:RedirectUrlNotValidError
                                 userInfo:userInfo];
    }
}

+ (void) startLogin: (UIViewController *) clientViewController withSuccesBlock: (void (^)()) successBlock withErrorBlock: (void (^)(NSString *)) errorBlock {
    
    if(isSDKInitialized) {
        MeliDevLoginViewController * loginViewController = [[MeliDevLoginViewController alloc] initWithAppId: _clientId
                                                                                          andRedirectUrl: _redirectUrl];
        loginViewController.onLoginCompleted = ^(){
            NSLog(@"Meli login successful");
            successBlock();
        };
        
        loginViewController.onErrorDetected = ^(NSString *error){
            NSLog(@"Something was wrong. %@", error);
            errorBlock(error);
        };
        
        [clientViewController.navigationController pushViewController:loginViewController animated:YES];
    } else {
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: SDK_IS_NOT_INITIALIZED};
        NSError *error = [NSError errorWithDomain:MeliDevErrorDomain
                                     code:SdkIsNotInitialized
                                 userInfo:userInfo];
        errorBlock(error);
    }
}

+ (NSString *) get: (NSString *)path error: (NSError **) error {

    return [meliDevSyncHttpOperation get:path error:&error];
}
    
+ (NSString *) getAuth: (NSString *)path error: (NSError **) error {
    
    return [meliDevSyncHttpOperation getWithAuth:path error:&error];
}
    
+ (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    return [meliDevSyncHttpOperation post:path withBody:body error:&error];
}
    
+ (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    return [meliDevSyncHttpOperation put:path withBody:body error:&error];
}

+ (NSString *) delete: (NSString *)path error: (NSError **) error {
    
    return [meliDevSyncHttpOperation delete:path error:&error];
}
    

+ (void) asyncGet: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureBlock; {
    
    [meliDevAsyncHttpOperation get:path successBlock:successBlock failureBlock:failureBlock];
}
    
+ (void) asyncGetAuth: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureBlock; {
    
    [meliDevAsyncHttpOperation getWithAuth:path successBlock:successBlock failureBlock:failureBlock];
}
    
+ (void) asyncPost: (NSString *)path withBody:(NSData*) body operationBlock:(AsyncHttpOperationBlock) operationBlock {
    
    [meliDevAsyncHttpOperation post:path withBody:body operationBlock: operationBlock];
}

+ (void) asyncPut: (NSString *)path withBody:(NSData*) body operationBlock:(AsyncHttpOperationBlock) operationBlock; {
    
    [meliDevAsyncHttpOperation put:path withBody:body operationBlock:operationBlock];
}
    
+ (void) asyncDelete: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureBlock {
    
    [meliDevAsyncHttpOperation delete:path successBlock:successBlock failureBlock:failureBlock];
}

@end
