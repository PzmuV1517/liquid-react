import Foundation
import React

@objc(LiquidReact)
class LiquidReact: NSObject {
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return false
  }
}
