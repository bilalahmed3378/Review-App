//
//  ContentView.swift
//  Review App
//
//  Created by Bilal Ahmed on 20/02/2023.
//

import SwiftUI

struct ContentView: View {
    @State var isUserLoggedIn : Bool = true
    var body: some View {
        NavigationView{
            MainTabContainer(isUserLoggedIn: self.$isUserLoggedIn )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let widthBlockSize = (UIScreen.main.bounds.size.width/100)
    static let screenHeight = UIScreen.main.bounds.size.height
    static let heightBlockSize = (UIScreen.main.bounds.size.height/100)
    static let screenSize = UIScreen.main.bounds.size
}


extension View {
    
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        // here is the call to the function that converts UIView to UIImage: `.asImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
    
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> Double {

        guard let data = self.pngData() else {
            return 100000000
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return size
    }
    
    var base64: String? {
        return "data:image/png;base64,\(self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "")"
    }
    
    var highestQualityJPEGNSData: Data { return self.jpegData(compressionQuality: 1.0)! }
    var highQualityJPEGNSData: Data    { return self.jpegData(compressionQuality: 0.75)!}
    var mediumQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.5)! }
    var lowQualityJPEGNSData: Data     { return self.jpegData(compressionQuality: 0.25)!}
    var lowestQualityJPEGNSData: Data  { return self.jpegData(compressionQuality: 0.0)! }
    
    
}


extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    func limit(limit : Int) -> String{
        if(count > limit){
            return String(prefix(limit))
        }
        return self
    }
    
    func filterNumbers() -> String{
        let filtered = filter { ".0123456789".contains($0) }
        return filtered
    }
    
    func filterNumbers(limit : Int) -> String{
        return self.filterNumbers().limit(limit: limit)
    }

}

extension Binding where Value == String {
    func maxLimit(_ limit : Int = 30) -> Self{
        if self.wrappedValue.count > limit {
            self.wrappedValue = String(self.wrappedValue.dropLast())
        }
        return self
    }
}


