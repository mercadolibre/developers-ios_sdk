//
//  MeliDevSyncHttpOperation.h
//  Pods
//
//  Created by Ignacio Giagante on 16/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MeliDevHttpOperation.h"

@interface MeliDevSyncHttpOperation : MeliDevHttpOperation

/**
 *  Create and setup a request with a specific http method and its body.
 *
 *  @param method                    represents the http method.
 *  @param body                      represents the data that user wants to send.
 */
- (NSMutableURLRequest *) prepareRequest: (NSString *)method withBody: (NSData *)body;

- (NSString *) get: (NSString *)path error: (NSError **) error;
- (NSString *) getWithAuth: (NSString *)path error: (NSError **) error;
- (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error;
- (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error;
- (NSString *) delete: (NSString *)path error: (NSError **) error;

@end
