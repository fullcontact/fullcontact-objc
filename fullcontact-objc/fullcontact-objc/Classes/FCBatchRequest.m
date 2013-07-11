/*
 FCBatchRequest.m
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

#import "FCBatchRequest.h"

@implementation FCBatchRequest

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_requests forKey:@"requests"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        _requests = [decoder decodeObjectForKey:@"requests"];
    }
    return self;
}

+ (FCBatchRequest *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    FCBatchRequest *instance = [[FCBatchRequest alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{
    if (![aDictionary isKindOfClass:[NSDictionary class]])
        return;
    [self setValuesForKeysWithDictionary:aDictionary];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"requests"]) {
        if ([value isKindOfClass:[NSArray class]])
		{
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
			[value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
				[myMembers addObject:obj];
			}];
            _requests = myMembers;
        }
    } else {
        [super setValue:value forKey:key];
    }
}


- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (_requests)
        [dictionary setObject:_requests forKey:@"requests"];
    return dictionary;
}

@end
