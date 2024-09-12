//
//  Meal.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

struct Meal: Codable {
    let id: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case imageUrl = "strMealThumb"
    }
}
