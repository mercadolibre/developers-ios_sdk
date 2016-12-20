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
    
@property (nonatomic, weak) AFHTTPSessionManager *manager;
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

- (void) post: (NSString *)path withBody:(NSData *)body successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler; {

    NSURL *URL = [self getURLWithAccessToken:path];
    
    NSMutableURLRequest *request = [self createRequest:body withMethod:@"POST" withURL:URL.absoluteString];

    [[self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}

- (void) put: (NSString *)path withBody:(NSData *) body successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler; {

    NSURL *URL = [self getURLWithAccessToken:path];
    
    NSMutableURLRequest *request = [self createRequest:body withMethod:@"PUT" withURL:URL.absoluteString];
    
    [[self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
}
    
- (NSMutableURLRequest *) createRequest: (NSData *) body withMethod: (NSString *)method withURL: (NSString *) url {

    NSError *error;
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}
    
- (void) delete: (NSString *)path successBlock:(AsyncHttpOperationSuccessBlock) successHandler failureBlock:(AsyncHttpOperationFailBlock) failureHandler; {
    
    NSURL *URL = [self getURLWithAccessToken:path];
    
    [self.manager DELETE:URL.absoluteString parameters:nil success:(AsyncHttpOperationSuccessBlock) successHandler failure:failureHandler];
}

@end
