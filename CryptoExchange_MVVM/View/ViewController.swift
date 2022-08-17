//
//  ViewController.swift
//  CryptoExchange_MVVM
//
//  Created by Tunahan on 8/5/22.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    
    private var cryptoListViewModel : CryptoListViewModel!
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Uygulama calıstı")
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [
                UIColor(red: 74/255, green: 57/225, blue: 204/225, alpha: 1.0),
                UIColor(red: 14/255, green: 147/225, blue: 14/225, alpha: 1.0),
                ]
        
        getData()
        
    }
    
    func getData(){
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
      
        WebService().downloadCurrencies(url: url) { (cryptoS) in
            
            if let cryptoS = cryptoS {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList:cryptoS)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cryptoListViewModel == nil ? 1 : self.cryptoListViewModel!.numberOfRowsInsection()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCrypto",for:indexPath) as! CryptoTableViewCell
      
        
        if cryptoListViewModel?.cryptoAtIndex(indexPath.row)  != nil {
            
            let cryptoViewModel = self.cryptoListViewModel.cryptoAtIndex(indexPath.row)
            cell.priceText.text = cryptoViewModel.name
            cell.currencyText.text = cryptoViewModel.price
            cell.backgroundColor = self.colorArray[indexPath.row % 2]
        }
        
        
        
        
        return cell
    }

    
  

}

