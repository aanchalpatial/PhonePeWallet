//
//  HomeViewController.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 06/05/24.
//

import UIKit

// https://stackoverflow.com/questions/64177320/why-do-swift-class-only-protocols-need-anyobject-inheritance
protocol HomeDisplayLogic: AnyObject {
    func renderTransaction(transaction: Transaction)
    func animateLoader(start: Bool)
}

class HomeViewController: UIViewController, HomeDisplayLogic {

    private let viewModel: HomeBusinessLogic


    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var transactionNavigationBar: TransactionNavigationBar!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var transactionId: UILabel!
    @IBAction func copyTransactionIdButtonPressed(_ sender: UIButton) {
        print("copyTransactionIdButtonPressed")
    }

    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerVpa: UILabel!

    @IBOutlet weak var buyerAccount: UILabel!
    @IBOutlet weak var buyerUtr: UILabel!
    @IBAction func splitExpenseButtonPressed(_ sender: UIButton) {
        print("splitExpenseButtonPressed")
    }

    @IBOutlet var amountLabels: [UILabel]!
    

    init() {
        let viewModel = HomeViewModel(service: HomeService())
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.view = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchTransaction()
    }

    func renderTransaction(transaction: Transaction) {
        let transactionColor = UIColor(hex: transaction.status.colorHex)
        statusBarView.backgroundColor = transactionColor
        transactionNavigationBar.configure(title: transaction.status.message, subtitle: transaction.dateAndTime, backgroundColor: transactionColor ?? .blue)
        transactionId.text = transaction.id
        sellerName.text = transaction.seller.name
        sellerVpa.text = transaction.seller.vpa
        buyerAccount.text = transaction.buyer.accountNo
        buyerUtr.text = transaction.buyer.utr
        amountLabels.forEach { label in
            label.text = transaction.amount
        }
    }

    func animateLoader(start: Bool) {
        if start {
            transactionNavigationBar.isHidden = true
            mainStackView.isHidden = true
            loader.isHidden = false
            loader.startAnimating()
        } else {
            transactionNavigationBar.isHidden = false
            loader.isHidden = true
            mainStackView.isHidden = false
            loader.stopAnimating()
        }
    }
}
