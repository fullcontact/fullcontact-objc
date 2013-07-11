/*
 FCAPITests.m
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

#import "FCAPITests.h"

#import "FCAPI.h"
#import "TestContstants.h"
#import "APIOrchestrator.h"

@implementation FCAPITests

- (void)testUserAgentSwitch
{
    FCAPI *api = [APIOrchestrator api];
    NSString *userAgent1 = [api defaultValueForHeader:@"User-Agent"];
    [api setUserAgent:@"Test"];
    NSString *userAgent2 = [api defaultValueForHeader:@"User-Agent"];
    STAssertFalse([userAgent1 isEqualToString:userAgent2], @"User agent wasn't changed");
}

- (void)testBaseUrlSwitch
{
    FCAPI *api = [APIOrchestrator api];
    NSString *baseUrl1 = api.baseURL.absoluteString;
    api = [[FCAPI alloc] initWithBaseURL:[NSURL URLWithString:@"http://test.com"] andVersion:kAPIVersion andAPIKey:kAPIKey];
    NSString *baseUrl2 = api.baseURL.absoluteString;
    STAssertFalse([baseUrl1 isEqualToString:baseUrl2], @"Base url wasn't changed");
}

@end
