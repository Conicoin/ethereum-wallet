// Copyright © 2018 Conicoin LLC. All rights reserved.
// Created by Artur Guseinov


import UIKit


class ChooseCurrencyViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  
  var output: ChooseCurrencyViewOutput!
  
  
  var currencies: [FiatCurrency] = FiatCurrencyFactory.create()
  
  // MARK: Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = Localized.chooseCurrencyTitle()
    tableView.contentInset.top = 16
    tableView.setupBorder()
    output.viewIsReady()
  }

}

// MARK: - TableView

extension ChooseCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(ChooseCurrencyCell.self, for: indexPath)
    cell.configure(with: currencies[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    output.didSelectCurrency(currencies[indexPath.row])
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencies.count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 56
  }
  
}

// MARK: - ChooseCurrencyViewInput

extension ChooseCurrencyViewController: ChooseCurrencyViewInput {
  
  func setupInitialState() {
    
  }
  
  func selectCurrency(with iso: String) {
    guard let index = currencies.index(where: { $0.iso == iso }) else {
      return
    }
    let indexPath = IndexPath(row: index, section: 0)
    tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
  }
  
}
