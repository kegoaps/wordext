//
//  WordsView.swift
//  WordExt
//
//  Created by Kego on 29/04/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct WordsView: View {
    
    @StateObject var viewRouter: ViewRouter
    @State private var showingExporter: Bool = false
    @State private var words: String = ""
    @State private var showingAlert = false
    @State private var document: MessageDocument = MessageDocument(message: "")
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    if viewRouter.typeWords == "Mastered" {
                        ForEach(viewRouter.masteredWords, id: \.self) { word in
                            HStack {
                                Text(word)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                .padding(.trailing, 10)
                            }
                        }
                    } else {
                        ForEach(viewRouter.learningWords, id: \.self) { word in
                            HStack {
                                Text(word)
                                    .padding(.leading, 20)
                                
                                Spacer()
                                .padding(.trailing, 10)
                            }
                        }
                    }
                }
                .padding(.top, 10)
            }
            .navigationTitle(Text("\(viewRouter.typeWords)"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading:
                                    Button(action: {
                                        
                                            if viewRouter.learningWords.count == 0 {
                                                viewRouter.isCompleted = true
                                            }
                
                                            viewRouter.currentPage = .page2
                
                                    }) {
                                        HStack {
                                            Image(systemName: "chevron.left")
                                                .foregroundColor(.black)
                                            
                                            Text("Back")
                                                .foregroundColor(.black)
                                        }
                                    },
                                trailing:
                                    Button(action: {
                                        
                                        self.showingExporter = true
                                        
                                        if viewRouter.typeWords == "Mastered" {
                                            for i in 0...viewRouter.masteredWords.count - 1 {
                                                words += "\(viewRouter.masteredWords[i])\n"
                                            }
                                        } else {
                                            for i in 0...viewRouter.learningWords.count - 1 {
                                                words += "\(viewRouter.learningWords[i])\n"
                                            }
                                        }
                
                                        document = MessageDocument(message: "\(words)")
                                        
                                            }) {
                                                Text("Save")
                                                    .foregroundColor(.black)
                                            } .disabled(!viewRouter.isExportable)
                                )
        }
        .alert("The \(viewRouter.typeWords) Words file has been successfully exported", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
        
        .fileExporter(
              isPresented: $showingExporter,
              document: document,
              contentType: .plainText,
              defaultFilename: "\(viewRouter.typeWords)_Words"
          ) { result in
              if case .success = result {
                  self.showingAlert = true
              }
          }
    }
}

struct WordsView_Previews: PreviewProvider {
    static var previews: some View {
        WordsView(viewRouter: ViewRouter())
    }
}

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
}
