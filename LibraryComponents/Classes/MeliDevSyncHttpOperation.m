//
//  MeliDevSyncHttpOperation.m
//  Pods
//
//  Created by Ignacio Giagante on 16/9/16.
//
//

#import "MeliDevSyncHttpOperation.h"
#import "MeliDevErrors.h"

@implementation MeliDevSyncHttpOperation

- (MeliDevError *) getErrorForStatusCode: (NSInteger *) statusCode {
    return (statusCode == 401) ? InvalidAccessToken : HttpRequestError;
}
    
- (NSError *) errorForStatusCode: (NSInteger *) responseStatusCode withURL: (NSString *) url {
        
    NSString * requestError = [NSString stringWithFormat:HTTP_REQUEST_ERROR_MESSAGE, url, responseStatusCode];
        
    NSLog(HTTP_REQUEST_ERROR_MESSAGE, url, responseStatusCode);
        
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: requestError};
        
    NSError *error = [NSError errorWithDomain:MeliDevErrorDomain
                                             code:[self getErrorForStatusCode: responseStatusCode]
                                         userInfo:userInfo];
    return error;
}

- (NSString *) execute: (NSMutableURLRequest *)request error: (NSError **) error {
    
    NSHTTPURLResponse *responseCode;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    NSInteger responseStatusCode = [responseCode statusCode];
    NSString *responseData = nil;
    
    if((responseStatusCode == 200 || responseStatusCode == 201)){
        responseData = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        *error = nil;
    } else {
        *error = [self errorForStatusCode: responseStatusCode withURL:[request URL]];
    }
    
    return responseData;
}

- (NSString *) get: (NSString *)path error: (NSError **) error {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    return [self execute:request error:&error];
}

- (NSString *) getWithAuth: (NSString *)path error: (NSError **) error {
  
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:&error];
}

- (NSString *) delete: (NSString *)path error: (NSError **) error {

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"DELETE"];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:&error];
}

- (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    NSMutableURLRequest *request = [self prepareRequest:@"POST" withBody:body];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:&error];
}

- (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error {
    
    NSMutableURLRequest *request = [self prepareRequest:@"PUT" withBody:body];
    [request setURL:[self getURLWithAccessToken:path]];
    
    return [self execute:request error:&error];
}

@end
