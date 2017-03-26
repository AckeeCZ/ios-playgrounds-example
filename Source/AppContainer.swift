//
//  AppContainer.swift
//  Unicorn
//
//  Created by Tomas Kohout on 25/03/2017.
//  Copyright © 2017 Ackee s.r.o. All rights reserved.
//

import Foundation
import Swinject
import CoreLocation

import enum Result.NoError
public typealias NoError = Result.NoError

public typealias LanguageDetailModelingFactory = (_ language: Language) -> LanguageDetailViewModeling
public typealias LanguageDetailTableViewControllerFactory = (_ viewModel: LanguageDetailViewModeling) -> LanguageDetailViewController


public var AppContainer: Container = {
    let container = Container()
    
    //API
    container.register(LanguagesAPIServicing.self){ _ in LanguagesAPIService() }.inObjectScope(.container)
    
    //Managers
    container.register(Geocoding.self) { _ in Geocoder() }.inObjectScope(.container)
    
    container.register(LocationManager.self, factory: { _ in
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return manager
    }).inObjectScope(.container)
    
    container.register(SpeechSynthetizing.self){ _ in SpeechSynthetizer() }.inObjectScope(.container)
    
    
    //View models
    
    container.register(LanguagesTableViewModeling.self){ r in
        LanguagesTableViewModel(
            api: r.resolve(LanguagesAPIServicing.self)!,
            geocoder: r.resolve(Geocoding.self)!,
            locationManager: r.resolve(LocationManager.self)!,
            detailModelFactory: r.resolve(LanguageDetailModelingFactory.self)!
        )
    }
    
    container.register(LanguageDetailViewModeling.self){ r, language in
        LanguageDetailViewModel(language: language, synthetizer: r.resolve(SpeechSynthetizing.self)!)
    }
    
    //View model factories
    
    container.register(LanguageDetailModelingFactory.self) { r in
        { language in
            r.resolve(LanguageDetailViewModeling.self, argument: language)!
        }
    }
    
    //View controllers
    container.register(LanguagesTableViewController.self) { r in
        let detailFactory = r.resolve(LanguageDetailTableViewControllerFactory.self)!
        return LanguagesTableViewController(viewModel: r.resolve(LanguagesTableViewModeling.self)!, detailControllerFactory: detailFactory)
    }
    
    container.register(LanguageDetailViewController.self){ _, vm in
        LanguageDetailViewController(viewModel: vm)
    }
    
    //View controller factories
    container.register(LanguageDetailTableViewControllerFactory.self){ _ in
        { vm in
            LanguageDetailViewController(viewModel: vm)
        }
    }
    
    return container
}()
