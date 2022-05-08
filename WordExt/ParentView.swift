//
//  ParentView.swift
//  WordExt
//
//  Created by Kego on 29/04/22.
//

import SwiftUI

struct ParentView: View {
    
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        
        switch viewRouter.currentPage {
            case .page1:
                ExtractView(viewRouter: viewRouter)
            case .page2:
                FlashcardsView(viewRouter: viewRouter)
            case .page3:
                WordsView(viewRouter: viewRouter)
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView(viewRouter: ViewRouter())
    }
}
