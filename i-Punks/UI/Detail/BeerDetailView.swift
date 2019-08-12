
import SwiftUI

struct BeerDetailView: View {
    var beerId: Int

    @ObservedObject(initialValue: createBeerDetailViewModel()) var viewModel: BeerDetailViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(uiImage: UIImage(url: viewModel.beerImageUrl ?? "https://images.punkapi.com/v2/keg.png"))
                            .resizable()
                            .scaledToFit()
                            .frame(width: CGFloat(200), height: CGFloat(320))
                    }
                    Text(viewModel.beerName ?? "Beer Name")
                        .font(.largeTitle)
                    Text(viewModel.tagline ?? "Tagline")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer(minLength: 16)
                    Text("THIS BEER IS")
                        .font(.headline)
                    Spacer(minLength: 8)
                    Text(viewModel.description ?? "Description")
                        .font(.body)
                    // Cause compile error when add more Text
//                    Spacer(minLength: 16)
//                    Text("FOOD PAIRING")
//                        .font(.headline)
//                    Spacer(minLength: 8)
//                    Text(viewModel.foodPairings ?? "FoodPairing")
//                        .font(.body)
//                    Spacer(minLength: 16)
//                    Text("BREWER'S TIPS")
//                    Spacer(minLength: 8)
//                    Text(viewModel.brewersTips ?? "Brewer's Tips")
                }.frame(alignment: .topLeading)
                    .padding(.all, 16)
            }.navigationBarTitle(Text(viewModel.beerName ?? "Beer Name"))
        }.onAppear(perform: fetch)
            .onDisappear(perform: dispose)
    }

    private func fetch() {
        viewModel.fetchBeerDetail(beerId: beerId)
    }

    private func dispose() {
        viewModel.dispose()
    }
}

private func createBeerDetailViewModel() -> BeerDetailViewModel {
    return BeerDetailViewModel(useCase: BeerUseCase(repository: BeerRepository.shared)
    )
}

#if DEBUG
    struct BeerDetailView_Previews: PreviewProvider {
        static var previews: some View {
            BeerDetailView(beerId: 1)
        }
    }
#endif
