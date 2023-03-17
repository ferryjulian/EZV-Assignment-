//
//  DetailPageViewController.swift
//  EZV_Assignment
//
//  Created by Ferry Julian on 17/03/23.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    var detail: DataProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = detail.title
        descLabel.text = detail.description
        brandLabel.text = "Brand: \(detail.brand ?? "")"
        priceLabel.text = "Price: $\(detail.price ?? 0)"
        stockLabel.text = "Stock: \(detail.stock ?? 0)"

        guard let posterImageURL = URL(string: detail.thumbnail!) else {
            self.thumbImage.image = UIImage(named: "noImageAvailable")
            return
        }

        self.thumbImage.image = nil
        getImageDataFrom(url: posterImageURL)

    }
    
    // MARK: - Get image data
      private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Handle Error
            if error != nil {
            print("DataTask error: (error.localizedDescription)")
            return
          }

          guard let data = data else {
            // Handle Empty Data
            print("Empty Data")
            return
          }

          DispatchQueue.main.async {
            if let image = UIImage(data: data) {
              self.thumbImage.image = image
            }
          }
        }.resume()
      }
}
