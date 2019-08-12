
import SwiftUI

struct BeerListRow: View {
    var beer: Beer

    var body: some View {
        HStack(alignment: .center) {
            Image(uiImage: UIImage(url: beer.imageUrl ?? "https://images.punkapi.com/v2/keg.png"))
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
            VStack(alignment: .leading) {
                Text(beer.name)
                    .font(.title)
                HStack {
                    Text(beer.firstBrewed)
                    Text(beer.abv)
                }.font(.subheadline)
            }
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
    }
}

#if DEBUG
    struct BeerListRow_Previews: PreviewProvider {
        static var previews: some View {
            BeerListRow(beer: Beer(
                id: 5,
                name: "Avery Brown Dredge",
                tagline: "Bloggers' Imperial Pilsner.",
                firstBrewed: "APRIL 2008",
                description: "An Imperial Pilsner in collaboration with beer writers. Tradition. Homage. Revolution. We wanted to showcase the awesome backbone of the Czech brewing tradition, the noble Saaz hop, and also tip our hats to the modern beers that rock our world, and the people who make them.",
                imageUrl: "https://images.punkapi.com/v2/5.png",
                abv: "7.2%",
                ibu: "59",
                targetOg: "1069",
                targetFg: "1027",
                ebc: "10",
                srm: "5",
                volume: "4.4",
                boilVolume: "67",
                ph: "20L",
                attenuationLevel: "25L",
                foodPairing: [
                    "Vietnamese squid salad",
                    "Chargrilled corn on the cob with paprika butter",
                    "Strawberry and rhubarb pie"
                ],
                brewersTips: "Make sure you have a big enough yeast starter to ferment through the OG and lager successfully."
                ))
        }
    }
#endif
