// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

@import Foundation;

@interface ObjC : NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
