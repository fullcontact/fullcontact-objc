/*
 FCMultipartRepresentation.m
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

#import "FCMultipartRepresentation.h"

@implementation FCMultipartRepresentation

- (id) initWithData:(NSData*)data
          andMimeType:(NSString*)mimeType
              andName:(NSString*)name
          andFileName:(NSString*)filename
{
    if (self = [super init])
    {
        _data = data;
        _mimeType = mimeType;
        _name  = name;
        _filename = filename;
    }
    return self;
}


@end
