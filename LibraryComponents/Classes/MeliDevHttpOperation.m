//
//  MeliDevHttpOperation.m
//  Pods
//
//  Created by Ignacio Giagante on 20/12/16.
//
//

#import "MeliDevHttpOperation.h"
#import "MeliDevIdentity.h"


@implementation MeliDevHttpOperation
    
- (instancetype) initWithIdentity: (MeliDevIdentity *) identity {
    
    self = [super init];
    if (self) {
        _identity = identity;
    }
    return self;
}
    
- (NSURL *) getURLWithAccessToken: (NSString *) path {
    
    NSString * url = [MELI_API_URL stringByAppendingString:path];
    url = [url stringByAppendingString: @"?access_token="];
    url = [url stringByAppendingString: self.identity.accessTokenValue];
    
    return [NSURL URLWithString: url];
}
    
@end
