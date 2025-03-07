import SwiftUI
import UDF

@main
struct YandexPromocodeUdfApp: App {
    var store: EnvironmentStore<AppState>
    
    init () {
        let initialState = AppState(reducer: .init(selectedPromocode: .init(value: "123QWE")))
        store = EnvironmentStore(initial: initialState, logger: .consoleDebug)
        store.subscribe(PromocodeMiddleware.self)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
