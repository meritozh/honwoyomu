//
//  Bookshelf.swift
//  honwoyomu
//
//  Created by gaoge on 2023/1/30.
//

import SwiftUI

struct Bookshelf: View {
    var body: some View {
        NavigationStack {
            List(0..<30) {
                Text("index \($0)")
            }
            .navigationTitle("My Bookshelf")
        }
    }
}

#if DEBUG
struct Bookshelf_Previews: PreviewProvider {
    static var previews: some View {
        Bookshelf()
    }
}
#endif
