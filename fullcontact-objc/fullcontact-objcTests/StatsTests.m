/*
 StatsTests.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/8/12.
 
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

#import "StatsTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Stats.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation StatsTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testStatsWithDate
{
    [[APIOrchestrator api] getStats:[NSDate date] success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsWithDate"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsWithDate"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsWithDate"];
}

- (void)testStatsWithYearAndMonth
{
    [[APIOrchestrator api] getStatsForYear:@"2012" andMonth:@"08" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsWithYearAndMonth"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsWithYearAndMonth"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsWithYearAndMonth"];
}

@end
