// ethereum-wallet https://github.com/flypaper0/ethereum-wallet
// Copyright (C) 2018 Artur Guseinov
//
// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU General Public License as published by the Free
// Software Foundation, either version 3 of the License, or (at your option)
// any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
// more details.
//
// You should have received a copy of the GNU General Public License along with
// this program.  If not, see <http://www.gnu.org/licenses/>.


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
