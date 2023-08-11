import SwiftUI

struct PokemonInfoView: View{
    @State var pokemon: Pokemon
    
    var body: some View{
        VStack{
            if let image = pokemon.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 250, height: 250)
            }
            
            Text(pokemon.id)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
            
            Text(pokemon.name)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
        .padding()
        .border(.black)
        
    }
}

struct PokemonInfoView_Previews: PreviewProvider{
    static var previews: some View{
        PokemonInfoView(pokemon: Pokemon(id: "No.0124", name: "루주라", appearance: "알로라의 모습"))
    }
}

