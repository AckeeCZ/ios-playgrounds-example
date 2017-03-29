

import UIKit
import PlaygroundSupport
import ReactiveSwift
@testable import UnicornFramework

class EmptyLanguagesAPIService: LanguagesAPIServicing {
    func languages() -> SignalProducer<[Language], APIError> {
        return SignalProducer(value: [])
    }
}

let parent = PlaygroundController(device: Device.phone4inch, orientation: Orientation.portrait, scale: 1) {
    
    
    let vm = LanguagesTableViewModel(
        api: EmptyLanguagesAPIService(),
        geocoder: AppContainer.resolve(Geocoding.self)!,
        locationManager: AppContainer.resolve(LocationManager.self)!,
        detailModelFactory: AppContainer.resolve(LanguageDetailModelingFactory.self)!)
    
    return LanguagesTableViewController(
        viewModel: vm,
        detailControllerFactory: AppContainer.resolve(LanguageDetailTableViewControllerFactory.self)!
        )
}

PlaygroundPage.current.liveView = UINavigationController(rootViewController: parent)
