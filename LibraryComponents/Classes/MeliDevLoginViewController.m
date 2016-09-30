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

NSString * const LOGIN_URL = @"http://auth.mercadolibre.com/authorization?response_type=token&client_id=";
NSString * const CALLBACK_LOGIN = @"login";
NSString * const CALLBACK_MESSAGE_DISPATCH = @"background_message_dispatch";

@interface MeliDevLoginViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) MBProgressHUD *HUD;
@property (nonatomic) MeliDevIdentity * identity;
@property (copy) NSString * redirectUrl;

@end

@implementation MeliDevLoginViewController

- (instancetype) initWithRedirectUrl: (NSString *) redirectUrl {
    
    self = [super init];
    if (self) {
        _redirectUrl = redirectUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.delegate = self;
    _webView.opaque = NO;
    _webView.backgroundColor = [UIColor colorWithRed: 1.0f green: 1.0f blue: 0.0f alpha:1.0f];
    
    NSString *urlLogin = [LOGIN_URL stringByAppendingString:_appId];
    NSURL *url = [NSURL URLWithString:urlLogin];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.layer.zPosition = 1;
    
    [_webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *urlString = url.absoluteString;
    
    if([urlString containsString:self.redirectUrl]) {
        NSArray * urlParts = [urlString componentsSeparatedByString:@"#"];
        [self getIdentityData: urlParts[1]];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if([urlString containsString: CALLBACK_LOGIN] || [urlString containsString: CALLBACK_MESSAGE_DISPATCH]) {
        [self.HUD hideAnimated:TRUE];
    }
    return YES;
}

- (void) getIdentityData: (NSString *) urlParams {
    
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [urlParams componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }

    if([queryStringDictionary count] != 0 && [self checkIfPropertiesExist:queryStringDictionary]) {
        self.onLoginCompleted(queryStringDictionary);
    } else {
        self.onErrorDetected(@"Something was wrong!");
    }
    
    [self.HUD hideAnimated:TRUE];
}

- (BOOL) checkIfPropertiesExist: (NSDictionary *) data {
    BOOL test = [data objectForKey:USER_ID] != nil && [data objectForKey:ACCESS_TOKEN] != nil && [data objectForKey:EXPIRES_IN] != nil;
    return test;
}

@end
