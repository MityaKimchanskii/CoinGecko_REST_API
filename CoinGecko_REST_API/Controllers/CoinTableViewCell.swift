//
//  CoinTableViewCell.swift
//  CoinGecko_REST_API
//
//  Created by Mitya Kim on 7/29/22.
//

import UIKit

class CoinTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var coin: Coin? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        addAllSubviews()
        constraintCoinImageView()
        constraintCoinNameLabel()
        constraintCoinPriceLabel()
        constraintPercentageLabel()
    }
    
    // MARK: - Helper Methods
    private func updateViews() {
        guard let coin = coin else { return }
        
        fetchAndSetImage(coin: coin)
        
        nameLabel.text = coin.name
        priceLabel.text = "$\(coin.market.price.usd)"
        
        if coin.market.priceChange24HPercentage < 0 {
            percentageLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            percentageLabel.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
        }
        percentageLabel.text = "\(coin.market.priceChange24HPercentage)%"
    }
    
    private func fetchAndSetImage(coin: Coin) {
        WebService.shared.fetchImage(for: coin) { result in
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
    
    private func addAllSubviews() {
        self.addSubview(coinImageView)
        self.addSubview(nameLabel)
        self.addSubview(priceLabel)
        self.addSubview(percentageLabel)
    }
    
    // MARK: - Constraints
    private func constraintCoinImageView() {
        coinImageView.anchor(top: self.contentView.topAnchor,
                             bottom: self.contentView.bottomAnchor,
                             leading: self.contentView.leadingAnchor,
                             trailing: nil,
                             paddingTop: 25,
                             paddingBottom: 25,
                             paddingLeft: 25,
                             paddingRight: 0,
                             width: 50,
                             height: 50)
    }
    
    private func constraintCoinNameLabel() {
        nameLabel.anchor(top: self.contentView.topAnchor,
                         bottom: self.priceLabel.topAnchor,
                         leading: self.coinImageView.trailingAnchor,
                         trailing: self.contentView.trailingAnchor,
                         paddingTop: 15,
                         paddingBottom: 8,
                         paddingLeft: 25,
                         paddingRight: 0)
    }

    private func constraintCoinPriceLabel() {
        priceLabel.anchor(top: nil,
                          bottom: nil,
                          leading: self.coinImageView.trailingAnchor,
                          trailing: nil,
                          paddingTop: 0,
                          paddingBottom: 0,
                          paddingLeft: 25,
                          paddingRight: 0)
    }

    private func constraintPercentageLabel() {
        percentageLabel.anchor(top: self.priceLabel.bottomAnchor,
                               bottom: self.contentView.bottomAnchor,
                               leading: self.coinImageView.trailingAnchor,
                               trailing: nil,
                               paddingTop: 0,
                               paddingBottom: 10,
                               paddingLeft: 25,
                               paddingRight: 0)
    }
    
    // MARK: - Views
    let coinImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill

        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
}
