//
//  CoinsViewController.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 7/29/22.
//

import Foundation
import UIKit

class CoinsViewController: UIViewController {
    
    // MARK: - Properties
    var coins: [Coin] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllSubviews()
        constarainTableView()
        setupViews()
        configureTableView()
        fetchAllCoins()
    }
    
    // MARK: - Helper Methods
    private func setupViews() {
        self.view.backgroundColor = .white
        self.title = "Prices"
    }
    
    private func addAllSubviews() {
        self.view.addSubview(coinListTableView)
    }
    
    // MARK: - Constraints
    private func constarainTableView() {
        coinListTableView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor,
                                 bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                                 leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                                 trailing: self.view.safeAreaLayoutGuide.trailingAnchor,
                                 paddingTop: 0,
                                 paddingBottom: 0,
                                 paddingLeft: 0,
                                 paddingRight: 0)
    }
    
    private func configureTableView() {
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        coinListTableView.register(CoinTableViewCell.self, forCellReuseIdentifier: "coinCell")
    }
    
    private func fetchAllCoins() {
        WebService.shared.fetchAllCoins { result in
            switch result {
            case .success(let coins):
                DispatchQueue.main.async {
                    self.coins = coins
                    self.coinListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
                
            }
        }
    }
    
    // MARK: - Views
    let coinListTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
}

// MARK: - Extensions
extension CoinsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath) as? CoinTableViewCell else { return UITableViewCell() }
        let coin = coins[indexPath.row]
        cell.coin = coin
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = coins[indexPath.row]
        let detailVC = DetailsViewController()
        detailVC.coin = coin
        self.navigationController?.present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
