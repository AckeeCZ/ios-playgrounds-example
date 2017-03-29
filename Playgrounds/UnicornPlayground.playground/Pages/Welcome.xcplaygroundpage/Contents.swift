//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import SnapKit
@testable import UnicornFramework

L10n.language = "de"

let parent = PlaygroundController(device: Device.phone5_5inch, scale: 0.75) {
    WelcomeViewController()
}

PlaygroundPage.current.liveView = parent

