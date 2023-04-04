//
//  MealTableViewCell.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit
import SnapKit

struct MealTableViewCellModel {
    let strMeal: String?
    let strMealThumb: String?
}

enum MealTableViewCellFactory {
    static func cellModel(_ inf: Meal) -> MealTableViewCellModel {
        MealTableViewCellModel(strMeal: inf.strMeal, strMealThumb: inf.strMealThumb)
    }
}

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class MealTableViewCell: UITableViewCell {
    lazy var tableImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    private lazy var strMealLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        self.configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with model: MealTableViewCellModel) {
        strMealLabel.text = model.strMeal
        let url = URL(string: model.strMealThumb!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async { [self] in
                tableImage.image = UIImage(data: data!)
            }
        }
    }
    
    func configureConstraints() {
        contentView.addSubview(tableImage)
        contentView.addSubview(strMealLabel)
        tableImage.snp.makeConstraints {
            $0.height.width.equalTo(TableCellConstants.heightImage)
            $0.top.bottom.equalToSuperview().inset(TableCellConstants.topBottomImage)
            $0.leading.equalToSuperview().inset(TableCellConstants.leadImage)
        }
        strMealLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(TableCellConstants.strLabelLeadTop)
            $0.leading.equalTo(tableImage.safeAreaLayoutGuide.snp.trailing).offset(TableCellConstants.strLabelLeadTop)
            $0.trailing.equalToSuperview().inset(TableCellConstants.strMealLabelTrail)
        }
    }
}

extension MealTableViewCell: ReusableView {
    static var identifier: String {
        return "MealTableViewCell"
    }
}
