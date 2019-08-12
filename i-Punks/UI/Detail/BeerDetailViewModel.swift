
import Foundation
import RxSwift
import RxCocoa

final class BeerDetailViewModel {
    let useCase: BeerUseCase

    @Published var loadState: LoadState = LoadState.preload
    @Published var beerImageUrl: String? = nil
    @Published var beerName: String? = nil
    @Published var tagline: String? = nil
    @Published var abv: String? = nil
    @Published var ibu: String? = nil
    @Published var og: String? = nil
    @Published var description: String? = nil
    @Published var foodPairing: [String] = []
    @Published var brewersTips: String? = nil

    private lazy var _beerDetail = self.useCase.observeBeerDetail().handleEvents(
        receiveOutput: { beer in
            self.loadState = LoadState.complete
            self.beerImageUrl = beer.imageUrl
            self.beerName = beer.name
            self.tagline = beer.tagline
            self.abv = beer.abv
            self.ibu = beer.ibu
            self.og = beer.targetOg
            self.description = beer.description
            self.foodPairing = beer.foodPairing
            self.brewersTips = beer.brewersTips
        },
        receiveCompletion: { _ in self.loadState = LoadState.error }
    )

    init(useCase: BeerUseCase) {
        self.useCase = useCase
    }

    func fetchBeerDetail(beerId: Int) {
        useCase.fetchBeerDetail(beerId: beerId)
    }
}
