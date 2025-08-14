//
//  ContentView.swift
//  SwiftUIAndCombine
//
//  Created by 양원식 on 8/14/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = ContantViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.value)")
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
