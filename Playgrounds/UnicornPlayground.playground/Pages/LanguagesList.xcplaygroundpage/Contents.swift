//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
@testable import UnicornFramework


let parent = PlaygroundController(device: Device.phone4inch, orientation: Orientation.portrait, scale: 1) {
    AppContainer.resolve(LanguagesTableViewController.self)!
}

PlaygroundPage.current.liveView = UINavigationController(rootViewController: parent)

