//
//  FlashcardsView.swift
//  WordExt
//
//  Created by Kego on 28/04/22.
//

import SwiftUI

struct FlashcardsView: View {
    
    @StateObject var viewRouter: ViewRouter
    @State private var showingAlert = false
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.black)
                        .cornerRadius(5)
                    
                    VStack {
                        Text("Unique words extracted")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                            .padding(.bottom, 5)
                        
                        Text("\(viewRouter.wordsFound.count)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    
                }
                .frame(width: 0.92 * screenWidth, height: 0.12 * screenHeight)
                .padding(.bottom, 1)
                
                
                HStack(spacing: 16) {
                    ZStack {
                        Rectangle()
                            .fill(.black)
                            .cornerRadius(5)
                        
                        VStack {
                            HStack {
                                Image(systemName: "crown.fill")
                                    .foregroundColor(.white)
                                
                                Text("Mastered")
                                    .font(.body)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    
                                    viewRouter.currentPage = .page3
                                    viewRouter.typeWords = "Mastered"
                                    
                                    if viewRouter.masteredWords.count == 0 {
                                        viewRouter.isExportable = false
                                    } else {
                                        viewRouter.isExportable = true
                                    }
                                        
                                }) {
                                    Image(systemName: "arrow.right.circle")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                            
                            Text("\(viewRouter.masteredWords.count)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .frame(width: 0.44 * screenWidth, height: 0.18 * screenHeight)
                    
                    ZStack {
                        Rectangle()
                            .fill(.black)
                            .cornerRadius(5)
                        
                        VStack {
                            HStack {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.white)
                                
                                Text("Learning")
                                    .font(.body)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    
                                    viewRouter.currentPage = .page3
                                    viewRouter.typeWords = "Learning"
                                    
                                    if viewRouter.learningWords.count == 0 {
                                        viewRouter.isExportable = false
                                    } else {
                                        viewRouter.isExportable = true
                                    }
                                    
                                }) {
                                    Image(systemName: "arrow.right.circle")
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                            
                            Text("\(viewRouter.learningWords.count)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .frame(width: 0.44 * screenWidth, height: 0.18 * screenHeight)
                    
                }
                .padding(.bottom, 8)
                
                ZStack {

                    if viewRouter.cardText == "Completed!" {
                        ZStack {
                            Rectangle()
                                .fill(.black)
                                .cornerRadius(5)
                                
                            Rectangle()
                                .fill(.white)
                                .cornerRadius(5)
                                .frame(width: 0.88 * screenWidth, height: 0.37 * screenHeight)
                        }
                        
                        Text("\(viewRouter.cardText)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    } else {
                        Rectangle()
                            .fill(.black)
                            .cornerRadius(5)
                        
                        Text("\(viewRouter.cardText)")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                    }
                    
                }
                    .frame(width: 0.92 * screenWidth, height: 0.39 * screenHeight)
                    .padding(.bottom, 8)
                
                HStack(spacing: 16) {
                    Button(action: {
                        
                        viewRouter.masteredWords.insert(viewRouter.learningWords[viewRouter.currLearningWord], at: viewRouter.currMasteredWord)
                        
                        viewRouter.learningWords.remove(at: viewRouter.currLearningWord)
                        
                        viewRouter.currMasteredWord += 1
                        
                        if viewRouter.currLearningWord > viewRouter.learningWords.count - 1 {
                            viewRouter.currLearningWord = 0
                        }
                        
                        if viewRouter.learningWords.count == 0 {
                            viewRouter.cardText = "Completed!"
                            viewRouter.isCompleted = true
                        } else {
                            viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                        }
                        
                        
                    }) {
                        Text("I know!")
                        .font(.body)
                        .fontWeight(.bold)
                    }
                    .padding(10)
                    .frame(width: 0.44 * screenWidth)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(5)
                    .disabled(viewRouter.isCompleted)
                    
                    Button(action: {
                        if viewRouter.currLearningWord == viewRouter.learningWords.count - 1 {
                            viewRouter.currLearningWord = 0
                            viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                        } else {
                            
                            viewRouter.currLearningWord += 1
                            viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                        }
                    }) {
                        Text("Pass")
                        .font(.body)
                        .fontWeight(.bold)
                    }
                    .padding(10)
                    .frame(width: 0.44 * screenWidth)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(5)
                    .disabled(viewRouter.isCompleted)
                }
            }
            .navigationTitle(Text("Flashcards"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showingAlert = true
                
                                    }) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(.black)
                                            
                                            Text("Reset")
                                                .foregroundColor(.black)
                                        }
                                    })
        }
        
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("You are about to reset your progress and all the extracted unique words.\nMake sure you have completed mastering them before proceeding."),
                    primaryButton: .destructive(Text("Reset"), action: {
                        viewRouter.currentPage = .page1
                        viewRouter.wordsFound = []
                        viewRouter.currMasteredWord = 0
                        viewRouter.masteredWords = []
                        viewRouter.currLearningWord = 0
                        viewRouter.learningWords = []
                        viewRouter.cardText = ""
                        viewRouter.isCompleted = false
                    }),
                    secondaryButton: .cancel(Text("Cancel"))
                )
            }
            
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(viewRouter: ViewRouter())
    }
}
