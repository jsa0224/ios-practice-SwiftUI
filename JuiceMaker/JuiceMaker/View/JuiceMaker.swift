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
        var isEnoughOfStock: Bool = true
    }

    enum Action: Equatable {
        case makingButtonTapped(juice: Juice)
        case decrementButtonTapped(fruit: Fruit)
        case incrementButtonTapped(fruit: Fruit)
        case deficientOfJuice
        case confirmButtonTapped
        case cancelButtonTapped
    }

    struct Environment { }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .makingButtonTapped(let juice):
            // TODO: 쥬스 재료가 부족한 경우의 에러 처리는 어떻게 해야할까?
            for (fruit, amount) in juice.ingredient {
                if state.stock[fruit.index] >= amount {
                    state.stock[fruit.index] -= amount

                    return Effect.none
                } else {
                    return .send(.deficientOfJuice)
                }
            }
            return Effect.none

        case .decrementButtonTapped(let fruit):
            state.stock[fruit.index] -= 1

            return Effect.none
        case .incrementButtonTapped(let fruit):
            state.stock[fruit.index] += 1

            return Effect.none

        case .deficientOfJuice:
            state.isEnoughOfStock = false
            
            return Effect.none
        case .confirmButtonTapped:
            // TODO: 쥬스 재고 화면으로 넘겨야 함
            return Effect.none
        case .cancelButtonTapped:
            return Effect.none
        }
    }
}
