//
//  String+.swift
//  Vollmed
//
//  Created by Quellenni Reis on 18/01/24.
//

import Foundation

extension String {
    func convertDateStringToReadleDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
