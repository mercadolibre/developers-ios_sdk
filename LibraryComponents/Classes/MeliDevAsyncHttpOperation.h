//
//  MeliDevAsyncHttpOperation.h
//  Pods
//
//  Created by Ignacio Giagante on 21/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevIdentity.h"

/**
 *  Block used as a callback when the http request was success.
 *
 *  @param task
 *  @param responseObject
 */
typedef void (^SuccessHandler) (NSURLSessionTask *task, id responseObject);

/**
 *  Block used as a callback when the http request has failed.
 *
 *  @param operation
 *  @param error
 */
typedef void (^FailureHandler) (NSURLSessionTask *operation, NSError *error);

@interface MeliDevAsyncHttpOperation : NSObject

@property (nonatomic) MeliDevIdentity * identity;

/**
 *  Create a MeliDevSyncHttpOperation instance.
 *
 *  @param identity       Model that represents user's identification.
 */
- (instancetype) initWithIdentity: (MeliDevIdentity *) identity;

- (void) get: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder:(FailureHandler) failureHandler;
- (void) getWithAuth: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder:(FailureHandler) failureHandler;
- (void) post: (NSString *)path withBody:(NSDictionary *)params successHandler:(SuccessHandler) successHandler failureHanlder: (FailureHandler) failureHandler;
- (void) put: (NSString *)path withBody:(NSDictionary *)params successHandler:(SuccessHandler) successHandler failureHanlder: (FailureHandler) failureHandler;
- (void) delete: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder:(FailureHandler) failureHandler;

@end
