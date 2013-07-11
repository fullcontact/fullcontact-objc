/*
 FCAPI+Icon.h
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

#if __IPHONE_OS_VERSION_MIN_REQUIRED
typedef void(^FCImageSuccessBlock)		(UIImage* response);
#elif __MAC_OS_X_VERSION_MIN_REQUIRED
typedef void(^FCImageSuccessBlock)		(NSImage* response);
#endif

typedef void(^FCImageFailureBlock)		(NSError* error);

#import "FCAPI.h"

@interface FCAPI (Icon)

- (void)getIcon:(NSString*)typeId
       withSize:(NSInteger)size
       andStyle:(NSString*)style
        success:(FCImageSuccessBlock)success
        failure:(FCImageFailureBlock)failure;

@end
