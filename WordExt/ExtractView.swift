//
//  ContentView.swift
//  WordExt
//
//  Created by Kego on 28/04/22.
//

import SwiftUI

struct ExtractView: View {
    
    @StateObject var viewRouter: ViewRouter
    @State private var wordCounter: String = "0 word"
    @State var text: String = ""
    @State var isChecked: Bool = false
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (alignment: .center) {

                    ZStack {
                        Rectangle()
                            .fill(.black)
                            .frame(width: 0.92 * screenWidth, height: 0.71 * screenHeight)
                            .cornerRadius(5)
                        
                        TextView(text: $text)
                            .frame(width: 0.86 * screenWidth, height: 0.69 * screenHeight)
                            .foregroundColor(.black)
                            .onTapGesture {
                                  self.endTextEditing()
                            }
                    }
                    
                    Button(action: {
                        removePunctuationAndDuplicates()
                        viewRouter.learningWords = viewRouter.wordsFound
                        viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                        viewRouter.currentPage = .page2
                    }) {
                        Text("Extract")
                        .font(.body)
                        .fontWeight(.bold)
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .frame(width: 0.92 * screenWidth)
                    .background(.black)
                    .cornerRadius(5)
                    .disabled(!isChecked)
                }
                .navigationTitle("WordExt")
                .navigationBarItems(trailing:
                                        HStack(spacing: 1) {
                                            Text("\(wordCounter)")
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                
                                            Button(action: {
                                                self.viewRouter.wordsFound = text.components(separatedBy: " ")
                                                if viewRouter.wordsFound.count == 1 && viewRouter.wordsFound[0] == "" {
                                                    wordCounter = "0 word"
                                                } else {
                                                    wordCounter = "\(viewRouter.wordsFound.count) word(s)"
                                                    isChecked = true
                                                }
                                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                                            }) {
                                                Image(systemName: "magnifyingglass.circle.fill")
                                                    .foregroundColor(.black)
                                                    .font(.title)
                                            }
                                        }
                                        
                                    )
            }
        }
    }
    
    func removePunctuationAndDuplicates() {
        for i in 0...(viewRouter.wordsFound.count - 1) {
            viewRouter.wordsFound[i] = viewRouter.wordsFound[i].components(separatedBy: CharacterSet.punctuationCharacters).joined().capitalized
        }
        
        viewRouter.wordsFound.uniqueInPlace(for: \.self)
    }
}

struct ExtractView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractView(viewRouter: ViewRouter())
    }
}

extension RangeReplaceableCollection {
    mutating func uniqueInPlace<T: Hashable>(for keyPath: KeyPath<Element, T>) {
        var unique = Set<T>()
        removeAll { !unique.insert($0[keyPath: keyPath]).inserted }
    }
}

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
