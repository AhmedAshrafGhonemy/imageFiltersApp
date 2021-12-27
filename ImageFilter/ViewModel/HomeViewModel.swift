//
//  HomeViewModel.swift
//  ImageFilter
//
//  Created by macbook on 22/12/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel : ObservableObject{
    
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)
    
    @Published var allImages : [FilteredImage] = []
    
    // Main Editing Image
    @Published var mainView : FilteredImage!
    
    
    // Loading FilterOption WhenEver Image Selected
    var filters : [CIFilter] = [
        CIFilter.colorInvert(),CIFilter.gaussianBlur(),CIFilter.photoEffectChrome(),
        CIFilter.affineClamp(),CIFilter.photoEffectFade()
    ]
    
    func loadFilter(){
        
        let context = CIContext()
        
        filters.forEach { (filter) in
            
            // to avoid lag
            
            DispatchQueue.global(qos: .userInteractive).async {
                
                //loading image into filter
                
                let CiImage = CIImage(data: self.imageData)
                
                filter.setValue(CiImage, forKey: kCIInputImageKey)
                
                // retreving Image
                guard let newImage = filter.outputImage else{return}
                
                // creating UIImage
                
                let cgimage = context.createCGImage(newImage, from: newImage.extent)
                let filteredData = FilteredImage(image: UIImage(cgImage: cgimage!), filter: filter)
                
                DispatchQueue.main.async {
                    self.allImages.append(filteredData)
                    
                    // default is the first filter
                    
                    if self.mainView == nil {
                        self.mainView = self.allImages.first
                    }
                }
            }
            
           
        }
    }
    
}
