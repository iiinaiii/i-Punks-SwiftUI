
import Foundation
import Combine

protocol BeerDataSource {
    func searchBeerList(page: Int) -> Future<Array<Beer>, Error>
}
