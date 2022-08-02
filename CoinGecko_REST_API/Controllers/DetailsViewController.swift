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
    
    private enum DetailsViewMetrics {
        static let nameFontSize: CGFloat = 30
        static let smallFontSize: CGFloat = 15.0
        static let largeFontSize: CGFloat = 20.0
        static let imageWidthAndHeight: CGFloat = 150
        static let closeButtonWidthAndHeight: CGFloat = 40
        static let padding: CGFloat = 20
        static let smallPadding: CGFloat = 10
        static let labelContainerHeight: CGFloat = 300
        static let noPadding: CGFloat = 0
    }
    
    // MARK: - Views
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let coinImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let nameLabel: UILabel = UILabel(textColor: .black, fontSize: DetailsViewMetrics.nameFontSize, fontWeight: .bold, textAlignment: .center)
    private let priceLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .bold, textAlignment: .left)
    private let percentageLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .bold, textAlignment: .left)
    private let percentage7DLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let percentage14DLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let percentage30DLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let percentage60DLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let percentage200DLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let percentage1YearLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .light, textAlignment: .left)
    private let totalSupplyLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .bold, textAlignment: .left)
    private let marketCapRankLabel: UILabel = UILabel(textColor: .darkGray, fontSize: DetailsViewMetrics.smallFontSize, fontWeight: .bold, textAlignment: .left)
    
    private let labelsContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.alignment = .fill
        container.distribution = .fillProportionally
        
        return container
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("❌", for: .normal)
        button.tintColor = .red
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        addAllSubviews()
        constraintСontainer()
        constraintImageView()
        constraintCloseButton()
        activateCloseButton()
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped(sender: UIButton) {
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
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: DetailsViewMetrics.smallPadding),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -DetailsViewMetrics.smallPadding),
            closeButton.widthAnchor.constraint(equalToConstant: DetailsViewMetrics.closeButtonWidthAndHeight),
            closeButton.heightAnchor.constraint(equalToConstant: DetailsViewMetrics.closeButtonWidthAndHeight)
        ])
    }
    
    private func constraintImageView() {
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: DetailsViewMetrics.noPadding),
            coinImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: DetailsViewMetrics.imageWidthAndHeight),
            coinImageView.heightAnchor.constraint(equalToConstant: DetailsViewMetrics.imageWidthAndHeight),
        ])
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
                               paddingTop: DetailsViewMetrics.smallPadding,
                               paddingBottom: DetailsViewMetrics.noPadding,
                               paddingLeft: DetailsViewMetrics.padding,
                               paddingRight: DetailsViewMetrics.padding,
                               height: DetailsViewMetrics.labelContainerHeight)
    }
}
