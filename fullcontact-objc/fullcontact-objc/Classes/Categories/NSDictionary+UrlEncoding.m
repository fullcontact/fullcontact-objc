/*
 NSDictionary+URlEncoding.m
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

#import "NSDictionary+UrlEncoding.h"

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (UrlEncoding)

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
	[self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(obj)];
        [parts addObject: part];
	}];
    return [parts componentsJoinedByString: @"&"];
}

@end

