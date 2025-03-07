//
//  Container.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import SwiftUI
import UDF

struct PromocodeContainer: Container {
    typealias ContainerComponent = PromocodeComponent
    
    func scope(for state: AppState) -> Scope {
        state
    }

    // MARK: PropsBuilder
    func map(store: EnvironmentStore<AppState>) -> ContainerComponent.Props {
        guard let promocode = store.state.reducer.selectedPromocode else { return .init(promocode: "") }
        return .init(promocode: promocode.value)
    }
    
    func onContainerDidLoad(store: EnvironmentStore<AppState>) {
        store.dispatch(Actions.LoadPromocodes())
    }
}
