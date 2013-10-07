/*
 FCAPI.m
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

#import "FCAPI.h"
#import "FCResponse.h"
#import "FCMultipartRepresentation.h"
#import "NSDictionary+UrlEncoding.h"

#define kUrlFormat @"/%@/%@"

@implementation FCAPI

#pragma mark - Custom property Setters

-(void)setUserAgent:(NSString *)userAgent
{
    _userAgent = userAgent;
    [self setDefaultHeader:@"User-Agent" value:userAgent];
}

#pragma mark - init

-(id)initWithBaseURL:(NSURL*)url andVersion:(NSString*)version andAPIKey:(NSString*)key
{
    NSAssert(url, @"url cannot be nil");
    NSAssert(version, @"version cannot be nil");
    NSAssert(key, @"key cannot be nil");
    
    self = [super initWithBaseURL:url];
    if (self != nil) {
        [self setApiKey:key];
        [self setApiVersion:version];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
		[self setDefaultHeader:@"Content-Type" value:@"application/json"];
        [self setParameterEncoding:AFFormURLParameterEncoding];
    }
    return self;
}

- (void)prepareCall:(NSDictionary **)parameters
{
    if (!(*parameters)) {
        *parameters = @{@"apiKey":_apiKey};
    } else {
        NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:*parameters];
        [mutableParameters setValue:_apiKey forKey:@"apiKey"];
        *parameters = mutableParameters;
    }
    [super setDefaultHeader:@"X-FC-CRID" value:[self uuidString]];
}

- (NSString *)uuidString {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    return uuidStr;
}

-(void)get:(NSString*)method
   withParameters:(NSDictionary*)parameters
          success:(FCSuccessBlock)success
          failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    [super getPath:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self processFailure:error forOperation:operation withFailureBlock:failure];
	}];
}

-(void)post:(NSString*)method
   withParameters:(NSDictionary*)parameters
          success:(FCSuccessBlock)success
          failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    [super postPath:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		[self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self processFailure:error forOperation:operation withFailureBlock:failure];
	}];
}

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    NSURLRequest *request = [self requestWithMethod:@"POST" path:[NSString stringWithFormat:kUrlFormat, _apiVersion, [NSString stringWithFormat:@"%@?%@", method, [parameters urlEncodedString]]] parameters:nil data:[self serializeData:data]];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processFailure:error forOperation:operation withFailureBlock:failure];
    }];
    [self enqueueHTTPRequestOperation:operation];
}


- (void)post:(NSString *)method
withMimeType:(NSString *)mimeType
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    [self setDefaultHeader:@"Content-Type" value:mimeType];
    NSMutableURLRequest *request = [self requestWithMethod:@"POST" path:[NSString stringWithFormat:kUrlFormat, _apiVersion, [NSString stringWithFormat:@"%@?%@", method, [parameters urlEncodedString]]] parameters:nil data:[self serializeData:data]];
    [request setTimeoutInterval:300];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
        [self restoreDefaultState];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processFailure:error forOperation:operation withFailureBlock:failure];
        [self restoreDefaultState];
    }];
    [self enqueueHTTPRequestOperation:operation];
}

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
withMultipartData:(NSArray*)multiPartRepresentations
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    
    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters constructingBodyWithBlock: ^(id <AFMultipartFormData> formData) {
        for (FCMultipartRepresentation *multipartRepresentation in multiPartRepresentations)
        {
            if (multipartRepresentation.data)
                [formData appendPartWithFileData:multipartRepresentation.data name:multipartRepresentation.name fileName:multipartRepresentation.filename mimeType:multipartRepresentation.mimeType];
        }
    }];
    [request setTimeoutInterval:300];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processFailure:error forOperation:operation withFailureBlock:failure];
    }];
    [self enqueueHTTPRequestOperation:operation];
}

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
     success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    [super putPath:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
		[self processSuccess:JSON forOperation:operation withSuccessBlock:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self processFailure:error forOperation:operation withFailureBlock:failure];
	}];
}

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
       data:(NSData*)data
    success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure
{
    NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    NSURLRequest *request = [self requestWithMethod:@"PUT" path:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters data:data];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self processFailure:error forOperation:operation withFailureBlock:failure];
    }];
    [self enqueueHTTPRequestOperation:operation];
}

- (void)delete:(NSString *)method
    parameters:(NSDictionary *)parameters
       success:(FCSuccessBlock)success
       failure:(FCFailureBlock)failure
{
	NSAssert(method, @"method cannot be nil");
    [self prepareCall:&parameters];
    [super deletePath:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] parameters:parameters success:^(AFHTTPRequestOperation *operation, id JSON) {
		[self processSuccess:JSON forOperation:operation withSuccessBlock:success];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self processFailure:error forOperation:operation withFailureBlock:failure];
	}];
}



-(NSMutableURLRequest*)requestWithMethod:(NSString *)method
                                    path:(NSString *)path
                              parameters:(NSDictionary *)parameters
									data:(NSData*)data
{
    NSMutableURLRequest* request = [super requestWithMethod:method
													   path:path
												 parameters:parameters];
    [request setHTTPBody:data];
    return request;
}

-(NSData*)serializeData:(id)obj
{
    NSAssert(obj, @"obj cannot be nil");
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSError* __autoreleasing *e = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:e];
        if (!e) return data;
    }
    return obj;
    
}

-(void)processSuccess:(id)response
         forOperation:(AFHTTPRequestOperation*)operation
	 withSuccessBlock:(FCSuccessBlock)successBlock
{
	if (successBlock) {
        FCResponse *fcResponse = [[FCResponse alloc] initWithStatus:operation.response.statusCode andCrid: [[operation.request allHTTPHeaderFields] objectForKey:@"X-FC-CRID"] andResponse:response];
		successBlock(fcResponse);
	}
}

-(void)processFailure:(NSError*)error
		 forOperation:(AFHTTPRequestOperation*)operation
	 withFailureBlock:(FCFailureBlock)failureBlock
{
	if (failureBlock) {
        NSError *jsonError = nil;
        id response = nil;
        if (operation.responseData) 
            response = [NSJSONSerialization JSONObjectWithData:[operation responseData] options:kNilOptions error:&jsonError];
        FCResponse *fcResponse = [[FCResponse alloc] initWithStatus:operation.response.statusCode andCrid: [[operation.request allHTTPHeaderFields] objectForKey:@"X-FC-CRID"] andResponse:response];
		failureBlock(fcResponse, error);
	}
}

-(void)restoreDefaultState {
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
}

@end
