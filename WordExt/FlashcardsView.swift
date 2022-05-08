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
    @State private var showingInstruction = false
    @State private var showingEdit = false
    @State private var showingAlertRemove = false
    @State private var showingAlertMaster = false
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        NavigationView {
            ScrollView {
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
                    .padding(.top, 20)
                    
                    
                    HStack(spacing: 10) {
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
                        .frame(width: 0.45 * screenWidth, height: 0.18 * screenHeight)
                        
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
                        .frame(width: 0.45 * screenWidth, height: 0.18 * screenHeight)
                        
                    }
                    .padding(.bottom, 1)
                    
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
                        .padding(.bottom, 1)
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            self.showingAlertMaster = true
                        }) {
                            Image(systemName: "crown.fill")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .padding(10)
                        .frame(width: 0.21 * screenWidth, height: 0.08 * screenHeight)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                        .disabled(viewRouter.isCompleted)
                        .alert(isPresented: $showingAlertMaster) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("You are about to mark this word as mastered, and this means you cannot move it back (re-learn). Please make sure you have understand this word as well as the context of where it can be used before proceeding."),
                                primaryButton: .default(Text("Mastered"), action: {
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
                                }),
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                        
                        Button(action: {
                            self.showingEdit = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                        }
                        .padding(10)
                        .frame(width: 0.21 * screenWidth, height: 0.08 * screenHeight)
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
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                        }
                        .padding(10)
                        .frame(width: 0.21 * screenWidth, height: 0.08 * screenHeight)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                        .disabled(viewRouter.isCompleted)
                        
                        Button(action: {
                            self.showingAlertRemove = true
                        }) {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        .padding(10)
                        .frame(width: 0.21 * screenWidth, height: 0.08 * screenHeight)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                        .disabled(viewRouter.isCompleted)
                        .alert(isPresented: $showingAlertRemove) {
                            Alert(
                                title: Text("Are you sure?"),
                                message: Text("You are about to remove a unique word. Please make sure this word is really irrelevant for your learning before proceeding."),
                                primaryButton: .destructive(Text("Remove"), action: {
                                    viewRouter.learningWords.remove(at: viewRouter.currLearningWord)
                                    
                                    if viewRouter.currLearningWord > viewRouter.learningWords.count - 1 {
                                        viewRouter.currLearningWord = 0
                                    }
                                    
                                    if viewRouter.learningWords.count == 0 {
                                        viewRouter.cardText = "Completed!"
                                        viewRouter.isCompleted = true
                                    } else {
                                        viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                                    }
                                }),
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                    }
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
                                        },
                                trailing:
                                    Button(action: {
                                        self.showingInstruction = true
                
                                        }) {
                                            Image(systemName: "questionmark.circle.fill")
                                                .foregroundColor(.black)
                                                .font(.title3)
                                        }
                                        .alert(isPresented: $showingInstruction) {
                                            Alert(title: Text("Instruction"), message: Text("Here you can see the extracted unique words displayed as cards. Organize the words into the Mastered or Learning lists by using the 4 buttons at the bottom, which in order are 'Mastered or known already', 'Edit word', 'Skip word', and 'Remove from Learning list'. You can check the list of Mastered or Learning Words by clicking on each of their right arrow button respectively. Also, you can export each list into .txt file   . Happy learning!"), dismissButton: .default(Text("Got it!")))
                                        }
                                )
        }
        .alert(isPresented: $showingEdit, TextAlert(
                title: "Want to edit the word?",
                message: "Here is the word,\nplease edit accordingly.",
                placeholder: "\(viewRouter.cardText)",
                accept: "Edit",
                cancel: "Cancel",
                action: {result in
                    if let word = result {
                        
                        if word != "" {
                            viewRouter.learningWords[viewRouter.currLearningWord] = word.components(separatedBy: CharacterSet.punctuationCharacters).joined().capitalized
                            
                            viewRouter.cardText = viewRouter.learningWords[viewRouter.currLearningWord]
                        } else {
                            // If nil, do nothing, the word won't be edited
                        }
                    }
                }
            )
        )
    }
}

struct FlashcardsView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardsView(viewRouter: ViewRouter())
    }
}

public struct TextAlert {
  public var title: String
  public var message: String
  public var placeholder: String = ""
  public var accept: String
  public var cancel: String?
  public var keyboardType: UIKeyboardType = .default
  public var action: (String?) -> Void
  
}

extension UIAlertController {
  convenience init(alert: TextAlert) {
    self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
    addTextField {
       $0.placeholder = alert.placeholder
       $0.keyboardType = alert.keyboardType
    }
    if let cancel = alert.cancel {
      addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
        alert.action(nil)
      })
    }
    let textField = self.textFields?.first
    addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
      alert.action(textField?.text)
    })
  }
}

extension View {
  public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
    AlertWrapper(isPresented: isPresented, alert: alert, content: self)
  }
}
