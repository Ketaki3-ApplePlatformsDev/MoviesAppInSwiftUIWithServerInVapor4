//
//  View+Extensions.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 24/10/20.
//

import Foundation
import SwiftUI

enum DisplayMode {
    case fullscreen
}

extension View {
    
    var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    func fullscreen() -> some View {
        return self.frame(width: screenSize.width, height: screenSize.height)
    }
    
}
