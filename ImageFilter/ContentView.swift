//
//  ContentView.swift
//  ImageFilter
//
//  Created by macbook on 22/12/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
     
        NavigationView{
            
            Home()
            
            //darkMode
                .navigationBarTitle("Filters")
                .preferredColorScheme(.light)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
