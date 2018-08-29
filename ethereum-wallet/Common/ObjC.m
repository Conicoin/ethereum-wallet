// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

#import "ObjC.h"

@implementation ObjC

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error {
  @try {
    tryBlock();
    return YES;
  }
  @catch (NSException *exception) {
    *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:exception.userInfo];
    return NO;
  }
}

@end
