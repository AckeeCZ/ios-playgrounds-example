//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport
import UIKit

let button = UIButton(frame: CGRect(x:0, y:0, width: 100, height: 20))
button.setTitle("Test", for: .normal)
button.setTitleColor(.red, for: .normal)
button.setTitleColor(.green, for: .highlighted)

PlaygroundPage.current.liveView = button