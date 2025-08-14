import UIKit
import Combine
import Foundation


let timerPublisher =  Timer.publish(every: 1, on: .main, in: .common)
let cancellable = timerPublisher.autoconnect().sink { timestamp in
    print("Timestamp: \(timestamp)")
}
