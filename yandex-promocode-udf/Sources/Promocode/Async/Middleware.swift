//
//  Middleware.swift
//  yandex-promocode-udf
//
//  Created by Артём Зайцев on 05.03.2025.
//

import UDF

struct Promocode: Equatable {
    let value: String
}

final class PromocodeMiddleware: BaseObservableMiddleware<AppState> {
    enum Cancellation: Hashable {
        case loadPromocodes
    }
    
    enum Flow: Hashable {
        case flowID
    }

    struct Environment {
        var loadPromocodes: () async throws -> [Promocode]
    }

    var environment: Environment!

    func scope(for state: AppState) -> Scope {
        state.reducer
    }

    func observe(state: AppState) {
        switch state.reducer.state {
        case .loading:
            execute(flowId: PromocodeMiddleware.Flow.flowID, cancellation: PromocodeMiddleware.Cancellation.loadPromocodes) { [weak self] flowID in
                guard let promocodes = try await self?.environment.loadPromocodes() else { return Actions.Error(id: "", meta: [:]) }
                
                return Actions.DidLoadItems(items: promocodes, id: flowID)
            }
        case .none:
            break
        }
    }
}

// MARK: - Environment build methods
extension PromocodeMiddleware {
    static func buildLiveEnvironment(for store: some Store<AppState>) -> Environment {
        Environment(
            loadPromocodes: {
                print("buildLiveEnvironment")
                return [.init(value: "LIVE1"), .init(value: "LIVE2"), .init(value: "LIVE3")]
            }
        )
    }

    static func buildTestEnvironment(for store: some Store<AppState>) -> Environment {
        Environment(
            loadPromocodes: {
                print("buildTestEnvironment")
                return [.init(value: "TEST1"), .init(value: "TEST2"), .init(value: "TEST3")]
            }
        )
    }
}
