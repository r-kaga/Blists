

import Foundation
import UIKit

class BookDetailViewController: UIViewController {
    
    private let model: BookDetailModel!
    override func loadView() {
        self.view = BookDetailView()
    }
    
    required init(data: BookLists) {
        self.model = BookDetailModel(data: data)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let detailView = self.view as! BookDetailView
        detailView.titleLabel.text = model.book.title
        detailView.subtitleLabel.text = model.book.subTitle
        detailView.authorLabel.text = model.book.authors[0]
        detailView.publishedDateLabel.text = model.book.publishedDate
        detailView.pageCountLabel.text = String(model.book.pageCount)
        detailView.explanationArea.text = model.book.explanation
        detailView.buyRakutenButton.addTarget(self, action: #selector(openRakutenApp), for: .touchUpInside)
        detailView.buyAmazonButton.addTarget(self, action: #selector(openAmazonApp), for: .touchUpInside)
    }
    
    @objc private func openAmazonApp() {
        Alert(title: "Amazonで開きます", message: "AmazonのAppに遷移します")
            .addAction(title: "OK", style: .default) { (action) in
                let url = URL(string: "http://www.amazon.co.jp/dp/\(self.model.book.ISBN_10)")!
                let appScheme = URL(string: "com.amazon.mobile.shopping://")!
                if UIApplication.shared.canOpenURL(appScheme) {
                    UIApplication.shared.open(appScheme)
                } else {
                    UIApplication.shared.open(url)
                }
            }
            .open()
    }
    
    @objc private func openRakutenApp() {
        Alert(title: "楽天で開きます", message: "楽天のAppに遷移します")
            .addAction(title: "OK", style: .default) { (action) in
                let url = URL(string: "https://books.rakuten.co.jp/search/dt?g=001&bisbn=\(self.model.book.ISBN_10)")!
                let appScheme = URL(string: "Rakuten://")!
                if UIApplication.shared.canOpenURL(appScheme) {
                    UIApplication.shared.open(appScheme)
                } else {
                    UIApplication.shared.open(url)
                }
            }
            .open()
    }
    
}
