//
//  MeliDevSDKExampleViewController.m
//  MeliDevSDK
//
//  Created by Ignacio Giagante on 26/8/16.
//  Copyright © 2016 Mercado Libre. All rights reserved.
//

#import "MeliDevSDKExampleViewController.h"
#import "MeliDevLoginViewController.h"
#import "Meli.h"
#import "MeliDevIdentity.h"
#import "MeliDevASyncHttpOperation.h"
#import "MeliDevSyncHttpOperation.h"
#import "MeliDevErrors.h"

static NSString * CLIENT_ID_VALUE = @"5197208004815569";
static NSString * REDIRECT_URL_VALUE = @"https://www.example.com";

@interface MeliDevSDKExampleViewController ()

@property MeliDevIdentity *identity;

@property (copy) NSString * result;
@property (nonatomic) NSError * error;

@end

@implementation MeliDevSDKExampleViewController

- (void)viewDidLoad {
    
    NSError *error;
    [Meli initializeSDK: CLIENT_ID_VALUE withRedirectUrl: REDIRECT_URL_VALUE error:&error];
    
    if(error) {
        NSLog(@"Domain: %@", error.domain);
        NSLog(@"Error Code: %ld", error.code);
        NSLog(@"Description: %@", [error localizedDescription]);
    }
    
    [super viewDidLoad];
}
    
- (IBAction)login:(id)sender {
    
    [Meli startLogin:self withSuccesBlock:^{
        
        NSLog(@"Login success");
        self.identity = [Meli getIdentity];
        
    } withErrorBlock:^(NSError * error) {
        NSLog(@"Login Fail %@", error);
    }];
}

- (IBAction)getUserItems:(id)sender {

    [self getUsersItemsAsync];
}

- (void) processError: (NSURLSessionTask *) operation error:(NSError *)error {
    
    if(operation) {
        NSURLRequest * request = operation.currentRequest;
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
        
        NSString * requestError = [NSString stringWithFormat: HTTP_REQUEST_ERROR_MESSAGE, [request URL],
                                   (long)[httpResponse statusCode] ];
        
        NSLog(@"Http request error %@", requestError);
    } else {
        NSLog(@"Error: %@ ", [error userInfo] );
    }
}

- (void) parseData: (id) responseObject {
    
    NSArray *jsonArray = (NSArray *) responseObject;
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonArray options:NSJSONWritingPrettyPrinted error:&error];
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Result %@", result);
}
    
- (void) getSitesAsync {
    
    NSString *path = @"/sites/";
        
    AsyncHttpOperationSuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
        [self parseData:responseObject];
    };
        
    AsyncHttpOperationFailBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
        if(error) {
            [self processError:operation error:error];
        }
    };
        
    [Meli asyncGet:path successBlock:successBlock failureBlock:failureBlock];
}

- (void) getUsersItemsAsync {
    
    MeliDevIdentity * identity = [Meli getIdentity];
    
    if(identity) {
        
        NSString *userPath = [@"/users/" stringByAppendingString: identity.userId];
        NSString *path = [userPath stringByAppendingString: @"/items/search"];
        
        AsyncHttpOperationSuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
            [self parseData:responseObject];
        };
        
        AsyncHttpOperationFailBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
            if(error) {
                [self processError:operation error:error];
            }
        };
        
        [Meli asyncGetAuth:path withIdentity: identity successBlock:successBlock failureBlock:failureBlock];
    }
}

- (void) testPostAsync {
    
    NSString *path = @"/items";
    
    NSError *error;
    NSData * body = [NSJSONSerialization JSONObjectWithData:[self createJsonDataForPost] options:kNilOptions error:&error];
    
    AsyncHttpOperationBlock operationBlock = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    };
    
    [Meli asyncPost:path withBody:body withIdentity: [Meli getIdentity] operationBlock:operationBlock];
}

- (void) testPutAsync {
    
    NSString *path = @"/items/#{ITEM_ID}";
    
    NSError *error;
    NSData * body = [NSJSONSerialization JSONObjectWithData:[self createJsonDataForPut] options:kNilOptions error:&error];
    
    AsyncHttpOperationBlock operationBlock = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    };
    
    [Meli asyncPut:path withBody:body withIdentity: [Meli getIdentity] operationBlock:operationBlock];
}
    
- (void) testDeleteAsync {
    
    NSString *path = @"/questions/#{QUESTION_ID}";
        
    AsyncHttpOperationSuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
        [self parseData:responseObject];
    };
    
    AsyncHttpOperationFailBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
        if(error) {
            [self processError:operation error:error];
        }
    };
    
    [Meli asyncDelete:path withIdentity: [Meli getIdentity] successBlock:successBlock failureBlock:failureBlock];
}
    
