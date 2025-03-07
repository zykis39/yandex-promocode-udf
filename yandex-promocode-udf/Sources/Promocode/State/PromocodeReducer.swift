//
//  PromocodeReducer.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import Foundation
import UDF

extension Actions {
    struct ChangePromocodeTapped: Action {
        enum Direction { case left, right }
        
        let direction: Direction
    }
    struct SelectPromocode: Action {
        let promocode: Promocode
    }
    
    struct LoadPromocodes: Action {}
}

struct PromocodeReducer: Reducible {
    enum LoadingState { case none, loading }
    
    var state: LoadingState = .none
    var promocodes: [Promocode] = []
    var selectedPromocode: Promocode?
    
    mutating func reduce(_ action: some Action) {
        switch action {
        case is Actions.LoadPromocodes:
            state = .loading
        case let action as Actions.DidLoadItems<Promocode>:
            promocodes = action.items
            // FIXME: send Actions.SelectPromocode
            selectedPromocode = action.items.first
            state = .none
        case let action as Actions.ChangePromocodeTapped:
            guard promocodes.count > 0,
                  let selectedPromocode = selectedPromocode,
                  let currentIndex = promocodes.firstIndex(of: selectedPromocode) else { break }
            
            switch action.direction {
            case .right:
                if promocodes.count - 1 == currentIndex {
                    guard let promocode = promocodes.first else { break }
                    // FIXME: send Actions.SelectPromocode
                    self.selectedPromocode = promocode
                } else {
                    let promocode = promocodes[currentIndex + 1]
                    // FIXME: send Actions.SelectPromocode
                    self.selectedPromocode = promocode
                }
            case .left:
                if currentIndex == 0 {
                    guard let promocode = promocodes.last else { break }
                    // FIXME: send Actions.SelectPromocode
                    self.selectedPromocode = promocode
                } else {
                    let promocode = promocodes[currentIndex - 1]
                    // FIXME: send Actions.SelectPromocode
                    self.selectedPromocode = promocode
                }
            }
        case let action as Actions.SelectPromocode:
            print("PromocodeReducer Actions.SelectPromocode")
            selectedPromocode = action.promocode
        default:
            break
        }
    }
}
