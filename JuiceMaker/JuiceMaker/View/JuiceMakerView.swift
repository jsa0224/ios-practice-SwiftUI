//
//  ContentView.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

struct JuiceMakerState: Equatable {
    var stock: [Int] = []
}

enum JuiceMakerAction: Equatable {
    case makingButtonTapped(juice: Juice)
    case decrementButtonTapped(fruit: Fruit)
    case incrementButtonTapped(fruit: Fruit)
    case confirmButtonTapped
    case cancelButtonTapped
}

struct JuiceMakerEnvironment { }

let juiceMakerReduce = Reduce<JuiceMakerState, JuiceMakerAction> { state, action in

    switch action {
    case .makingButtonTapped(let juice):
        // TODO: 쥬스 재료가 부족한 경우의 에러 처리는 어떻게 해야할까?
        for (fruit, amount) in juice.ingredient {
            state.stock[fruit.index] -= amount
        }

        return Effect.none
    case .decrementButtonTapped(let fruit):
        state.stock[fruit.index] -= 1

        return Effect.none
    case .incrementButtonTapped(let fruit):
        state.stock[fruit.index] += 1

        return Effect.none
    case .confirmButtonTapped:
        // TODO: 쥬스 재고 화면으로 넘겨야 함
        return Effect.none
    case .cancelButtonTapped:
        return Effect.none
    }
}

struct JuiceMakerView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceMakerView()
    }
}
