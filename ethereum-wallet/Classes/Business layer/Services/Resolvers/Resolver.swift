// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov

import Foundation

class ResolverChain<Input, ReturnType> {
  
  private let resolvers: [Resolver<Input, ReturnType>]
  private let fallback: ReturnType
  
  init(resolvers: [Resolver<Input, ReturnType>], fallback: ReturnType) {
    self.resolvers = resolvers
    self.fallback = fallback
  }
  
  func resolve(_ input: Input) -> ReturnType {
    for resolver in resolvers {
      if let resolved = resolver.transformer(input) {
        return resolved
      }
    }
    return fallback
  }
  
}

class Resolver<Input, ReturnType> {
  
  let transformer: (Input) -> ReturnType?
  
  init(transformer: @escaping (Input) -> ReturnType?) {
    self.transformer = transformer
  }
  
}
