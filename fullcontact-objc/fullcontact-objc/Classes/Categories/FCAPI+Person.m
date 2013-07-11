/*
 FCAPI+Person.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/2/12.
 
 Copyright (c)        2013 FullContact Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "FCAPI+Person.h"
#import "FCResponse.h"

@implementation FCAPI (Person)

-(void)lookupByEmail:(NSString*)email
          parameters:(NSDictionary*)parameters
             success:(FCSuccessBlock)success
             failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:email forKey:@"email"];
    [self get:ENDPOINT_PERSON withParameters:mutableParameters success:success failure:failure];
}

-(void)lookupByEmail:(NSString*)email
             success:(FCSuccessBlock)success
             failure:(FCFailureBlock)failure
{
    [self lookupByEmail:email parameters:nil success:success failure:failure];
}

- (void)lookupByEmailMD5:(NSString*)emailMD5
              parameters:(NSDictionary*)parameters
                 success:(FCSuccessBlock)success
                 failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:emailMD5 forKey:@"emailMD5"];
    [self get:ENDPOINT_PERSON withParameters:mutableParameters success:success failure:failure];
}

- (void)lookupByPhone:(NSString*)phone
           parameters:(NSDictionary*)parameters
              success:(FCSuccessBlock)success
              failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:phone forKey:@"phone"];
    [self get:ENDPOINT_PERSON withParameters:mutableParameters success:success failure:failure];
}

- (void)lookupByPhone:(NSString*)phone
              success:(FCSuccessBlock)success
              failure:(FCFailureBlock)failure
{
    [self lookupByPhone:phone parameters:nil success:success failure:failure];
}

- (void)lookupByPhone:(NSString*)phone
       andCountryCode:(NSString*)countryCode
              success:(FCSuccessBlock)success
              failure:(FCFailureBlock)failure
{
    [self lookupByPhone:phone parameters:@{@"countryCode":countryCode} success:success failure:failure];
}

- (void)lookupByTwitter:(NSString*)twitterName
             parameters:(NSDictionary*)parameters
                success:(FCSuccessBlock)success
                failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:twitterName forKey:@"twitter"];
    [self get:ENDPOINT_PERSON withParameters:mutableParameters success:success failure:failure];
}

- (void)lookupByTwitter:(NSString*)twitterName
                success:(FCSuccessBlock)success
                failure:(FCFailureBlock)failure
{
    [self lookupByTwitter:twitterName parameters:nil success:success failure:failure];
}

- (void)lookupByFacebook:(NSString*)facebookUsername
              parameters:(NSDictionary*)parameters
                 success:(FCSuccessBlock)success
                 failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setValue:facebookUsername forKey:@"facebookUsername"];
    [self get:ENDPOINT_PERSON withParameters:mutableParameters success:success failure:failure];
}

- (void)lookupByFacebook:(NSString*)facebookUsername
                 success:(FCSuccessBlock)success
                 failure:(FCFailureBlock)failure
{
    [self lookupByFacebook:facebookUsername parameters:nil success:success failure:failure];
}

- (void)lookupByVCard:(NSData*)vCard
              success:(FCSuccessBlock)success
              failure:(FCFailureBlock)failure
{
    [self setDefaultHeader:@"Accept" value:@"text/x-vcard"];
    [self post:ENDPOINT_PERSON_BY_VCARD withMimeType:@"text/x-vcard" parameters:nil data:vCard success:success failure:failure];
}

- (void)lookupEnhanced:(NSString*)email
                 success:(FCSuccessBlock)success
                 failure:(FCFailureBlock)failure;
{
    [self get:ENDPOINT_PERSON_ENHANCED withParameters:@{@"email":email} success:success failure:failure];
}

@end
