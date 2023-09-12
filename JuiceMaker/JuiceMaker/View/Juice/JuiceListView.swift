//
//  ContentView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct JuiceListView: View {
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
                            JuiceMakerView(store: store, juice: juice)
                        } label: {
                            HStack {
                                JuiceRowView(juice: juice)

                                ingredientText(juice.ingredient[0].0.shape, juice.ingredient[0].1.description)

                                if juice.isNumberOfIngredientRequiredTwo {
                                    Text("/")
                                    ingredientText(juice.ingredient[1].0.shape, juice.ingredient[1].1.description)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Juice Maker") // 이거 색깔 어케 바꿈,,
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceListView(store: Store(initialState: JuiceMaker.State()) {
            JuiceMaker()
                ._printChanges()
        })
    }
}
