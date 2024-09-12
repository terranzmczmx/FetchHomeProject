//
//  Response.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

struct Response<T: Codable>: Codable {
    let meals: [T]
}
