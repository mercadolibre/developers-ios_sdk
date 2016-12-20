//
//  MeliDevHttpOperation.h
//  Pods
//
//  Created by Ignacio Giagante on 20/12/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevIdentity.h"

static NSString * const MELI_API_URL = @"https://api.mercadolibre.com";
static NSString const * MELI_IDENTITY_NIL_MESSAGE = @"Meli Identity is nil";
static NSString * const HTTP_REQUEST_ERROR_MESSAGE = @"Error getting %@, HTTP status code %li";


@interface MeliDevHttpOperation : NSObject
    
    /**
     *  Create a MeliDevSyncHttpOperation instance.
     *
     *  @param identity                  Model that represents user's identification.
     */
- (instancetype) initWithIdentity: (MeliDevIdentity *) identity;
    
- (NSURL *) getURLWithAccessToken: (NSString *) path;
    
- (NSMutableURLRequest *) prepareRequest: (NSString *)type withBody: (NSData *)body;
    
@end
