//
//  MenuViewController.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit
import SnapKit

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
//        presenter.getInfoCategories()
//        presenter.getInfoMeals()
        
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(row: bannersCollectionView.numberOfSections, section: 0)
        
        self.bannersCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
        
    private func setupViews() {
        self.bannersCollectionView.showsHorizontalScrollIndicator = false
            
        self.bannersCollectionView.dataSource = self
        self.bannersCollectionView.delegate = self
        self.bannersCollectionView.register(BannersCollectionViewCell.self,
                                                forCellWithReuseIdentifier: BannersCollectionViewCell.collectionCellId)
    }
        
    private func setCells(cells: [UIImage]) {
        self.cells = cells
    }
        
    private func configureConstraints() {
        view.addSubview(cityTitle)
        view.addSubview(downImage)
        view.addSubview(bannersCollectionView)
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
            $0.top.equalTo(cityTitle.safeAreaLayoutGuide.snp.bottom).offset(BannersConstant.bannerTop)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(513)
//            $0.bottom.equalTo(mealsTableView.safeAreaLayoutGuide.snp.top).offset(-TableViewConstants.tableTop)
        }
        mealsTableView.snp.makeConstraints { 
            $0.top.equalToSuperview().inset(268)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
            
    func reloadTable() {
        self.mealsTableView.reloadData()
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
        return 180
    }
}

extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannersCollectionViewCell.collectionCellId,
                for: indexPath) as? BannersCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.collectionImageView.image = cells[indexPath.row % cells.count]
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 200)
    }
}

