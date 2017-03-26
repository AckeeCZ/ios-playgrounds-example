//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

@testable import UnicornFramework



let parent = PlaygroundController(device: .phone4inch, orientation: .portrait){
    
    let language = Language(abbr: "de", name: "German", sentence: "Rechtsschutzversicherungsgesellschaften kaftfahrzeug-Haftpflichtversicherung donaudampfschiffahrtsgesellschaftskapitän", flag: "https://whostolemyunicorn.com/img/flags/48/de.png", not_right: false, language_code: "de-DE")
    
    let vm = AppContainer.resolve(LanguageDetailViewModeling.self, argument: language)!
    return AppContainer.resolve(LanguageDetailViewController.self, argument: vm)!
}

PlaygroundPage.current.liveView = parent
