//
//  TabbarView.swift
//  honwoyomu
//
//  Created by gaoge on 2023/1/30.
//

import SwiftUI
import Combine

struct TabbarView: View {
    @State var selected = Tab.bookshelf

    enum Tab {
        case bookshelf, profile
    }

    var body: some View {
        TabView(selection: $selected) {
            Bookshelf()
                .tabItem {
                    Label("Bookshelf", systemImage: "books.vertical")
                }.tag(Tab.bookshelf)
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
#endif
