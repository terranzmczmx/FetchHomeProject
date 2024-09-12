//
//  MealDetail.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

struct MealDetail: Codable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [Ingredient]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: MealDetailCodingKeys.self)
                
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions).formatted()
        self.ingredients = try MealDetail.parseIngredients(from: decoder)
    }
    
    private static func parseIngredients(from decoder: any Decoder) throws -> [Ingredient] {
        var ingredients: [Ingredient] = []
                
        let ingredientContainer = try decoder.container(keyedBy: IngredientKeys.self)
        let measurementContainer = try decoder.container(keyedBy: MeasurementKeys.self)
        
        for i in 1...20 {
            guard 
                let ingredientNameKey = IngredientKeys(stringValue: "strIngredient\(i)"),
                let measurementKey = MeasurementKeys(stringValue: "strMeasure\(i)"),
                let ingredientName = try ingredientContainer.decodeIfPresent(String.self, forKey: ingredientNameKey),
                let measurement = try measurementContainer.decodeIfPresent(String.self, forKey: measurementKey),
                ingredientName != "",
                measurement != "" 
            else { continue }
            
            if !ingredients.contains(where: { $0.name == ingredientName }) {
                let ingredient = Ingredient(
                    id: "\(i)-\(ingredientName)-\(measurement)",
                    name: ingredientName.capitalized,
                    measurement: measurement
                )
                ingredients.append(ingredient)
            }
        }
        return ingredients
    }
}

extension String {
    func formatted() -> String {
        return self
            .replacingOccurrences(of: "\r", with: "\n")
            .replacingOccurrences(of: "\n\n\n\n", with: "\n\n")
    }
}
