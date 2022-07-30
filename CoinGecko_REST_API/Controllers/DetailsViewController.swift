//
//  DetailsViewController.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 7/30/22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    var coin: Coin?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        addAllSubviews()
        constraintСontainer()
        constaintImageView()
        constraintCloseButton()
        activateCloseButton()
    }
    
    // MARK: - Actions
    @objc func closeButtonTapped(sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Helper Methods
    private func addAllSubviews() {
        self.view.addSubview(labelsContainer)
        self.view.addSubview(coinImageView)
        self.view.addSubview(closeButton)
    }
    
    private func updateViews() {
        view.backgroundColor = .white
        
        guard let coin = coin else { return }
        
        fetchAndSetImage(coin: coin)
        
        nameLabel.text = coin.name
        priceLabel.text = "Price: $\(coin.market.price.usd)"
        
        if coin.market.priceChange24HPercentage < 0 {
            percentageLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            percentageLabel.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        }
        
        percentageLabel.text = "Percentage (24 hours): \(coin.market.priceChange24HPercentage)%"
        percentage7DLabel.text = "Percentage (7 days): \(coin.market.priceChange7DPercentage)%"
        percentage14DLabel.text = "Percentage (14 days): \(coin.market.priceChange14DPercentage)%"
        percentage30DLabel.text = "Percentage (30 days): \(coin.market.priceChange30DPercentage)%"
        percentage60DLabel.text = "Percentage (60 days): \(coin.market.priceChange60DPercentage)%"
        percentage200DLabel.text = "Percentage (200 days): \(coin.market.priceChange200DPercentage)%"
        percentage1YearLabel.text = "Percentage (1 year): \(coin.market.priceChange1YearPercentage)%"
        guard let total = coin.market.totalSupply else { return }
        totalSupplyLabel.text = "Total supply: \(total)"
        marketCapRankLabel.text = "Market Cap Rank: \(coin.market.marketCapRank)"
    }
    
    private func fetchAndSetImage(coin: Coin) {
        WebService.shared.fetchLargeImage(for: coin) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.coinImageView.image = image
                }
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    private func activateCloseButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Constraints
    private func constraintCloseButton() {
        closeButton.anchor(top: self.view.topAnchor,
                           bottom: nil,
                           leading: self.view.leadingAnchor,
                           trailing: nil,
                           paddingTop: 10,
                           paddingBottom: 0,
                           paddingLeft: self.view.frame.width - 60,
                           paddingRight: 0,
                           width: 40,
                           height: 40)
    }
    
    private func constaintImageView() {
        coinImageView.anchor(top: self.closeButton.bottomAnchor,
                             bottom: nil,
                             leading: nil,
                             trailing: self.view.trailingAnchor,
                             paddingTop: 10,
                             paddingBottom: 0,
                             paddingLeft: 0,
                             paddingRight: 0,
                             width: self.view.frame.width,
                             height: 150)
    }
    
    private func constraintСontainer() {
        labelsContainer.addArrangedSubview(nameLabel)
        labelsContainer.addArrangedSubview(priceLabel)
        labelsContainer.addArrangedSubview(percentageLabel)
        labelsContainer.addArrangedSubview(percentage7DLabel)
        labelsContainer.addArrangedSubview(percentage14DLabel)
        labelsContainer.addArrangedSubview(percentage30DLabel)
        labelsContainer.addArrangedSubview(percentage60DLabel)
        labelsContainer.addArrangedSubview(percentage200DLabel)
        labelsContainer.addArrangedSubview(percentage1YearLabel)
        labelsContainer.addArrangedSubview(totalSupplyLabel)
        labelsContainer.addArrangedSubview(marketCapRankLabel)
        
        labelsContainer.anchor(top: self.coinImageView.bottomAnchor,
                         bottom: nil,
                         leading: self.view.leadingAnchor,
                         trailing: self.view.trailingAnchor,
                         paddingTop: 10,
                         paddingBottom: 0,
                         paddingLeft: 23,
                         paddingRight: 23,
                         height: 300)
    }
   
    // MARK: - Views
    let coinImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage7DLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage14DLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage30DLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage60DLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage200DLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let percentage1YearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let totalSupplyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .darkGray
        
        return label
    }()
    
    let labelsContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .fill
        container.distribution = .fillProportionally
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("❌", for: .normal)
        button.tintColor = .red
    
        return button
    }()
}
