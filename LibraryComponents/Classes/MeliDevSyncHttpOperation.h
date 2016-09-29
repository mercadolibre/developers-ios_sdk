//
//  MeliDevSyncHttpOperation.h
//  Pods
//
//  Created by Ignacio Giagante on 16/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevIdentity.h"

static NSString * const MELI_API_URL = @"https://api.mercadolibre.com";
static NSString * const HTTP_REQUEST_ERROR_MESSAGE = @"Error getting %@, HTTP status code %li";

@interface MeliDevSyncHttpOperation : NSObject

@property (nonatomic) MeliDevIdentity * identity;

/**
 *  Create a MeliDevSyncHttpOperation instance.
 *
 *  @param identity                  Model that represents user's identification.
 */
- (instancetype) initWithIdentity: (MeliDevIdentity *) identity;

- (NSString *) get: (NSString *)path error: (NSError **) error;
- (NSString *) getWithAuth: (NSString *)path error: (NSError **) error;
- (NSString *) delete: (NSString *)path error: (NSError **) error;
- (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error;
- (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error;

@end
