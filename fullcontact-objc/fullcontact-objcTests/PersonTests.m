/*
 PersonTests.m
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

#import "PersonTests.h"

#import "TestSemaphore.h"
#import "TestContstants.h"

#import "FCAPI+Person.h"
#import "FCResponse.h"

#import "APIOrchestrator.h"

@implementation PersonTests

- (void)setUp
{
    [super setUp];
	[APIOrchestrator sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLookupPersonByEmail
{
    [[APIOrchestrator api] lookupByEmail:@"lorangb@gmail.com" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmail"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmail"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByEmail"];
}

- (void)testLookupPersonByEmailMD5
{
    [[APIOrchestrator api] lookupByEmailMD5:@"a4cb1b07d68a3436a190e1559586ae3c" parameters:nil success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmailMD5"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmailMD5"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByEmailMD5"];
}


- (void)testLookupPersonByEmailWithQueue
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"queue", nil];
    [[APIOrchestrator api] lookupByEmail:@"lorangb@gmail.com" parameters:parameters success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmailWithQueue"];
        STAssertTrue(response.status == 200 || response.status == 202, @"HTTP Status Code should be 200 or 202");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByEmailWithQueue"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByEmailWithQueue"];
}

- (void)testLookupPersonByPhone
{
    [[APIOrchestrator api] lookupByPhone:@"+13037170414" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhone"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhone"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByPhone"];
}

- (void)testLookupPersonByPhoneAndCountryCode
{
    [[APIOrchestrator api] lookupByPhone:@"+44(0)7783866116" andCountryCode:@"GB" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhoneAndCountryCode"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhoneAndCountryCode"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByPhoneAndCountryCode"];
}

- (void)testLookupPersonByPhoneWithQueue
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"queue", nil];
    [[APIOrchestrator api] lookupByPhone:@"+13037170414" parameters:parameters success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhoneWithQueue"];
        STAssertTrue(response.status == 200 || response.status == 202, @"HTTP Status Code should be 200 or 202");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByPhoneWithQueue"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByPhoneWithQueue"];
}

- (void)testLookupPersonByTwitter
{
    [[APIOrchestrator api] lookupByTwitter:@"lorangb" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByTwitter"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByTwitter"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByTwitter"];
}

- (void)testLookupPersonByTwitterWithQueue
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"queue", nil];
    [[APIOrchestrator api] lookupByTwitter:@"bart.lorang" parameters:parameters success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByTwitterWithQueue"];
        STAssertTrue(response.status == 200 || response.status == 202, @"HTTP Status Code should be 200 or 202");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByTwitterWithQueue"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByTwitterWithQueue"];
}

- (void)testLookupPersonByFacebook
{
    [[APIOrchestrator api] lookupByFacebook:@"bart.lorang" success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByFacebook"];
        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByFacebook"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByFacebook"];
}

- (void)testLookupPersonByFacebookWithQueue
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"queue", nil];
    [[APIOrchestrator api] lookupByFacebook:@"lorangb" parameters:parameters success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByFacebookWithQueue"];
        STAssertTrue(response.status == 200 || response.status == 202, @"HTTP Status Code should be 200 or 202");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByFacebookWithQueue"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByFacebookWithQueue"];
}

- (void)testLookupPersonByVCard
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://d1h3f0foa0xzdz.cloudfront.net/1700/2ZO2NJQ2172ZFBHO4CBLKVEBWS8XP8.vcf"]];
    
    [[APIOrchestrator api] lookupByVCard:data success:^(FCResponse *response) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByVCard"];
        STAssertTrue(response.status == 200 || response.status == 202, @"HTTP Status Code should be 200 or 202");
        STAssertNotNil(response.response, @"Expected a Response");
        STAssertNotNil(response.crid, @"Expected a Crid");
    } failure:^(FCResponse *response, NSError *error) {
        [[TestSemaphore sharedInstance] lift:@"testLookupPersonByVCard"];
        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
    }];
    [[TestSemaphore sharedInstance] waitForKey:@"testLookupPersonByVCard"];
}

//- (void)testLookupEnhanced
//{
//    [[APIOrchestrator api] lookupEnhanced:@"dan@fullcontact.com" success:^(FCResponse *response) {
//        [[TestSemaphore sharedInstance] lift:@"testLookupEnhanced"];
//        STAssertTrue(response.status == 200, @"HTTP Status Code should be 200");
//        STAssertNotNil(response.response, @"Expected a Response");
//        STAssertNotNil(response.crid, @"Expected a Crid");
//    } failure:^(FCResponse *response, NSError *error) {
//        [[TestSemaphore sharedInstance] lift:@"testLookupEnhanced"];
//        STAssertNil(error, [NSString stringWithFormat:@"%@",[(NSDictionary*)response.response valueForKey:@"message"]]);
//    }];
//    [[TestSemaphore sharedInstance] waitForKey:@"testLookupEnhanced"];
//}

@end
