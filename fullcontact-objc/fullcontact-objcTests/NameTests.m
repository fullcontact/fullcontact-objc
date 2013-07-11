/*
 NameTests.m
 fullcontact-objc
 
 Created by Duane Schleen on 10/3/12.
 
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

#import "NameTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Name.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation NameTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testNameNormalizer
{
    [[APIOrchestrator api] normalizeName:@"mr john (johnny) michael Smith jr mba" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testNameNormalizer"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testNameNormalizer"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testNameNormalizer"];
}

- (void)testNameDeducerFromEmail
{
    [[APIOrchestrator api] deduceFromEmail:@"johndsmith79@business.com" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testNameDeducerFromEmail"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testNameDeducerFromEmail"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testNameDeducerFromEmail"];
}

- (void)testNameDeducerFromUserName
{
    [[APIOrchestrator api] deduceFromUserName:@"johndsmith79" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testNameDeducerFromUserName"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testNameDeducerFromUserName"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testNameDeducerFromUserName"];
}

- (void)testCompareSimilarity
{
    [[APIOrchestrator api] compareSimilarity:@"john" with:@"johnathan" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testCompareSimilarity"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testCompareSimilarity"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testCompareSimilarity"];
}

- (void)testStatsForName
{
    [[APIOrchestrator api] statsForName:@"john" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForName"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForName"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsForName"];
}

- (void)testStatsForGivenName
{
    [[APIOrchestrator api] statsForGivenName:@"john" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForGivenName"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForGivenName"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsForGivenName"];
}

- (void)testStatsForFamilyName
{
    [[APIOrchestrator api] statsForFamilyName:@"smith" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForFamilyName"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForFamilyName"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsForFamilyName"];
}

- (void)testStatsForGivenAndFamilyName
{
    [[APIOrchestrator api] statsForGivenName:@"john" andFamilyName:@"smith" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForGivenAndFamilyName"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testStatsForGivenAndFamilyName"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testStatsForGivenAndFamilyName"];
}

- (void)testNameParser
{
    [[APIOrchestrator api] parse:@"john smith" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testNameParser"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testNameParser"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testNameParser"];
}

@end
