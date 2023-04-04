//
//  BannersCollectionViewCell.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit
import SnapKit

final class BannersCollectionViewCell: UICollectionViewCell {
    static let collectionCellId = "Banners"
        
    lazy var collectionImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureContstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContstrains() {
        addSubview(collectionImageView)
        collectionImageView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
