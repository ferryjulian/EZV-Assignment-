//
//  HomePageViewController.swift
//  EZV_Assignment
//
//  Created by Ferry Julian on 17/03/23.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var contentTableView: UITableView!
    
    var contentProduct = [DataProduct]()
    var viewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupAPI()
    }

}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentProduct.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let show = contentProduct[indexPath.row]
        let urlString = (show.thumbnail)!
        let url = URL(string: urlString)!

        cell.titleLabel.text = show.title
        cell.descriptionLabel.text = show.description
        cell.thumbnailImage.downloaded(from: url)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFav(tapGestureRecognizer:)))
        cell.loveImage.isUserInteractionEnabled = true
        cell.loveImage.addGestureRecognizer(tapGestureRecognizer)


        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let controller = DetailPageViewController()
        let detail = detailContent(indexPath: indexPath)
        controller.detail = DataProduct(id: detail.id, title: detail.title, description: detail.description, price: detail.price, discountPercentage: detail.discountPercentage, rating: detail.rating, stock: detail.stock, brand: detail.brand, category: detail.category, thumbnail: detail.thumbnail, images: detail.images)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func detailContent(indexPath: IndexPath) -> DataProduct{
        return contentProduct[indexPath.row]
    }

    func setupTableView() {
        self.contentTableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: "HomeTableViewCell")
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
    }
    
    func setupAPI() {
        NetworkingHelper.shared.getData(endpoint: "/products", type: Products.self) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.contentProduct = data.products ?? []
                    self.contentTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func tapFav(tapGestureRecognizer: UITapGestureRecognizer) {
        print("Favorite Ditambahkan")
    }
}
