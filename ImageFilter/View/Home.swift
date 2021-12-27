//
//  Home.swift
//  ImageFilter
//
//  Created by macbook on 22/12/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack{
            
            if !homeData.allImages.isEmpty && homeData.mainView != nil{
                
                Image(uiImage: homeData.mainView.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(maxHeight: .infinity)
                    
                
                
                
                                   
                           }
                       }
                .frame(maxWidth: .infinity , maxHeight: 45)
                .background(Color.black)

                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing : 20){
                        ForEach(homeData.allImages){filtered in
                            Image(uiImage: filtered.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                            
                            // updating main view whenEver Button Tapped
                                .onTapGesture {
                                    homeData.mainView = filtered
                                }
                            
                        }
                    }
                    .padding()
                }
            }
            
           else if homeData.imageData.count == 0 {
                Text("Pick An Image")
            }
            else{
                // loading view
                ProgressView()
            }
        }
        .onChange(of: homeData.imageData, perform: { (_) in
            
            
            // clearing existing data..
            homeData.allImages.removeAll()
            homeData.mainView = nil
            homeData.loadFilter()
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {homeData.imagePicker.toggle()}) {
                    Text("add")
                        .font(.title2)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Button(action: {
                    UIImageWriteToSavedPhotosAlbum(homeData.mainView.image, nil, nil, nil)
                
                }) {
                    Text("Save")
                        .font(.title2)
                }
                //when no image disable it
                .disabled(homeData.mainView == nil ? true : false)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button(action: {
                    homeData.imageData.count = 0
                }) {
                    Text("cancel")
                        .font(.title2)
                }
                //when no image disable it
                .disabled(homeData.mainView == nil ? true : false)}

            
        })
        .sheet(isPresented: $homeData.imagePicker) {
            ImagePicker(picker: $homeData.imagePicker, imageData: $homeData.imageData)
        }
     
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
