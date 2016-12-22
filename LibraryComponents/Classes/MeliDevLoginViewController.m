//
//  MeliDevLoginViewController.m
//  Pods
//
//  Created by Ignacio Giagante on 12/9/16.
//
//

#import "MeliDevLoginViewController.h"
#import "MeliDevIdentity.h"
#import "MBProgressHUD.h"

const NSString * LOGIN_URL = @"http://auth.mercadolibre.com/authorization?response_type=token&client_id=";
const NSString * CALLBACK_LOGIN = @"login";
const NSString * CALLBACK_MESSAGE_DISPATCH = @"background_message_dispatch";

@interface MeliDevLoginViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
    
@property (strong, nonatomic) MBProgressHUD *HUD;
    
@property (nonatomic) MeliDevIdentity * identity;
    
/**
 *  Represent the application identifier provided by the client application.
 */
@property (copy) NSString * appId;
  
/**
 *  Represent the application's redirect URL provided by the client application.
 */
@property (copy) NSString * redirectUrl;

- (void *) createParamDictionary: (NSString *) urlString;

@end

@implementation MeliDevLoginViewController

- (instancetype) initWithAppId: (NSString *) appId andRedirectUrl: (NSString *) redirectUrl {
    
    self = [super init];
    if (self) {
        _appId = appId;
        _redirectUrl = redirectUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor colorWithRed: 1.0f green: 1.0f blue: 0.0f alpha:1.0f];
    
    NSString *urlLogin = [LOGIN_URL stringByAppendingString: self.appId];
    NSURL *url = [NSURL URLWithString:urlLogin];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.layer.zPosition = 1;
    
    [_webView loadRequest:urlRequest];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *urlString = url.absoluteString;
    
    if([urlString containsString:self.redirectUrl]) {
        NSArray * urlParts = [urlString componentsSeparatedByString:@"#"];
        if (urlParts != nil && [urlParts count] > 1) {
            [self getIdentityData: urlParts[1]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    if([urlString containsString: CALLBACK_LOGIN] || [urlString containsString: CALLBACK_MESSAGE_DISPATCH]) {
        [self.HUD hideAnimated:TRUE];
    }
    return YES;
}

- (void *) getIdentityData: (NSString *) urlParams {
    
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [urlParams componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }

    if([queryStringDictionary count] != 0 && [self checkIfUserPropertiesExist:queryStringDictionary]) {
        self.onLoginCompleted(queryStringDictionary);
    } else {
        self.onErrorDetected(@"Something was wrong!");
    }
    
    [self.HUD hideAnimated:TRUE];
}

- (BOOL) checkIfUserPropertiesExist: (NSDictionary *) data {
    return [data objectForKey:USER_ID] != nil && [data objectForKey:ACCESS_TOKEN] != nil && [data objectForKey:EXPIRES_IN] != nil;
}

@end
