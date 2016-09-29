#MercadoLibre's iOS SDK

This is the official iOS SDK for MercadoLibre's Platform.

##How can I install it?

CocoaPods (iOS 8.0 or later)

###Step 1: Download CocoaPods

CocoaPods is a dependency manager for Objective-C and Swift, which automates and simplifies the process of using 3rd-party libraries like MercadoPagoSDK in your projects.

CocoaPods is distributed as a ruby gem, and is installed by running the following commands in Terminal.app:

```
$ sudo gem install cocoapods
$ pod setup
```
Depending on your Ruby installation, you may not have to run as sudo to install the cocoapods gem.

###Step 2: Create a Podfile

Project dependencies to be managed by CocoaPods are specified in a file called Podfile. Create this file in the same directory as your Xcode project (.xcodeproj) file:
```
$ touch Podfile
$ open -a Xcode Podfile
```
You just created the pod file and opened it using Xcode! Ready to add some content to the empty pod file?

Copy and paste the following lines into the TextEdit window:
```
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '8.0'
pod 'MeliDevSDK', '~> 0.1.0'
```
You shouldn’t use TextEdit to edit the pod file because TextEdit likes to replace standard quotes with more graphically appealing quotes. This can cause CocoaPods to get confused and display errors, so it’s best to just use Xcode or another programming text editor.

###Step 3: Install Dependencies

Now you can install the dependencies in your project:

$ pod install
From now on, be sure to always open the generated Xcode workspace (.xcworkspace) instead of the project file when building your project:

$ open <YourProjectName>.xcworkspace
     
## How do I start using it?

In order to start working on SDK, you need to initialize the SDK using the following static method:

```objective-c
  [Meli startSDK: CLIENT_ID_VALUE withRedirectUrl: REDIRECT_URL_VALUE error:&error];
```

Where:
 - Client Identifier: is the App ID parameter provided when you create your application in the MercadoLibre Developer's site.
 - Redirect URI: the redirect URI that you provide in the creation of your application in the MercadoLibre Developer's site. 
 Note that this URL does not necessary belongs to an actual site.
      
## Authorizing your application with the user

The SDK provides functionallity to authorize your users to use your application with the MercadoLibre credentials. 
In order to do that, you need to follow these steps:

1 - Ask for an Identity. If it exits, it means that you have already been granted to use the MercadoLibre APIs that require 
authorization.
      
2 - In case you don't have an Identity, you should start the login's process using the following static method.

```objective-c
  (void) startLogin: (UIViewController *) clientViewController;
```

If there wasn't any error trying to get an Access Token, the navigation controller will get the control to the Client View Controller.

To execute sync http operations, you will need an instance of **MeliDevSyncHttpOperation** class.

```objective-c
MeliDevSyncHttpOperation *httpClient = [[MeliDevSyncHttpOperation alloc] initWithIdentity: self.identity];
```

In case you need async http operations, you will need an instance of **MeliDevASyncHttpOperation** class.

```objective-c
MeliDevASyncHttpOperation *httpClient = [[MeliDevASyncHttpOperation alloc] initWithIdentity: self.identity];
```

## Making GET calls

### Anonymous

```objective-c
NSString * result = [httpClient get:path error:&error];
```
  or

```objective-c
SuccessHandler successHandler = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureHandler failureHandler = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};
    
[httpClient get:path successHandler:successHandler failureHanlder:failureHandler];
```

### Authenticated

```objective-c
NSString * result = [httpClient getWithAuth:path error:&error];
```
  or

```objective-c
SuccessHandler successHandler = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureHandler failureHandler = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};
    
[httpClient getWithAuth:path successHandler:successHandler failureHanlder:failureHandler];
```

## Making POST calls

```objective-c
NSString * result =[ httpClient post:path withBody:[self createJsonDataForPost] error:&error];
```
    or

```objective-c
NSDictionary * params = [NSJSONSerialization JSONObjectWithData:[self createJsonDataForPost] options:kNilOptions error:&error];

SuccessHandler successHandler = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureHandler failureHandler = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};

[httpClient post:path withBody:params successHandler:successHandler failureHanlder:failureHandler];
```

## Making PUT calls

```objective-c
NSString * result = [httpClient put:path withBody:[self createJsonDataForPut] error:&error];
```
    or

```objective-c
NSDictionary * params = [NSJSONSerialization JSONObjectWithData:[self createJsonDataForPut] options:kNilOptions error:&error];
    
SuccessHandler successHandler = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureHandler failureHandler = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};

[httpClient put:path withBody:params successHandler:successHandler failureHanlder:failureHandler];
```

## Making DELETE calls

```objective-c
NSString * result = [httpClient delete:path error:&error];
```

    or

```objective-c
SuccessHandler successHandler = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureHandler failureHandler = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};

[httpClient delete:path successHandler:successHandler failureHanlder:failureHandler];
```

## Examples

Within the code in the Github repository, there is an example project that contains examples of how to use the SDK.
