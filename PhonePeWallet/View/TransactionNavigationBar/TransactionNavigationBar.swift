//
//  TransactionNavigationBar.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 07/05/24.
//

import UIKit

class TransactionNavigationBar: UINavigationBar {


    @IBOutlet var contentView: UIView!

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var subtitle: UILabel!

    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        print("backButtonPressed")
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        print("shareButtonPressed")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customViewInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customViewInit()
    }

    private func customViewInit() {
        Bundle.main.loadNibNamed(String(describing: TransactionNavigationBar.self), owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(title: String, subtitle: String, backgroundColor: UIColor) {
        self.title.text = title
        self.subtitle.text = subtitle
        contentView.backgroundColor = backgroundColor
    }
}
