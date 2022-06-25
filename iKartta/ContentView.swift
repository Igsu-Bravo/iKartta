//
//  ContentView.swift
//  iKartta
//
//  Created by Juan Bravo on 21.6.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(1..<6) { index in
          Text("Item \(index)")
        }.splashView {
          ZStack {
              Color.indigo
            Text("iKartta")
              .fontWeight(.bold)
              .font(.system(size: 24))
              .foregroundColor(.white)
          }
        }
        // This is shown from the start as of now, might want to hide it later on
        SeguesView()
      }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
