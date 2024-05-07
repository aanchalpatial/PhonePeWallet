//
//  HomeViewModel.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 06/05/24.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchTransaction()
}

class HomeViewModel: HomeBusinessLogic {

    weak var view: HomeDisplayLogic?
    private let service: HomeServiceProtocol

    init(service: HomeServiceProtocol) {
        self.service = service
    }

    func fetchTransaction() {
        view?.animateLoader(start: true)
        service.getTransaction(fileName: "data") { [weak self] response in
            guard let self = self else {
                return
            }
            switch response {
            case .success(let transactionResponse):
                let transaction = self.convertResponseToTransaction(response: transactionResponse)
                DispatchQueue.main.async {
                    self.view?.animateLoader(start: false)
                    self.view?.renderTransaction(transaction: transaction)
                }
            case .failure(let failure):
                assertionFailure(failure.localizedDescription)
            }
        }
    }
    
    // Note: - This is part of presenter in clean swift
    private func convertResponseToTransaction(response: TransactionResponse) -> Transaction {
        let buyer = Transaction.Buyer(accountNo: response.buyer.accountNo, utr: response.buyer.utr)
        let seller = Transaction.Seller(name: response.seller.name, vpa: response.seller.vpa)
        let date = Date(timeIntervalSince1970: TimeInterval(response.timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let dateString = dateFormatter.string(from: date)
        var status: Transaction.Status
        if response.status == "SUCCESS" {
            status = .success
        } else if response.status == "FAILURE" {
            status = .failure
        } else {
            status = .pending
        }
        let transaction = Transaction(id: response.id,
                                      dateAndTime: dateString,
                                      status: status,
                                      amount: "Rs \(response.amount/100)",
                                      buyer: buyer,
                                      seller: seller)
        return transaction
    }
}
