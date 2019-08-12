
import Foundation
import Combine

final class BeerDetailViewModel: ObservableObject {
    let useCase: BeerUseCase

    private var canceller: Cancellable? = nil

    @Published var loadState: LoadState = LoadState.preload
    @Published var beerImageUrl: String? = nil
    @Published var beerName: String? = nil
    @Published var tagline: String? = nil
    @Published var abv: String? = nil
    @Published var ibu: String? = nil
    @Published var og: String? = nil
    @Published var description: String? = nil
    @Published var foodPairings: String? = nil
    @Published var brewersTips: String? = nil

    init(useCase: BeerUseCase) {
        self.useCase = useCase
        canceller = self.useCase.observeBeerDetail()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                self.loadState = LoadState.error
            }, receiveValue: { beer in
                    self.loadState = LoadState.complete
                    self.beerImageUrl = beer.imageUrl
                    self.beerName = beer.name
                    self.tagline = beer.tagline
                    self.abv = beer.abv
                    self.ibu = beer.ibu
                    self.og = beer.targetOg
                    self.description = beer.description
                    self.foodPairings = beer.foodPairing
                        .joined(separator: "\n")
                    self.brewersTips = beer.brewersTips
                })
    }

    func fetchBeerDetail(beerId: Int) {
        useCase.fetchBeerDetail(beerId: beerId)
    }

    func dispose() {
        canceller?.cancel()
        canceller = nil
    }
}
