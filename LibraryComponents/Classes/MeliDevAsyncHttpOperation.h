//
//  MeliDevAsyncHttpOperation.h
//  Pods
//
//  Created by Ignacio Giagante on 21/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevHttpOperation.h"

/**
 *  Block used as a callback when the http request was success.
 *
 *  @param task
 *  @param responseObject
 */
typedef void (^AsyncHttpOperationSuccessBlock) (NSURLSessionTask *task, id responseObject);

/**
 *  Block used as a callback when the http request has failed.
 *
 *  @param operation
 *  @param error
 */
typedef void (^AsyncHttpOperationFailBlock) (NSURLSessionTask *operation, NSError *error);

@interface MeliDevAsyncHttpOperation : MeliDevHttpOperation

- (void) get: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler;
- (void) getWithAuth: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler;
- (void) post: (NSString *)path withBody:(NSData *) body successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler;
- (void) put: (NSString *)path withBody:(NSData *) body successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler;
- (void) delete: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler;

@end
