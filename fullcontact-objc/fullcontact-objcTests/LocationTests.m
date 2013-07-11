/*
 LocationTests.m
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

#import "LocationTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Location.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation LocationTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLocationNormalization
{
    [[APIOrchestrator api] normalizeLocation:@"denver" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLocationNormalization"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLocationNormalization"];
}

- (void)testLocationEnrichment
{
    [[APIOrchestrator api] enrich:@"denver" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLocationEnrichment"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLocationEnrichment"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLocationEnrichment"];
}

@end
