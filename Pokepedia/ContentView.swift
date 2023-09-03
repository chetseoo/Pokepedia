import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.pokKorNameArray, id: \.self) { name in
                    TypeStringStyle(type: name)
                }
                
            }
        }
        .onAppear {
            viewModel.crawling()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
