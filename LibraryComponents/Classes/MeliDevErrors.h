//
//  MeliDevErrors.h
//  Pods
//
//  Created by Ignacio Giagante on 16/9/16.
//
//

static NSString * const MeliDevErrorDomain = @"com.MeliDev.ErrorDomain";


/**
 *  Error cause.
 *
 *  AppIdNotValidError: when the app id is not valid. It should be numeric.
 *  RedirectUrlNotValidError: when the redirect url is not valid.
 *  AppIdIsNotInitializedError: when the app id is not initialized. The cliend does not provide the app id.
 *  RedirectUrlIsNotInitializedError: when the app id is not initialized. The cliend does not provide the redirect url.
 *  HttpRequestError: when some error happens during a http request.
 *  MeliIdentityIsNil: when the identity was not created before trying to execute a task.
 *  InvalidAccessToken: when the access token is wrong.
 */
typedef NS_ENUM(NSInteger, MeliDevError) {
    AppIdNotValidError,
    RedirectUrlNotValidError,
    AppIdIsNotInitializedError,
    RedirectUrlIsNotInitializedError,
    HttpRequestError,
    MeliIdentityIsNil,
    InvalidAccessToken,
};
