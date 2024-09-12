//
//  NetworkManager.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import Foundation

class NetworkManager {
    private let baseUrl = "https://themealdb.com/api/json/v1/1"
    
    func fetchMeals() async throws -> [Meal] {
        let urlString = "\(baseUrl)/filter.php?c=Dessert"
        
        guard let url = URL(string: urlString) else { return [] }
        
        let mealResponse = try await fetchData(from: url, responseType: Response<Meal>.self)
        return mealResponse.meals.sorted { $0.name < $1.name }
    }
    
    func fetchMealDetails(id: String) async throws -> [MealDetail] {
        let urlString = "\(baseUrl)/lookup.php?i=\(id)"
        
        guard let url = URL(string: urlString) else { return [] }
        
        let mealDetailsResponse = try await fetchData(from: url, responseType: Response<MealDetail>.self)
        return mealDetailsResponse.meals
    }
    
    func fetchData<T: Decodable>(from url: URL, responseType: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.fetchDataError
            }
            
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw NetworkError.fetchDataError
        }
        
    }
}
