//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

@testable import UnicornFramework



let parent = PlaygroundController(device: .phone4inch, orientation: .portrait){
    
    let language = Language(abbr: "fi", name: "Finnish", sentence: "Kuka varasti yksisarvisenni?", flag: "https://whostolemyunicorn.com/img/flags/48/fi.png", not_right: false, language_code: "fi-FI")
    
    let vm = AppContainer.resolve(LanguageDetailViewModeling.self, argument: language)!
    return AppContainer.resolve(LanguageDetailViewController.self, argument: vm)!
}

PlaygroundPage.current.liveView = parent
