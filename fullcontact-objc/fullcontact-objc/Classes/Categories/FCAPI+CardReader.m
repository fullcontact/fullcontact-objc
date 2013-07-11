/*
 FCAPI+CardReader.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/4/12.
 
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

#import "FCAPI+CardReader.h"
#import "FCMultipartRepresentation.h"

@implementation FCAPI (CardReader)

-(void)uploadCard:(NSData*)front
          andBack:(NSData*)back
   withWebhookUrl:(NSString*)webhookUrl
          success:(FCSuccessBlock)success
          failure:(FCFailureBlock)failure
{
    NSArray *multipartRepresentations = @[[[FCMultipartRepresentation alloc]initWithData:front andMimeType:@"image/png" andName:@"front" andFileName:@"front.png"], [[FCMultipartRepresentation alloc] initWithData:back andMimeType:@"image/png" andName:@"back" andFileName:@"back.png"]];
    [self post:ENDPOINT_CARDSHARK parameters:@{@"webhookUrl":webhookUrl} withMultipartData:multipartRepresentations success:success failure:failure];
}

-(void)uploadCard:(NSData*)front
          andBack:(NSData*)back
   withParameters:(NSDictionary*)parameters
   andWebhookUrl:(NSString*)webhookUrl
          success:(FCSuccessBlock)success
          failure:(FCFailureBlock)failure
{
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableParameters setObject:webhookUrl forKey:@"webhookUrl"];
    NSArray *multipartRepresentations = @[[[FCMultipartRepresentation alloc]initWithData:front andMimeType:@"image/png" andName:@"front" andFileName:@"front.png"], [[FCMultipartRepresentation alloc] initWithData:back andMimeType:@"image/png" andName:@"back" andFileName:@"back.png"]];
    [self post:ENDPOINT_CARDSHARK parameters:mutableParameters withMultipartData:multipartRepresentations success:success failure:failure];
}


-(void)viewCardRequest:(NSString*)requestId
               success:(FCSuccessBlock)success
               failure:(FCFailureBlock)failure
{
    NSString *method = [NSString stringWithFormat:@"%@/%@", ENDPOINT_CARDSHARK, requestId];
    [self get:method withParameters:nil success:success failure:failure];
}

-(void)viewCardRequests:(NSInteger)page
                success:(FCSuccessBlock)success
                failure:(FCFailureBlock)failure
{
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED
[self get:ENDPOINT_CARDSHARK withParameters:@{@"page": [NSString stringWithFormat:@"%d", page]} success:success failure:failure];
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
[self get:ENDPOINT_CARDSHARK withParameters:@{@"page": [NSString stringWithFormat:@"%ld", page]} success:success failure:failure];
#endif
    
}

@end
