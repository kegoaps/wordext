//
//  WordExtApp.swift
//  WordExt
//
//  Created by Kego on 28/04/22.
//

import SwiftUI

@main
struct WordExtApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ParentView(viewRouter: viewRouter)
        }
    }
}
