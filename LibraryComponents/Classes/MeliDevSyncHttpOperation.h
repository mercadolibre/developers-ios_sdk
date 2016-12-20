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

- (NSString *) get: (NSString *)path error: (NSError **) error;
- (NSString *) getWithAuth: (NSString *)path error: (NSError **) error;
- (NSString *) delete: (NSString *)path error: (NSError **) error;
- (NSString *) post:(NSString *)path withBody:(NSData *)body error: (NSError **) error;
- (NSString *) put:(NSString *)path withBody:(NSData *)body error: (NSError **) error;

@end
