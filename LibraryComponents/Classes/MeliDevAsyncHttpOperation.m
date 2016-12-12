//
//  MeliDevAsyncHttpOperation.m
//  Pods
//
//  Created by Ignacio Giagante on 21/9/16.
//
//

#import "MeliDevAsyncHttpOperation.h"
#import "MeliDevErrors.h"
#import "AFNetworking.h"

NSString * const MELI_API_URL = @"https://api.mercadolibre.com";

@implementation MeliDevAsyncHttpOperation

- (instancetype) initWithIdentity: (MeliDevIdentity *) identity {
    
    self = [super init];
    if (self) {
        _identity = identity;
    }
    return self;
}

- (void) get: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder:(FailureHandler) failureHandler {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    NSURL *URL = [NSURL URLWithString: url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success: successHandler failure: failureHandler];
}

- (void) getWithAuth: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder:(FailureHandler) failureHandler {
    
    NSURL *URL = [self createURL:path];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URL.absoluteString parameters:nil progress:nil success: successHandler failure: failureHandler];
}

- (void) delete: (NSString *)path successHandler:(SuccessHandler) successHandler failureHanlder: (FailureHandler) failureHandler {
    
    NSURL *URL = [self createURL:path];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager DELETE:URL.absoluteString parameters:nil success:(SuccessHandler) successHandler failure:failureHandler];
}

- (void) post: (NSString *)path withBody:(NSDictionary *)params successHandler: (SuccessHandler) successHandler failureHanlder: (FailureHandler) failureHandler {

    NSURL *URL = [self createURL:path];
    
    [[self getManagerWithSerializer] POST:URL.absoluteString parameters:params progress:nil success: successHandler failure: failureHandler];
}

- (void) put: (NSString *)path withBody:(NSDictionary *)params successHandler: (SuccessHandler) successHandler failureHanlder: (FailureHandler) failureHandler {

    NSURL *URL = [self createURL:path];
    
    [[self getManagerWithSerializer] PUT:URL.absoluteString parameters:params success:successHandler failure:failureHandler];
}

- (NSURL *) createURL: (NSString *) path {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    url = [url stringByAppendingString: @"?access_token="];
    url = [url stringByAppendingString: self.identity.getMeliDevAccessTokenValue];
    
    return [NSURL URLWithString: url];
}

- (AFHTTPSessionManager *) getManagerWithSerializer {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    return manager;
}

@end
