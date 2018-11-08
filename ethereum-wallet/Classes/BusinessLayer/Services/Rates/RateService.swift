// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import Foundation

protocol RateSource {
  func fiatString(for amount: Currency, in iso: String) -> String
  func rawAmount(for amount: Currency, in iso: String) -> Decimal
  func fiatLabelString(currency: Currency, selectedCurrency: String) -> String
}

class RateService: RateSource {
  
  let rateRateRepository: RateRepository
  init(rateRepository: RateRepository) {
    self.rateRateRepository = rateRepository
  }
  
  // MARK: Privates
  private func rate(from: String, to: String) -> Rate? {
    return rateRateRepository.rates.first(where: { $0.from == from && $0.to == to })
  }
  
  func fiatString(for amount: Currency, in iso: String) -> String {
    guard let rate = rate(from: amount.iso, to: iso) else {
      return FiatCurrencyFactory.amount(currency: amount, iso: iso, rate: 0)
    }
    return FiatCurrencyFactory.amount(currency: amount, iso: iso, rate: rate.value)
  }
  
  func rawAmount(for amount: Currency, in iso: String) -> Decimal {
    guard let rate = rate(from: amount.iso, to: iso) else {
      return 0
    }
    return amount.value * Decimal(rate.value)
  }
  
  func fiatLabelString(currency: Currency, selectedCurrency: String) -> String {
    let description = Localized.balanceLabel(currency.iso.uppercased(), currency.name)
    guard selectedCurrency != currency.iso else {
      return description
    }
    return rawAmount(for: currency, in: selectedCurrency) == 0 ?
      description : fiatString(for: currency, in: selectedCurrency)
  }
  
}
