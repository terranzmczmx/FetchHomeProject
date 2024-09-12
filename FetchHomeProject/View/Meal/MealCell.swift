//
//  MealCell.swift
//  FetchHomeProject
//
//  Created by Yingzhe Hu on 9/11/24.
//

import SwiftUI

struct MealCell: View {
    let meal: Meal
    @State private var image: UIImage?
    
    var body: some View {
        HStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            } else {
                Rectangle()
            }
            Text("\(meal.name)")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .task {
            do {
                if let loadedImage = try await ImageCache.shared.getImage(forKey: meal.imageUrl) {
                    image = loadedImage
                }
            } catch {
                print("Load Image Error")
            }
        }
    }
}

#Preview {
    MealCell(meal: Meal(id: "53049", name: "Apam balik", imageUrl: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
}
