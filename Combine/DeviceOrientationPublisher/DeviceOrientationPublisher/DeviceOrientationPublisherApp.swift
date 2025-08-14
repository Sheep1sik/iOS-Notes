//
//  DeviceOrientationPublisherApp.swift
//  DeviceOrientationPublisher
//
//  Created by 양원식 on 8/14/25.
//

import SwiftUI
import Combine

@main
struct DeviceOrientationPublisherApp: App {
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
            .sink { _ in
                let currentOrientation = UIDevice.current.orientation
                print(currentOrientation)
            }
            .store(in: &cancellables)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
