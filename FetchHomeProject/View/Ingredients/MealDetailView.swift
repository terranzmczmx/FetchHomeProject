//
//  MealDetailView.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    let networkManager: NetworkManager
    @State var mealDetail: MealDetail?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    if let mealDetail = mealDetail {
                        Text("\(mealDetail.name)")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Divider()
                            
                            Text("\(mealDetail.instructions)")
                        }
                        .padding(.vertical)
                        
                        Divider()
                        
                        IngredientCell(ingredients: mealDetail.ingredients)
                    }
                }
                .padding()
            }
        }
        .task {
            do {
                mealDetail = try await networkManager.fetchMealDetails(id: mealId).first
            } catch {
                print("Fetch Meal Detail Error.")
            }
        }
    }
}

#Preview {
    MealDetailView(mealId: "53049", networkManager: NetworkManager())
}
