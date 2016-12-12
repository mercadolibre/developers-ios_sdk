//
//  MeliDevUtils.h
//  Pods
//
//  Created by Ignacio Giagante on 15/9/16.
//
//

#import <Foundation/Foundation.h>

@interface MeliDevUtils : NSObject

/**
 *  Used to validate if an url is valid.
 *
 *  @param candidate
 */
+ (BOOL) validateUrl: (NSString *) candidate;

/**
 *  Used to validate if a string is numeric.
 *
 *  @param candidate
 */
+ (BOOL) isNumeric: (NSString *) candidate;

@end
