import SwiftUI

struct PokemonListView: View {
    @State var searchingText: String = ""
    @StateObject var viewModel = testViewModel()

    var body: some View {
        VStack {
            TextField("포켓몬 이름을 입력하세요.", text: $searchingText)
                .padding()

            Divider()

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<viewModel.pokemons.count / 2, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0..<2, id: \.self) { columnIndex in
                                let index = rowIndex * 2 + columnIndex
                                if index < viewModel.pokemons.count {
                                    ThumnailView(pokemon: viewModel.pokemons[index])
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.test()
                }
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
