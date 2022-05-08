//
//  TextView.swift
//  WordExt
//
//  Created by Kego on 28/04/22.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    var placeholderText: String = "Start by pasting articles or texts here.\n\nOf course you can also type them if you have more time :p\n\nClick the button above first to know the total words of the texts, then click 'Extract' to get all the unique words."
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.text = placeholderText
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.textColor = UIColor.white
        textView.font = UIFont.italicSystemFont(ofSize: 14)
        textView.backgroundColor = UIColor.black
        
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<TextView>) {
        if text != "" || uiView.font != UIFont.italicSystemFont(ofSize: 14) {
                    uiView.text = text
                    uiView.font = UIFont.systemFont(ofSize: 14)
                }
                
        uiView.delegate = context.coordinator
    }

    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(self)
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init (_ parent: TextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.font == UIFont.italicSystemFont(ofSize: 14) {
                textView.text = ""
                textView.textColor = UIColor.white
                textView.font = UIFont.systemFont(ofSize: 14)
                
            }
        }
                
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholderText
                textView.font = UIFont.italicSystemFont(ofSize: 14)
                textView.textColor = UIColor.white
            }
        }
    }
}
