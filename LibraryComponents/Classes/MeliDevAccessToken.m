//
//  MeliDevAccessToken.m
//  Pods
//
//  Created by Ignacio Giagante on 1/9/16.
//
//

#import "MeliDevAccessToken.h"

@interface MeliDevAccessToken ()

@property (nonatomic, strong) NSDate * tokenDateExpiration;

@end

@implementation MeliDevAccessToken

- (instancetype) initWithMeliDevAccessToken: (NSString *) token andExpiresIn: (NSString *) expiresIn {
    
    self = [super init];
    if(self) {
        _accessTokenValue = token;
        _tokenDateExpiration = [NSDate dateWithTimeIntervalSinceNow:([expiresIn doubleValue])];
    }
    return self;
}

- (BOOL) isTokenExpired {
    return [[NSDate date] timeIntervalSinceDate:self.tokenDateExpiration] > 0;
}

@end
