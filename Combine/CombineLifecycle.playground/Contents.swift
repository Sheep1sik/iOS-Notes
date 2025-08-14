import UIKit
import Combine

let numberPublisher = (1...10).publisher

let cancellable = numberPublisher.sink { value in
    print(value)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    cancellable.cancel()
}
