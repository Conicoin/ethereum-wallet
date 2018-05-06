//
//  ObjC.h
//  ethereum-wallet
//
//  Created by Artur Guseinov on 06/05/2018.
//  Copyright © 2018 Artur Guseinov. All rights reserved.
//

@import Foundation;

@interface ObjC : NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
