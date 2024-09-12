//
//  NetworkError.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

enum NetworkError: Error {
    case fetchDataError
    case fetchImageError
    
    var description: String {
        switch self {
        case .fetchDataError:
            return "Fetch Data Error."
        case .fetchImageError:
            return "Fetch Image Error."
        }
    }
}
