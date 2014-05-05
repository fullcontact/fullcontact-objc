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
  [self.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
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
        
        self.responseSerializer = [AFCompoundResponseSerializer new]; //[AFJSONResponseSerializer new];
        self.requestSerializer = [AFJSONRequestSerializer new];
        
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

#pragma mark -

- (void)setAuthHeaders
{
  [self.requestSerializer setValue:[self uuidString] forHTTPHeaderField:@"X-FC-CRID"];
  [self.requestSerializer setValue:_apiKey forHTTPHeaderField:@"X-FullContact-APIKey"];
}

- (AFHTTPRequestOperation *)performOperationForRequest:(NSURLRequest *)request
                                               success:(FCSuccessBlock)success
                                               failure:(FCFailureBlock)failure
{
  AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [self processSuccess:responseObject forOperation:operation withSuccessBlock:success];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [self processFailure:error forOperation:operation withFailureBlock:failure];
  }];
  [self.operationQueue addOperation:operation];
  return operation;
}

- (NSString *)uuidString {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    return uuidStr;
}

- (NSString *)URLStringFromMethod:(NSString *)method
{
  return [[NSURL URLWithString:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] relativeToURL:self.baseURL] absoluteString];
}

#pragma mark - GET

-(void)get:(NSString*)method
withParameters:(NSDictionary*)parameters
   success:(FCSuccessBlock)success
   failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"GET"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    
    [self performOperationForRequest:request success:success failure:failure];
}

#pragma mark - POST

-(void)post:(NSString*)method
withParameters:(NSDictionary*)parameters
	success:(FCSuccessBlock)success
	failure:(FCFailureBlock)failure
{
    [self post:method parameters:parameters data:nil success:success failure:failure];
}

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"POST"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    if (data) {
      [request setHTTPBody:[self serializeData:data]];
    }
  
    [self performOperationForRequest:request success:success failure:failure];
}


- (void)post:(NSString *)method
withMimeType:(NSString *)mimeType
  parameters:(NSDictionary *)parameters
        data:(id)data
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    [self.requestSerializer setValue:mimeType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"POST"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    [request setHTTPBody:[self serializeData:data]];
    [request setTimeoutInterval:300];
    
    [self restoreDefaultState];
    
    [self performOperationForRequest:request success:success failure:failure];
}

- (void)post:(NSString *)method
  parameters:(NSDictionary *)parameters
withMultipartData:(NSArray*)multiPartRepresentations
     success:(FCSuccessBlock)success
     failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    
    NSMutableURLRequest *request = [self.requestSerializer
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:[[NSURL URLWithString:[NSString stringWithFormat:kUrlFormat, _apiVersion, method] relativeToURL:self.baseURL] absoluteString]
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                      for (FCMultipartRepresentation *multipartRepresentation in multiPartRepresentations)
                                      {
                                        if (multipartRepresentation.data)
                                          [formData appendPartWithFileData:multipartRepresentation.data name:multipartRepresentation.name fileName:multipartRepresentation.filename mimeType:multipartRepresentation.mimeType];
                                      }
                                    }
                                    error:nil];
    
    [self performOperationForRequest:request success:success failure:failure];
}

#pragma mark - PUT

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
	success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure
{
    [self put:method parameters:parameters data:nil success:success failure:failure];
}

- (void)put:(NSString *)method
 parameters:(NSDictionary *)parameters
       data:(NSData*)data
    success:(FCSuccessBlock)success
    failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"PUT"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    if (data) {
      [request setHTTPBody:data];
    }
  
    [self performOperationForRequest:request success:success failure:failure];
}

#pragma mark - DELETE

- (void)delete:(NSString *)method
    parameters:(NSDictionary *)parameters
       success:(FCSuccessBlock)success
       failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"DELETE"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    
    [self performOperationForRequest:request success:success failure:failure];
}



-(AFHTTPRequestOperation *)requestWithMethod:(NSString *)method
                                        path:(NSString *)path
                                  parameters:(NSDictionary *)parameters
                                        data:(NSData*)data
                                     success:(FCSuccessBlock)success
                                     failure:(FCFailureBlock)failure
{
    [self setAuthHeaders];
    
    NSMutableURLRequest *request = [self.requestSerializer
                                    requestWithMethod:@"PUT"
                                    URLString:[self URLStringFromMethod:method]
                                    parameters:parameters
                                    error:nil];
    if (data) {
      [request setHTTPBody:data];
    }
    
    return [self performOperationForRequest:request
                                    success:success
                                    failure:failure];
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

//TODO: does this method has to be public?
-(void)restoreDefaultState {
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
}

@end
