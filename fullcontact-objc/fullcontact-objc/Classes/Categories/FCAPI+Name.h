/*
 FCAPI+Name.h
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

#import "FCAPI.h"

@interface FCAPI (Name)

-(void)normalizeName:(NSString*)query
         success:(FCSuccessBlock)success
         failure:(FCFailureBlock)failure;

-(void)deduceFromEmail:(NSString*)email
         success:(FCSuccessBlock)success
         failure:(FCFailureBlock)failure;

-(void)deduceFromUserName:(NSString*)userName
         success:(FCSuccessBlock)success
         failure:(FCFailureBlock)failure;

-(void)compareSimilarity:(NSString*)query1
                    with:(NSString*)query2
                  success:(FCSuccessBlock)success
                  failure:(FCFailureBlock)failure;

-(void)statsForName:(NSString*)name
                  success:(FCSuccessBlock)success
                  failure:(FCFailureBlock)failure;

-(void)statsForGivenName:(NSString*)givenName
            success:(FCSuccessBlock)success
            failure:(FCFailureBlock)failure;

-(void)statsForFamilyName:(NSString*)familyName
            success:(FCSuccessBlock)success
            failure:(FCFailureBlock)failure;

-(void)statsForGivenName:(NSString*)givenName
           andFamilyName:(NSString*)familyName
            success:(FCSuccessBlock)success
            failure:(FCFailureBlock)failure;

-(void)parse:(NSString*)query
                  success:(FCSuccessBlock)success
                  failure:(FCFailureBlock)failure;

@end
