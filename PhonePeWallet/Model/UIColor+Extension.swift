//
//  File.swift
//  PhonePeWallet
//
//  Created by Aanchal Patial on 07/05/24.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension Decodable {
    static func parse(jsonFile: String) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json")
               else {
            throw NSError(domain: "JSONReaderErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Could not find JSON file with filename \(jsonFile)."])
        }
        let data = try Data(contentsOf: url)
        return try decoder.decode(Self.self, from: data)
    }
}
