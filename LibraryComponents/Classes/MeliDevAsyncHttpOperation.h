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
 *  @param operation
 *  @param responseObject
 */
typedef void (^AsyncHttpOperationSuccessBlock) (NSURLSessionTask *operation, id responseObject);

/**
 *  Block used as a callback when the http request has failed.
 *
 *  @param operation
 *  @param error
 */
typedef void (^AsyncHttpOperationFailBlock) (NSURLSessionTask *operation, NSError *error);

/**
 *  Block used as a callback when the http request (POST or PUT) was success.
 *
 *  @param response
 *  @param responseObject
 *  @param error
 */
typedef void (^AsyncHttpOperationBlock) (NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error);

@interface MeliDevAsyncHttpOperation : MeliDevHttpOperation

- (void) get: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureBlock;
- (void) getWithAuth: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureHandler;
- (void) post: (NSString *)path withBody:(NSData *) body completionHandler:(AsyncHttpOperationBlock) completionHandler;
- (void) put: (NSString *)path withBody:(NSData *) body completionHandler:(AsyncHttpOperationBlock) completionHandler;
- (void) delete: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureBlock;

@end
