//
//  ContentView.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/12/21.
//

import SwiftUI
//import CoreData
import UserNotifications

struct ContentView: View {
    @State private var selection: Tab = .timer
    
    enum Tab {
        case timer
        case profile
    }

    var body: some View {
        TabView(selection: $selection) {
            StartView()
                .tabItem {
                    Label("Timer", systemImage: "alarm")
                }
                .tag(Tab.timer)
            ProfileView()
                .tabItem {
                    Label("Log", systemImage: "note.text")
                }
                .tag(Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
