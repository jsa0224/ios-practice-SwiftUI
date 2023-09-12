//
//  JuiceMakingView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/09/12.
//

import SwiftUI

struct JuiceMakerView: View {
    var juice: Juice

    func ingredientText(_ shape: String, _ quantity: String) -> some View {
        HStack {
            Text(shape)
            Text(quantity)
        }
    }

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            HStack{
                ingredientText(juice.ingredient[0].0.shape, juice.ingredient[0].1.description)

                if juice.isNumberOfIngredientRequiredTwo {
                    Text("/")
                    ingredientText(juice.ingredient[1].0.shape, juice.ingredient[1].1.description)
                }
            }

            Image("믹서기")
                .resizable()
                .frame(width: 200, height: 200)

            Spacer()

            Button {

            } label: {
                Text("주문하기")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer()
        }
    }
}


struct JuiceMakingView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMakerView(juice: .mangoKiwiJuice)
    }
}