- (void) processOut: (NSString *)result withError: (NSError **) error {
    
    if(*error != nil) {
        NSLog(@"Http request error %@", [*error userInfo]);
    } else {
        NSLog(@"Result %@", result);
    }
}
    
- (void) getSites {
    
    NSError *error;
    NSString *path = @"/sites/";
    
    NSString * result = [Meli get:path error: &error];
    [self processOut:result withError: &error];
}

- (void) getUsersItems {
    
    MeliDevIdentity * identity = [Meli getIdentity];
    
    NSError *error;

    NSString *userPath = [@"/users/" stringByAppendingString: identity.userId];
    NSString *path = [userPath stringByAppendingString: @"/items/search"];
    
    NSString * result = [Meli getAuth:path withIdentity: [Meli getIdentity] error: &error];
    
    [self processOut:result withError: &error];
}

- (void) testPostItem {
    
    NSError *error;
    
    NSString *path = @"/items";
    NSString * result = [Meli post:path withBody:[self createJsonDataForPost] withIdentity: [Meli getIdentity] error:&error];
    
    [self processOut:result withError: &error];
}

- (void) testPut {
    
    NSError *error;
    
    NSString *path = @"/items/#{ITEM_ID}";
    NSString * result = [Meli put:path withBody:[self createJsonDataForPut] withIdentity: [Meli getIdentity] error:&error];
    
    [self processOut:result withError: &error];
}

- (void) createQuestion {
    
    NSError *error;
    
    NSString *path = @"/questions/#{ITEM_ID}";
    NSString * result = [Meli post:path withBody:[self createQuestionForDelete] withIdentity: [Meli getIdentity] error:&error];
    
    [self processOut:result withError: &error];
}
    
- (void) testDelete {
    
    NSError *error;
    
    NSString *path = @"/questions/#{QUESTION_ID}";
    NSString * result = [Meli delete:path withIdentity: [Meli getIdentity] error:&error];
    
    [self processOut:result withError: &error];
}

-(NSData *)createJsonDataForPut
{
    //your keys for json
    NSArray * keys = @[@"status"];
    
    //your objects for json
    NSArray * objects = @[@"paused"];
    
    //create dictionary to convert json object
    NSDictionary * jsonData=[[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    
    
    //convert dictionary to json data
    NSData * json =[NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    
    
    //convert json data to string for showing if you create it truely
    NSString * jsonString=[[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",jsonString);
    
    return json;
}

-(NSData *)createJsonDataForPost
{
    //your keys for json
    NSArray * keys = @[@"title",@"category_id", @"price", @"currency_id", @"available_quantity", @"buying_mode",
                     @"listing_type_id", @"condition", @"description", @"video_id", @"warranty", @"pictures", @"attributes"];
    
    //your objects for json
    NSArray * objects = @[@"Item de test - No Ofertar", @"MLA5529", @10, @"ARS", @1, @"buy_it_now", @"bronze",
                        @"new", @"Item:,  Ray-Ban WAYFARER Gloss Black RB2140 901  Model: RB2140. Size: 50mm. Name: WAYFARER. Color: Gloss Black. Includes Ray-Ban Carrying Case and Cleaning Cloth. New in Box",
                        @"YOUTUBE_ID_HERE", @"12 months by Ray Ban",
                        @[
                            @{@"source":@"http://upload.wikimedia.org/wikipedia/commons/f/fd/Ray_Ban_Original_Wayfarer.jpg"},
                            @{@"source":@"http://en.wikipedia.org/wiki/File:Teashades.gif"}
                        ],
                        @[
                              @{@"id":@"83000", @"value_id":@"91993"}
                        ]];
    
    //create dictionary to convert json object
    NSDictionary * jsonData=[[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    
    //convert dictionary to json data
    NSData * json =[NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    
    return json;
}

-(NSData *)createQuestionForDelete
{
    //your keys for json
    NSArray * keys = @[@"item_id",@"text"];
    
    //your objects for json
    NSArray * objects = @[@"#{ITEM_ID}", @"Test question"];
    
    //create dictionary to convert json object
    NSDictionary * jsonData=[[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    
    //convert dictionary to json data
    NSData * json =[NSJSONSerialization dataWithJSONObject:jsonData options:NSJSONWritingPrettyPrinted error:nil];
    
    return json;
}

@end
