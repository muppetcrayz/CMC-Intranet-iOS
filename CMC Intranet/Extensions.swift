//
//  Extensions.swift
//  kiosk
//
//  Created by Sage Conger on 4/25/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit
import SwiftMessages

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension MessageView {
        static func success(title: String, body: String) -> MessageView {
            with(MessageView.viewFromNib(layout: .cardView)) {
                    $0.configureTheme(.success)

                    $0.applyStyling()

                    $0.configureContent(title: "\(title) Successful", body: body, iconText: "✓")
        }
    }

    static func error(_ title: String, body: String) -> MessageView {
        with(MessageView.viewFromNib(layout: .cardView)) {
            $0.configureTheme(.error)

            $0.applyStyling()

            $0.configureContent(title: "\(title) Error", body: body, iconText: "!")
        }
    }

    final func applyStyling() {
        configureDropShadow()

        layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        button?.isHidden = true

        (backgroundView as? CornerRoundingView)?.cornerRadius = 10
    }
}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
}

infix operator ?=: AssignmentPrecedence

// "fill the nil" operator
func ?= <T>(lhs: inout T, rhs: T?) -> Void {
    guard let value = rhs else { return }
    lhs = value
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension UIView {
    var usesAutoLayout: Bool {
        get {
            return translatesAutoresizingMaskIntoConstraints
        }
        set {
            translatesAutoresizingMaskIntoConstraints = !newValue
        }
    }
    
}

@discardableResult
func with<T>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}

@objc final class ClosureSleeve: NSObject {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
        super.init()
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, action: @escaping () -> Void) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
