//
//  ViewRouter.swift
//  WordExt
//
//  Created by Kego on 29/04/22.
//

import Foundation
import SwiftUI

enum Page {
    case page1
    case page2
    case page3
}

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .page1
    @Published var typeWords: String = ""
    @Published var wordsFound: [String] = []
    @Published var currMasteredWord: Int = 0
    @Published var masteredWords: [String] = []
    @Published var currLearningWord: Int = 0
    @Published var learningWords: [String] = []
    @Published var cardText: String = ""
    @Published var isCompleted: Bool = false
    @Published var isExportable: Bool = false
    
}
