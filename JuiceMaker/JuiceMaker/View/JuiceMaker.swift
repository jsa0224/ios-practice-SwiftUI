//
//  JuiceMaker.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/09/07.
//

import ComposableArchitecture

struct JuiceMaker: Reducer {
    struct State: Equatable {
        let juices: [Juice] = Juice.allCases
        var stock: [Int] = [Int](repeating: 10, count: Fruit.allCases.count)
        var isEnoughOfStock: Bool = false
        var isDeficientOfStock: Bool = false
        var isShowingDetailView: Bool = false
    }

    enum Action: Equatable {
        case makingButtonTapped(juice: Juice)
        case decrementButtonTapped(fruit: Fruit)
        case incrementButtonTapped(fruit: Fruit)
        case isEnoughFruit(isEnough: Bool)
        case isDeficientFruit(isDeficient: Bool)
        case confirmButtonTapped(isConfirmButtonTapped: Bool)
        case cancelButtonTapped
    }

    struct Environment { }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .makingButtonTapped(let juice):
            for (fruit, amount) in juice.ingredient {
                if state.stock[fruit.index] >= amount {
                    state.stock[fruit.index] -= amount
                    return .send(.isEnoughFruit(isEnough: true))

                } else {
                    return .send(.isDeficientFruit(isDeficient: true))
                }
            }
            return Effect.none

        case .decrementButtonTapped(let fruit):
            state.stock[fruit.index] -= 1

            return Effect.none
        case .incrementButtonTapped(let fruit):
            state.stock[fruit.index] += 1

            return Effect.none

        case .isEnoughFruit(let isEnough):
            state.isEnoughOfStock = isEnough
            
            return Effect.none
        case .isDeficientFruit(let isDeficient):
            state.isDeficientOfStock = isDeficient

            return Effect.none
        case .confirmButtonTapped(let isConfirmButtonTapped):
            state.isShowingDetailView = isConfirmButtonTapped
            return Effect.none
        case .cancelButtonTapped:
            return Effect.none
        }
    }
}
