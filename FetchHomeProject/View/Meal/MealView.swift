//
//  MealView.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import SwiftUI

struct MealView: View {
    @State private var meals = [Meal]()
    private let networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 5) {
                    ForEach(meals, id: \.id) { meal in
                        NavigationLink(destination: MealDetailView(mealId: meal.id, networkManager: networkManager)) {
                            MealCell(meal: meal)
                                .foregroundStyle(.black)
                        }
                        Divider()
                    }
                }
            }
            .navigationTitle("Desserts")
            .padding(.top)
        }
        .task {
            do {
                meals = try await networkManager.fetchMeals()
            } catch {
                print("Fetch Meals Error.")
            }
        }
    }
}

#Preview {
    MealView()
}
