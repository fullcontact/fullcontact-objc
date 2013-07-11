/*
 BatchTests.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/5/12.
 
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

#import "BatchTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Batch.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation BatchTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBatch
{
    NSArray *batch = @[@"https://api.fullcontact.com/v2/name/normalizer.json?q=dan+lynn",
        @"https://api.fullcontact.com/v2/name/normalizer.json?q=kyle+hansen",
        @"https://api.fullcontact.com/v2/person.json?email=bart@fullcontact.com"];
    
    [[APIOrchestrator api]  batch:batch success:^(FCResponse *response) {
         [[TestSemaphore sharedInstance] lift:@"testBatch"];
         STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
         STAssertNotNil(response.response, @"Expected a Response");
         STAssertNotNil(response.crid, @"Expected a Crid");
     } failure:^(FCResponse *response, NSError *error) {
         [[TestSemaphore sharedInstance] lift:@"testBatch"];
         STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
     }];
    [[TestSemaphore sharedInstance] waitForKey:@"testBatch"];
}


@end
