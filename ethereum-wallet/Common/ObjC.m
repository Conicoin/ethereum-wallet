//
//  ObjC.m
//  ethereum-wallet
//
//  Created by Artur Guseinov on 06/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

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
