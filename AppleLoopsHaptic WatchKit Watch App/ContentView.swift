//
//  ContentView.swift
//  AppleLoopsHaptic WatchKit Watch App
//
//  Created by admin40 on 21/04/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sessionManager = WatchSessionManager()

    var body: some View {
        VStack {
            Text("⌚️ Apple Loops")
                .font(.headline)
            Text("Waiting for haptics from iPhone...")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    @ObservedObject var sessionManager = WatchSessionManager()
//    
//    var body: some View {
//        Text("Apple Loops Watch")
//            .padding()
//    }
//}
