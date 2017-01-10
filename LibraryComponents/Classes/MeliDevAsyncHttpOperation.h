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
typedef void (^AsyncHttpOperationSuccessBlock) (NSURLSessionTask * _Nonnull operation, id _Nullable responseObject);

/**
 *  Block used as a callback when the http request has failed.
 *
 *  @param operation
 *  @param error
 */
typedef void (^AsyncHttpOperationFailBlock) (NSURLSessionTask * _Nullable operation, NSError * _Nonnull error);

/**
 *  Block used as a callback when the http request (POST or PUT) was success.
 *
 *  @param response
 *  @param responseObject
 *  @param error
 */
typedef void (^AsyncHttpOperationBlock) (NSURLResponse * _Nullable response, id _Nullable responseObject, NSError * _Nullable error);

@interface MeliDevAsyncHttpOperation : MeliDevHttpOperation

- (void) get: (nonnull NSString *)path successBlock: (nonnull AsyncHttpOperationSuccessBlock) successHandler failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;
- (void) getWithAuth: (nonnull NSString *)path successBlock:(nonnull AsyncHttpOperationSuccessBlock) successBlock failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;
- (void) post: (nonnull NSString *)path withBody:(nonnull NSData *) body operationBlock:(nonnull AsyncHttpOperationBlock) operationBlock;
- (void) put: (nonnull NSString *)path withBody:(nonnull NSData *) body operationBlock:(nonnull AsyncHttpOperationBlock) operationBlock;
- (void) delete: (nonnull NSString *)path successBlock:(nonnull AsyncHttpOperationSuccessBlock) successBlock failureBlock:(nonnull AsyncHttpOperationFailBlock) failureBlock;

@end
