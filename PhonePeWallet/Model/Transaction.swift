//
//  Transaction.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 06/05/24.
//

import Foundation

struct Transaction {
    let id: String
    let dateAndTime: String
    let status: Status
    let amount: String
    let buyer: Buyer
    let seller: Seller

    enum Status {
        case success, failure, pending

        var message: String {
            switch self {
            case .success:
                return "Transaction Successfull"
            case .failure:
                return "Transaction Failed"
            case .pending:
                return "Transaction Pending"
            }
        }

        var colorHex: String {
            switch self {
            case .success:
                return "#7ABA78FF"
            case .failure:
                return "#C40C0CFF"
            case .pending:
                return "#FFDB5CFF"
            }
        }
    }

    struct Seller {
        let name: String
        let vpa: String
    }

    struct Buyer {
        let accountNo: String
        let utr: String
    }
}


