//
//  IngredientCell.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import SwiftUI

struct IngredientCell: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.title2)
                .fontWeight(.semibold)
            
            Divider()
            
            ForEach(ingredients) { ingredient in
                HStack {
                    Text("\(ingredient.name)")
                    
                    Spacer()
                    
                    Text("\(ingredient.measurement)")
                }
                .padding(.vertical)
                Divider()
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    IngredientCell(ingredients: [])
}
