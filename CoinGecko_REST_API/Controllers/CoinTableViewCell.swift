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
    
    private enum CoinTableViewCellMetrics {
        static let nameFontSize: CGFloat = 30.0
        static let smallFontSize: CGFloat = 15.0
        static let largeFontSize: CGFloat = 20.0
        static let padding: CGFloat = 25.0
        static let smallPadding: CGFloat = 8.0
        static let coinImagewidthAndHeight: CGFloat = 50.0
        static let cornerRadius: CGFloat = 5.0
        static let heightArrowImage: CGFloat = 30.0
        static let widthArrowImage: CGFloat = 20.0
    }
    
    // MARK: - Views
    private let coinImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill

        return image
    }()
    
    private let arrowImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.image = UIImage(systemName: "chevron.compact.right")
        image.tintColor = .lightGray
        
        return image
    }()
    
    private let labelContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .leading
        container.distribution = .fillProportionally

        return container
    }()
    
    private let nameLabel: UILabel = UILabel(textColor: .black, fontSize: CoinTableViewCellMetrics.largeFontSize, fontWeight: .bold, textAlignment: .left)
    private let priceLabel: UILabel = UILabel(textColor: .black, fontSize: CoinTableViewCellMetrics.smallFontSize, fontWeight: .regular, textAlignment: .left)
   
    private let percentageLabel: UILabel = {
        let label = UILabel(textColor: .black, fontSize: CoinTableViewCellMetrics.smallFontSize, fontWeight: .regular, textAlignment: .left)
        label.layer.cornerRadius = CoinTableViewCellMetrics.cornerRadius
        label.layer.masksToBounds = true
        
        return label
    }()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        addAllSubviews()
        constraintCoinImageView()
        constraintLabelContainer()
        constraintArrowImage()
    }
    
    // MARK: - Helper Methods
    private func updateViews() {
        guard let coin = coin else { return }
        
        fetchAndSetImage(coin: coin)
        
        nameLabel.text = coin.name
        priceLabel.text = "$\(coin.market.price.usd)"
        
        if coin.market.priceChange24HPercentage < 0 {
            percentageLabel.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            percentageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            percentageLabel.backgroundColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
            percentageLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        self.addSubview(labelContainer)
        self.addSubview(arrowImageView)
    }
    
    // MARK: - Constraints
    private func constraintCoinImageView() {
        coinImageView.anchor(top: self.contentView.topAnchor,
                             bottom: self.contentView.bottomAnchor,
                             leading: self.contentView.leadingAnchor,
                             trailing: nil,
                             paddingTop: CoinTableViewCellMetrics.padding,
                             paddingBottom: CoinTableViewCellMetrics.padding,
                             paddingLeft: CoinTableViewCellMetrics.padding,
                             paddingRight: CoinTableViewCellMetrics.padding,
                             width: CoinTableViewCellMetrics.coinImagewidthAndHeight,
                             height: CoinTableViewCellMetrics.coinImagewidthAndHeight)
    }
    
    private func constraintLabelContainer() {
        labelContainer.addArrangedSubview(nameLabel)
        labelContainer.addArrangedSubview(priceLabel)
        labelContainer.addArrangedSubview(percentageLabel)
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            labelContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -CoinTableViewCellMetrics.smallPadding),
            labelContainer.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: CoinTableViewCellMetrics.padding),
            labelContainer.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -CoinTableViewCellMetrics.padding)
        ])
    }
    
    private func constraintArrowImage() {
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -CoinTableViewCellMetrics.padding),
            arrowImageView.widthAnchor.constraint(equalToConstant: CoinTableViewCellMetrics.widthArrowImage),
            arrowImageView.heightAnchor.constraint(equalToConstant: CoinTableViewCellMetrics.heightArrowImage)
        ])
    }
}
