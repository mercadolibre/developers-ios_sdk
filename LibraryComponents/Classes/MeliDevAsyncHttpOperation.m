//
//  MeliDevAsyncHttpOperation.m
//  Pods
//
//  Created by Ignacio Giagante on 21/9/16.
//
//

#import "MeliDevAsyncHttpOperation.h"
#import "MeliDevErrors.h"
#import <AFNetworking.h>

@interface MeliDevAsyncHttpOperation ()
    
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic) MeliDevIdentity * identity;
    
@end

@implementation MeliDevAsyncHttpOperation

- (instancetype) initWithIdentity: (MeliDevIdentity *) identity {
    
    self = [super init];
    if (self) {
        _identity = identity;
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void) get: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler; {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    NSURL *URL = [NSURL URLWithString: url];
    
    [self.manager GET:URL.absoluteString parameters:nil progress:nil success: successHandler failure: failureHandler];
}

- (void) getWithAuth: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler; {
    
    NSURL *URL = [self getURLWithAccessToken:path];
    
    [self.manager GET:URL.absoluteString parameters:nil progress:nil success: successHandler failure: failureHandler];
}

- (void) post: (NSString *)path withBody:(NSData *)body completionHandler:(AsyncHttpOperationBlock) completionHandler {

    [self createOrUpdate:path withBody: body withHttpMethod: @"POST" completionHandler:completionHandler];
}
 
- (void) put: (NSString *)path withBody:(NSData *)body completionHandler:(AsyncHttpOperationBlock) completionHandler {

    [self createOrUpdate:path withBody: body withHttpMethod: @"PUT" completionHandler:completionHandler];
}
    
- (void) createOrUpdate: (NSString *) path withBody:(NSData *)body withHttpMethod: (NSString *) method completionHandler:(AsyncHttpOperationBlock) completionHandler {
    
    NSURL *URL = [self getURLWithAccessToken:path];
    
    NSMutableURLRequest *request = [self createRequest:body withHttpMethod:method withURL:URL.absoluteString];
    
    [[self.manager dataTaskWithRequest:request completionHandler:completionHandler] resume];
}
    
- (NSMutableURLRequest *) createRequest: (NSData *) body withHttpMethod: (NSString *)method withURL: (NSString *) url {

    NSError *error;
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}
    
- (void) delete: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successBlock failureBlock:(AsyncHttpOperationFailBlock) failureBlock; {
    
    NSURL *URL = [self getURLWithAccessToken:path];
    
    [self.manager DELETE:URL.absoluteString parameters:nil success:(AsyncHttpOperationSuccessBlock) successBlock failure:failureBlock];
}

@end
