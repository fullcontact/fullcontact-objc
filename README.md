
Deprecated
==
This library is no longer actively maintained and may break at some point in the near future. 

fullcontact-objc
================


Ever wanted to call FullContact's API from your own iOS or OS X application?  Now you can.

fullcontact-objc is a library for iOS and Mac OS X. It's built on top of [AFNetworking](https://github.com/AFNetworking/AFNetworking) and provides connectivity to the [FullContact Developer API](http://www.fullcontact.com/developer/docs/) endpoints. 

###Why we love it…
fullcontact-objc makes it painless to access the FullContact Developer API in your iOS or Mac OS X apps.

Currently this library has support for the following FullContact endpoints:


| Endpoint | What it Does | Documentation | Supported in          
| ------------- |-------------| ------------- | ------------- 
| Person API     | Returns social profile data from an email address, phone number, Twitter handle, or Facebook ID | [Person API](http://www.fullcontact.com/developer/docs/person) | FCAPI+Person.h
| Name API      | Normalize, parse, compare, and deduce names from an email address or other source | [Name API](http://www.fullcontact.com/developer/docs/name) | FCAPI+Name.h
| Location API  | Normalizes and provides related info for semi-structured location data | [Location API](http://www.fullcontact.com/developer/docs/location) | FCAPI+Location.h
| Card Reader API | Returns human-transcribed, structured contact data from an image of a business card | [Card Reader API](http://www.fullcontact.com/developer/docs/card-reader) | FCAPI+CardReader.h
| Disposable Email API     | Detects disposable and sub-addressed email addresses | [Disposable Email API](http://www.fullcontact.com/developer/docs/email) | FCAPI+Email.h
| Icon API      | Returns free social media icons via an HTTPS request | [Icon API](http://www.fullcontact.com/developer/docs/icon) | FCAPI+Icon.h
| Batch Process API     | Batch several API requests into a single request to improve performance | [Batch Process API](http://www.fullcontact.com/developer/docs/batch) | FCAPI+Batch.h
| Stats API     | View and keep track of your FullContact API account usage | [Stats API](http://www.fullcontact.com/developer/docs/stats) | FCAPI+Stats.h


## Requirements

fullcontact-objc requires either [iOS 5.0](http://developer.apple.com/library/ios/#releasenotes/General/WhatsNewIniPhoneOS/Articles/iPhoneOS4.html) and above, or [Mac OS 10.7](http://developer.apple.com/library/mac/#releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_6.html#//apple_ref/doc/uid/TP40008898-SW7) ([64-bit with modern Cocoa runtime](https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtVersionsPlatforms.html)) and above.

###Installation

1. Add fullcontact-objc as a git submodule to your project.
2. Add [AFNetworking](https://github.com/AFNetworking/AFNetworking) as a submodule to your project and switch to the [1.x branch](https://github.com/AFNetworking/AFNetworking/tree/1.x).
3. Include fullcontact-objc wherever you need it with `#import "FCAPI.h"` or any of it's subcategories.

### ARC

fullcontact-objc uses ARC.

If you are using fullcontact-objc in your non-arc project, you will need to set a `-fobjc-arc` compiler flag on all of the source files. 

To set a compiler flag in Xcode, go to your active target and select the "Build Phases" tab. Now select all fullcontact-objc source files, press Enter, insert `-fobjc-arc` and then "Done" to enable ARC for fullcontact-objc.

## Using the Library
### Initializing the API
To initialize the API, simply import FCAPI.h.  Ensure you have the following constants defined:

1. `kAPIUrl` is "https://api.fullcontact.com"
2. `kAPIVersion` is "v2"
3. `kAPIKey` is the API Key that you obtained from FullContact.

Then call:

```objective-c
FCAPI *api = [[FCAPI alloc] initWithBaseURL:[NSURL URLWithString:kAPIUrl] andVersion:kAPIVersion andAPIKey:kAPIKey];
```
 
### Calling the API
To use the API after it is initialized, simply import the category that you wish to use and invoke one of the methods.  For example, if you'd like to look up a person by their email address you could do the following:

Add the following to your imports:

```
#import "FCAPI+Person.h"
```

After initializing your API instance, call the lookupByEmail method as follows:

```objective-c
[api lookupByEmail:@"lorangb@gmail.com" success:^(FCResponse *response) {
      //response.response will contain your JSON payload which you can handle here
} 
failure:^(FCResponse *response, NSError *error) {
      //handle the error that may have been returned
}];
```
### Running Tests
To run fullcontact-objcTest, simply locate the `TestContstants.h` file in the fullcontact-objcTest project and insert your API key as the value for `kAPIKey`.  After doing this you can run tests for both iOS and OSX architectures.

*Note that Card Reader tests only function for the iOS platform at this time.*

##Need Help - No Problem!
We're always available to help in any way we can.  Check out our [Support Page](http://support.fullcontact.com) to access our Knowledge Base or contact our Support group.

##Got an Idea?
We love ideas!  Submit your ideas, suggestions, or feedback on our [API Developer Forum](http://support.fullcontact.com/forums/187136-api-developer-forum) or fork our repo.  We review pull requests regularly and look forward to seeing what you come up with!

## License

fullcontact-objc is available under the Apache License Version 2.0 license. See the [LICENSE](LICENSE) file for more info.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/fullcontact/fullcontact-objc/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
