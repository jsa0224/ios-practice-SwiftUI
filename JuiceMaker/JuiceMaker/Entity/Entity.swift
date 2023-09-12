//
//  AppState.swift
//  JuiceMaker
//
//  Created by 정선아 on 2023/08/30.
//

import SwiftUI
import ComposableArchitecture

enum Juice: String, CaseIterable {
    case strawberryJuice = "딸기쥬스"
    case bananaJuice = "바나나쥬스"
    case kiwiJuice = "키위쥬스"
    case pineappleJuice = "파인애플쥬스"
    case mangoJuice = "망고쥬스"
    case strawberryBananaJuice = "딸바쥬스"
    case mangoKiwiJuice = "망키쥬스"

    var name: String {
        self.rawValue
    }

    var image: Image {
        Image(self.name)
    }

    var ingredient: [(Fruit, Int)] {
        switch self {
        case .strawberryJuice:
            return [(.strawberry, 16)]
        case .bananaJuice:
            return [(.banana, 2)]
        case .kiwiJuice:
            return [(.kiwi, 3)]
        case .pineappleJuice:
            return [(.pineapple, 2)]
        case .mangoJuice:
            return [(.mango, 3)]
        case .strawberryBananaJuice:
            return [(.strawberry, 10), (.banana, 1)]
        case .mangoKiwiJuice:
            return [(.mango, 2), (.kiwi, 1)]
        }
    }

    var isNumberOfIngredientRequiredTwo: Bool {
        switch self {
        case .strawberryJuice:
            return false
        case .bananaJuice:
            return false
        case .kiwiJuice:
            return false
        case .pineappleJuice:
            return false
        case .mangoJuice:
            return false
        case .strawberryBananaJuice:
            return true
        case .mangoKiwiJuice:
            return true
        }
    }
}

enum Fruit: Int, CaseIterable {
    case strawberry
    case banana
    case pineapple
    case kiwi
    case mango

    var index: Int {
        self.rawValue
    }

    var shape: String {
        switch self {
        case .strawberry:
            return "🍓"
        case .banana:
            return "🍌"
        case .pineapple:
            return "🍍"
        case .kiwi:
            return "🥝"
        case .mango:
            return "🥭"
        }
    }
}


