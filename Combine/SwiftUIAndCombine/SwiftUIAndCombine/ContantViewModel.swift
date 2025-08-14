//
//  ContantViewModel.swift
//  SwiftUIAndCombine
//
//  Created by 양원식 on 8/14/25.
//
import Combine
import Foundation

class ContantViewModel: ObservableObject {
    @Published var value: Int = 0
    private var cancellable: AnyCancellable?
    
    init() {
        let publisher = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map {
                _ in self.value + 1
            }
        cancellable = publisher.assign(to: \.value, on: self)
    }
}
