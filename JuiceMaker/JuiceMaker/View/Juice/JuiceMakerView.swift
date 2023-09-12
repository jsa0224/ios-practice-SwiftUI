//
//  ContentView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct JuiceMakerView: View {
    let store: StoreOf<JuiceMaker>

    func ingredientText(_ shape: String, _ quantity: String) -> some View {
        HStack {
            Text(shape)
            Text(quantity)
        }
    }

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    ForEach(viewStore.juices, id: \.self) { juice in
                        NavigationLink {
                            FruitStoreView(store: store)
                        } label: {
                            HStack {
                                JuiceMenuView(juice: juice)

                                ingredientText(juice.ingredient[0].0.shape, juice.ingredient[0].1.description)

                                if juice.isNumberOfIngredientRequiredTwo {
                                    Text("/")
                                    ingredientText(juice.ingredient[1].0.shape, juice.ingredient[1].1.description)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Juice Maker")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMakerView(store: Store(initialState: JuiceMaker.State()) {
            JuiceMaker()
                ._printChanges()
        })
    }
}
