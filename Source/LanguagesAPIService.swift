//
//  LanguagesAPIService.swift
//  ProjectSkeleton
//
//  Created by Tomas Kohout on 4/12/16.
//  Copyright © 2016 Ackee s.r.o. All rights reserved.
//

import Foundation
import ReactiveSwift
import ACKReactiveExtensions
import Argo

enum APIError: Error {
    case mapping(DecodeError)
}

protocol LanguagesAPIServicing {
    func languages() -> SignalProducer<[Language], APIError>
}

class LanguagesAPIService: LanguagesAPIServicing {
    
    func languages() -> SignalProducer<[Language], APIError> {
        
        let jsonPath = Bundle(for: LanguagesAPIService.self).path(forResource: "languages", ofType: "json")!
        let data = FileManager.default.contents(atPath: jsonPath)!
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        return rac_decode(object: json as AnyObject).mapError { .mapping($0) }
    }
}
