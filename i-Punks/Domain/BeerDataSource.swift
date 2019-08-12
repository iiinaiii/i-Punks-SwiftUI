
import Foundation
import Combine
import RxSwift

protocol BeerDataSource {
    func searchBeerList(page: Int) -> Future<Array<Beer>, Error>
}
