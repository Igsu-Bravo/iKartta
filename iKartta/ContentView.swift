//
//  ContentView.swift
//  iKartta
//
//  Created by Juan Bravo on 21.6.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(Bundle.main.executableURL!.lastPathComponent)  
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
