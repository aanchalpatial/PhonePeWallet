//
//  TransactionResponse.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 07/05/24.
//

import Foundation

struct TransactionResponse: Decodable {
    let id: String
    let timestamp: Int
    let status: String
    let amount: Int
    let buyer: Buyer
    let seller: Seller


    private enum CodingKeys: String, CodingKey {
        case id = "txnId"
        case timestamp = "txnTime"
        case buyer = "from"
        case seller = "to"
        case status, amount
    }

    struct Seller: Decodable {
        let name: String
        let vpa: String
    }

    struct Buyer: Decodable {
        let accountNo: String
        let utr: String
    }
}
