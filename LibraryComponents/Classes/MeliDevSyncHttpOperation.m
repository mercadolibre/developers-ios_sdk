//
//  MeliDevSyncHttpOperation.m
//  Pods
//
//  Created by Ignacio Giagante on 16/9/16.
//
//

#import "MeliDevSyncHttpOperation.h"
#import "MeliDevErrors.h"

static const NSInteger HTTP_STATUS_CODE_NOT_AUTHORIZED = 401;
static const NSInteger HTTP_STATUS_CODE_OK = 200;
static const NSInteger HTTP_STATUS_CODE_UPDATED = 201;

static NSString * const HTTP_METHOD_GET = @"GET";
static NSString * const HTTP_METHOD_POST = @"POST";
static NSString * const HTTP_METHOD_PUT = @"PUT";
static NSString * const HTTP_METHOD_DELETE = @"DELETE";

@implementation MeliDevSyncHttpOperation

- (NSMutableURLRequest *) prepareRequest: (NSString *)method withBody: (NSData *)body {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:method];
    [request setHTTPBody:body];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long) [body length]] forHTTPHeaderField:@"Content-Length"];
    return request;
}

- (MeliDevError) errorForStatusCode: (NSInteger) statusCode {
    return (statusCode == HTTP_STATUS_CODE_NOT_AUTHORIZED) ? InvalidAccessToken : HttpRequestError;
}
    
- (NSError *) errorForStatusCode: (NSInteger) responseStatusCode withURL: (NSString *) url {
        
    NSString * requestError = [NSString stringWithFormat:HTTP_REQUEST_ERROR_MESSAGE, url, (unsigned long) responseStatusCode];
        
    NSLog(HTTP_REQUEST_ERROR_MESSAGE, url, (unsigned long) responseStatusCode);
        
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: requestError};
        
    NSError *error = [NSError errorWithDomain:MeliDevErrorDomain
                                             code:[self errorForStatusCode: responseStatusCode]
                                         userInfo:userInfo];
    return error;
}

- (NSString *) execute: (NSMutableURLRequest *)request error: (NSError **) error {
    
    NSHTTPURLResponse *responseCode;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:error];
    
    NSInteger responseStatusCode = [responseCode statusCode];
    NSString *result = nil;
    
    if((responseStatusCode == HTTP_STATUS_CODE_OK || responseStatusCode == HTTP_STATUS_CODE_UPDATED)){
        result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        *error = nil;
    } else {
        *error = [self errorForStatusCode: responseStatusCode withURL: [[request URL] absoluteString]];
    }
    
    return result;
}

- (NSString *) get: (NSString *)path error: (NSError **) error {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod: HTTP_METHOD_GET];
    [request setURL:[NSURL URLWithString:url]];
    
    return [self execute:request error:error];
}

- (NSString *) getWithAuth: (NSString *)path error: (NSError **) error {
  
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod: HTTP_METHOD_GET];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:error];
}

- (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    NSMutableURLRequest *request = [self prepareRequest: HTTP_METHOD_POST withBody:body];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:error];
}

- (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    NSMutableURLRequest *request = [self prepareRequest: HTTP_METHOD_PUT withBody:body];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:error];
}

- (NSString *) delete: (NSString *)path error: (NSError **) error {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod: HTTP_METHOD_DELETE];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:error];
}

@end
