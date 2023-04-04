//
//  MenuViewController.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit
import SnapKit

var whichCellSelect : String = "Dessert"

class MenuViewController: UIViewController, IViewControllers {
    private var cityTitle: UILabel = {
        var label = UILabel()
        label.text = "Москва"
        label.textColor = UIColor(red: 0.133, green: 0.157, blue: 0.192, alpha: 1)
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    private var downImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "downImage")
        return image
    }()
    private var bannersCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private var categoriesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    private var mealsTableView: UITableView = {
        var table = UITableView()
        table.backgroundColor = .white
        table.layer.cornerRadius = 20
        return table
    }()
    
    var cells = [UIImage]()
    private let images: [UIImage] = [UIImage(named: "banner1")!,
                                     UIImage(named: "banner2")!,
                                     UIImage(named: "banner3")!]
    let numberOfItems = 1000
    private let presenter: MenuPresenting
        
    init(_ presenter: MenuPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealsTableView.delegate = self
        mealsTableView.dataSource = self
        self.mealsTableView.register(MealTableViewCell.self,
                                     forCellReuseIdentifier: MealTableViewCell.identifier)
        
        setupViews()
        setCells(cells: images)
        self.view.backgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.976, alpha: 1)
        self.configureConstraints()
        
        presenter.loadData()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexPath = IndexPath(row: bannersCollectionView.numberOfSections, section: 0)
        self.bannersCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        let indexPathCat = IndexPath(row: categoriesCollectionView.numberOfSections, section: 0)
        self.categoriesCollectionView.scrollToItem(at: indexPathCat, at: .left, animated: false)
    }
        
    private func setupViews() {
        self.bannersCollectionView.showsHorizontalScrollIndicator = false
        self.categoriesCollectionView.showsHorizontalScrollIndicator = false
            
        self.bannersCollectionView.dataSource = self
        self.categoriesCollectionView.dataSource = self
        self.bannersCollectionView.delegate = self
        self.categoriesCollectionView.delegate = self
        
        self.bannersCollectionView.register(BannersCollectionViewCell.self,
                                                forCellWithReuseIdentifier: BannersCollectionViewCell.collectionCellId)
        self.categoriesCollectionView.register(CategoriesCollectionViewCell.self,
                                               forCellWithReuseIdentifier: CategoriesCollectionViewCell.collectionId)
    }
        
    private func setCells(cells: [UIImage]) {
        self.cells = cells
    }
        
    private func configureConstraints() {
        view.addSubview(cityTitle)
        view.addSubview(downImage)
        view.addSubview(bannersCollectionView)
        view.addSubview(categoriesCollectionView)
        view.addSubview(mealsTableView)
        cityTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(MenuConstants.cityTop)
            $0.leading.equalToSuperview().inset(MenuConstants.cityLead)
        }
        downImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(MenuConstants.downTop)
            $0.leading.equalToSuperview().inset(MenuConstants.downLead)
        }
        bannersCollectionView.snp.makeConstraints {
            $0.top.equalTo(cityTitle.safeAreaLayoutGuide.snp.bottom).offset(-BannersConstant.bannerTop)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(513)
        }
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(230)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(522)
        }
        mealsTableView.snp.makeConstraints { 
            $0.top.equalToSuperview().inset(280)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
            
    func reloadTable() {
        self.mealsTableView.reloadData()
        self.categoriesCollectionView.reloadData()
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as? MealTableViewCell else {
                return UITableViewCell()
        }
        let cellModel = MealTableViewCellFactory.cellModel(presenter.meal[indexPath.row])
        cell.config(with: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.isEqual(categoriesCollectionView) {
            whichCellSelect = presenter.categories[indexPath.row % presenter.categories.count].strCategory
            presenter.updateSelectedCategory(whichCellSelect)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.isEqual(self.bannersCollectionView) {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannersCollectionViewCell.collectionCellId,
                for: indexPath) as? BannersCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.collectionImageView.image = cells[indexPath.row % cells.count]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoriesCollectionViewCell.collectionId,
                for: indexPath) as? CategoriesCollectionViewCell else {
                return UICollectionViewCell()
            }
            if presenter.categories.count != 0 {
                cell.collectionLabel.text = presenter.categories[indexPath.row % presenter.categories.count].strCategory
            } else {
                cell.collectionLabel.text = "Dessert"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.isEqual(bannersCollectionView) {
            return CGSize(width: 300, height: 112)
        } else {
            return CGSize(width: 100, height: 32)
        }
    }
}

