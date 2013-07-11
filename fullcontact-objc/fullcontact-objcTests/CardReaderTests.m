/*
 CardReaderTests.m
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

#import "CardReaderTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+CardReader.h"
#import "FCResponse.h"
#import "FCMultipartRepresentation.h"

#import "APIOrchestrator.h"

@implementation CardReaderTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

#if __IPHONE_OS_VERSION_MIN_REQUIRED

- (void)testCardUpload
{
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"https://d1h3f0foa0xzdz.cloudfront.net/1700/59981ce7-de36-4e9c-a3df-d4d43a5fa2bf-front.png"]];
    UIImage *front = [UIImage imageWithData:imageData];
    
    [[APIOrchestrator api] uploadCard:UIImagePNGRepresentation(front) andBack:nil withWebhookUrl:@"http://fullcontact.com" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertTrue(response.status == 202, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testViewCardRequest"];
}

- (void)testCardUploadWithJSONData
{
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"https://d1h3f0foa0xzdz.cloudfront.net/1700/59981ce7-de36-4e9c-a3df-d4d43a5fa2bf-front.png"]];
    UIImage *front = [UIImage imageWithData:imageData];

    NSDictionary *test = @{@"refreshToken" : @"Test", @"webhookUrl" : @"http://fullcontact.com", @"sf" : @"{ \"Description\": \"Test Case Run\"}"};


    [[APIOrchestrator api] uploadCard:UIImagePNGRepresentation(front) andBack:nil withParameters:test andWebhookUrl:@"https://www.fullcontact.com" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertTrue(response.status == 202, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testViewCardRequest"];
}

- (void)testViewCardRequest
{
    [[APIOrchestrator api] viewCardRequest:@"5bd740b7-5589-410e-a14d-957c10a587a8" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequest"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testViewCardRequest"];
}

- (void)testViewCardRequests
{
    [[APIOrchestrator api] viewCardRequests:0 success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequests"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testViewCardRequests"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testViewCardRequests"];
}

#endif


@end
