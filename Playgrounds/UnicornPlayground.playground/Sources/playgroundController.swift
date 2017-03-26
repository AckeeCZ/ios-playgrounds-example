import UIKit
@testable import UnicornFramework
// swiftlint:disable function_body_length

public enum Device {
  case phone4inch
  case phone4_7inch
  case phone5_5inch
  case pad
}

public enum Orientation {
  case portrait
  case landscape
}

/**
 Creates a controller that represents a specific device, orientation with specific traits.

 - parameter device:           The device the controller should represent.
 - parameter orientation:      The orientation of the device.
 - parameter language:      The language of the device.
 - parameter child:            An optional controller to put inside the parent controller. If omitted
 a blank controller will be used.
 - parameter additionalTraits: An optional set of traits that will also be applied. Traits in this collection
 will trump any traits derived from the device/orientation comboe specified.

 - returns: Two controllers: a root controller that can be set to the playground's live view, and a content
 controller which should have UI elements added to it
 */

public class PlaygroundController: UIViewController {
    
    let device: Device
    let orientation: Orientation
    var language: String?
    let scaleFactor: CGFloat
    let additionalTraits: UITraitCollection
    let childFactory: () -> UIViewController
    
    public init(device: Device = .phone4_7inch,
         orientation: Orientation = .portrait,
         language: String? = nil,
         scale scaleFactor: CGFloat = 1.0,
         additionalTraits: UITraitCollection = .init(),
         childFactory: @escaping () -> UIViewController){
        self.device = device
        self.orientation = orientation
        self.language = language
        self.scaleFactor = scaleFactor
        self.additionalTraits = additionalTraits
        self.childFactory = childFactory
        
        super.init(nibName: nil, bundle: nil)
        
        setupChild()
    }
    
    func setupChild(){
        L10n.language = self.language
        let parent = self
        let child = childFactory()
        
        parent.addChildViewController(child)
        parent.view.addSubview(child.view)

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let traits: UITraitCollection
        switch (device, orientation) {
        case (.phone4inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 320, height: 575)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 575, height: 320)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 375, height: 667)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 667, height: 375)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 414, height: 736)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 736, height: 414)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.pad, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 768, height: 1024)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        case (.pad, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 1024, height: 768)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        }
        parent.view.frame = scale(rect: parent.view.frame, by: scaleFactor)
        child.view.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        parent.preferredContentSize = parent.view.frame.size
        child.view.frame = parent.view.frame
        
        let allTraits = UITraitCollection.init(traitsFrom: [traits, additionalTraits])
        parent.setOverrideTraitCollection(allTraits, forChildViewController: child)
    }
    
    func scale(rect: CGRect, by scale: CGFloat) -> CGRect {
        return CGRect(origin: rect.origin, size: CGSize(width: rect.size.width * scale, height: rect.size.height * scale))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
