/*
 FCAPI.h
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

#define ENDPOINT_PERSON @"person.json"
#define ENDPOINT_PERSON_ENHANCED @"enhanced.json"
#define ENDPOINT_PERSON_BY_VCARD @"person.vcf"
#define ENDPOINT_NAME_NORMALIZER @"name/normalizer.json"
#define ENDPOINT_NAME_DEDUCER @"name/deducer.json"
#define ENDPOINT_NAME_SIMILARITY @"name/similarity.json"
#define ENDPOINT_NAME_STATS @"name/stats.json"
#define ENDPOINT_NAME_PARSER @"name/parser.json"
#define ENDPOINT_LOCATION_NORMALIZER @"address/locationNormalizer.json"
#define ENDPOINT_LOCATION_ENRICHMENT @"address/locationEnrichment.json"
#define ENDPOINT_ICON @"icon"
#define ENDPOINT_CARDSHARK @"cardShark"
#define ENDPOINT_BATCH @"batch.json"
#define ENDPOINT_EMAIL_DISPOSABLE @"email/disposable.json"
#define ENDPOINT_STATS @"stats.json"

#import "AFNetworking.h"
#import "AFHTTPClient.h"

@class FCResponse;

typedef void(^FCSuccessBlock)		(FCResponse* response);
typedef void(^FCFailureBlock)		(FCResponse* response, NSError* error);

@interface FCAPI : AFHTTPClient

@property (nonatomic) NSString* apiVersion;
@property (nonatomic) NSString* userAgent;

- (id)initWithBaseURL:(NSURL*)url
		   andVersion:(NSString*)version
			andAPIKey:(NSString*)apiKey DEPRECATED_MSG_ATTRIBUTE("Use -(id)initWithBaseURL:(NSURL*)url andVersion:(NSString*)version instead.");

- (id)initWithBaseURL:(NSURL*)url
		   andVersion:(NSString*)version;

- (void)useAPIKey:(NSString*)apiKey;

- (void)useAccessToken:(NSString*)accessToken;

- (void)prepareCall:(NSDictionary **)parameters;

- (void)setAPIKey:(NSString*)apiKey DEPRECATED_MSG_ATTRIBUTE("Use -(void)useApiKey:(NSString*)apiKey instead.");

-(void)get:(NSString*)method
withParameters:(NSDictionary*)parameters
   success:(FCSuccessBlock)success
   failure:(FCFailureBlock)failure;

-(void)post:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FCSuccessBlock)success
	failure:(FCFailureBlock)failure;

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure;

- (void)post:(NSString *)method
withMimeType:(NSString *)mimeType
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure;

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
withMultipartData:(NSArray*)multiPartRepresentations
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure;

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
    success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure;

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
       data:(NSData*)data
    success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure;

- (void)delete:(NSString *)method
parameters:(NSDictionary *)parameters
success:(FCSuccessBlock)success
failure:(FCFailureBlock)failure;

-(void)processSuccess:(id)response
         forOperation:(AFHTTPRequestOperation*)operation
	 withSuccessBlock:(FCSuccessBlock)successBlock;

-(void)processFailure:(NSError*)error
		 forOperation:(AFHTTPRequestOperation*)operation
	 withFailureBlock:(FCFailureBlock)failureBlock;

-(void)restoreDefaultState;

@end
