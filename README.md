![No longer maintained](https://img.shields.io/badge/Maintenance-OFF-red.svg)
### [DEPRECATED] This repository is no longer maintained
> This project is not functional, the dependencies are no longer up to date.
>
> You can use another [SDK](https://developers.mercadolibre.com/herramientas) or read our [documentation](https://developers.mercadolibre.com)

[![Mercado Libre Developers](https://user-images.githubusercontent.com/1153516/73021269-043c2d80-3e06-11ea-8d0e-6e91441c2900.png)](https://developers.mercadolibre.com)



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
pod 'MeliDevSDK', '~> 0.1.6'
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
      
2 - In case you don't have an Identity, you should initialize the sdk and start the login's process using the following static methods.

```objective-c
  (void) startSDK: (NSString *) clientId withRedirectUrl:(NSString *) redirectUrl error:(NSError **) error;
```

```objective-c
  (void) startLogin: (UIViewController *) clientViewController withSuccesBlock: (void (^)()) successBlock withErrorBlock: (void (^)(NSString *)) errorBlock;
```

This last method will check if the sdk was initialized. In case it wasn't, a message will be logged saying that you should do it.

If there wasn't any error trying to get an Access Token, the navigation controller will get the control to the Client View Controller.

## Making GET calls

### Anonymous

```objective-c
NSString * result = [Meli get:path error:&error];
```
  or

```objective-c
SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};
    
[Meli get:path successBlock:successBlock failureBlock:failureBlock];
```

### Authenticated

```objective-c
NSString * result = [Meli getAuth:path withIdentity: [Meli getIdentity] error: &error];
```
  or

```objective-c
SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};
    
[Meli asyncGetAuth:path withIdentity: identity successBlock:successBlock failureBlock:failureBlock];
```

## Making POST calls

```objective-c
NSString * result = [Meli post:path withBody:[self createJsonDataForPost] withIdentity: [Meli getIdentity] error:&error];
```
    or

```objective-c

AsyncHttpOperationBlock operationBlock = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    };
    
[Meli asyncPost:path withBody:body withIdentity: [Meli getIdentity] operationBlock:operationBlock];
```

## Making PUT calls

```objective-c
NSString * result = [Meli put:path withBody:jsonData error:&error];
```
    or

```objective-c

AsyncHttpOperationBlock operationBlock = ^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Response: %@", responseObject);
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    };
    
[Meli put:path withBody:[self createJsonDataForPut] withIdentity: [Meli getIdentity] error:&error];
```

## Making DELETE calls

##### Note: In the DELETE example code you will notice that it tries to delete a question. So, if you are going to create a question, it should check that the item does not belong to the same user. Otherwise, you will receive an error from MercadoLibre API.

```objective-c
NSString * result = [Meli delete:path withIdentity: [Meli getIdentity] error:&error];
```

    or

```objective-c
SuccessBlock successBlock = ^(NSURLSessionTask *task, id responseObject) {
    [self parseData:responseObject];
};

FailureBlock failureBlock = ^(NSURLSessionTask *operation, NSError *error) {
    if(error) {
        [self processError:operation error:error];
    }
};

[Meli asyncDelete:path withIdentity: [Meli getIdentity] successBlock:successBlock failureBlock:failureBlock];
```

## Examples

Within the code in the Github repository, there is an example project that contains examples of how to use the SDK.
