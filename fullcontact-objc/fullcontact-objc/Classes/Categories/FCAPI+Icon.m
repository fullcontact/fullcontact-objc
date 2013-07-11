/*
 FCAPI+Icon.m
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

#import "FCAPI+Icon.h"

@implementation FCAPI (Icon)

- (void)getIcon:(NSString*)typeId
          withSize:(NSInteger)size
          andStyle:(NSString*)style
        success:(FCImageSuccessBlock)success
        failure:(FCImageFailureBlock)failure
{
    NSAssert(typeId, @"typeId cannot be nil");
    
    if (!size)
        size = 16;
    
    NSAssert(size == 16 || size == 24 || size == 32 || size == 64, @"size must be either 16, 24, 32, or 64");
    
    if (!style)
        style = @"default";
    
    NSAssert([style isEqualToString:@"default"] || [style isEqualToString:@"dark"] || [style isEqualToString:@"light"], @"style must be default, dark, or white");
    
    [self registerHTTPOperationClass:[AFImageRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"image/png"];
    [self setDefaultHeader:@"Content-Type" value:@"image/png"];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED
        NSString *method = [NSString stringWithFormat:@"%@/%@/%@/%d/%@", self.apiVersion, ENDPOINT_ICON, typeId, size, style];
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
        NSString *method = [NSString stringWithFormat:@"%@/%@/%@/%ld/%@", self.apiVersion, ENDPOINT_ICON, typeId, size, style];
#endif
      
    NSDictionary *parameters = nil;
    [self prepareCall:&parameters];
    [super getPath:method parameters:parameters success:^(AFHTTPRequestOperation *operation, id data) {
        if (success)
            success(data);
       [self restoreDefaultState];
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (failure)
            failure(error);
        [self restoreDefaultState];
	}];
}

@end
