import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        PromocodeContainer()
            .background(.white, ignoresSafeAreaEdges: .all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
