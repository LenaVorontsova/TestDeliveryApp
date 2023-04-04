//
//  CategoriesCollectionViewCell.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    static let collectionId = "CategoriesCollectionViewCell"
        
    lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.2) : .clear
            self.collectionLabel.textColor = isSelected ? UIColor(
                red: 0.992,
                green: 0.227,
                blue: 0.412,
                alpha: 1) : UIColor(
                    red: 0.992,
                    green: 0.227,
                    blue: 0.412,
                    alpha: 0.4)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius =  16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.992,
                                                green: 0.227,
                                                blue: 0.412,
                                                alpha: 0.4).cgColor
        contentView.layer.masksToBounds = true
        
        configureContstrains()
    }
    
    private func configureContstrains() {
        addSubview(collectionLabel)
        collectionLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }
}
