//
//  AsTextEditorStyle.swift
//  PetTeddy
//
//  Created by 김유림 on 2/18/25.
//

import SwiftUI

struct AsTextEditorStyle: ViewModifier {
    @Binding var text: String
    @FocusState<Bool>.Binding var isFocused: Bool

    let placeholder: String
    let maximumTextLength: Int
    
    init (
        placeholder: String = "",
        text: Binding<String>,
        maximumTextLength: Int,
        isFocused: FocusState<Bool>.Binding
    ) {
        self.placeholder = placeholder
        self._text = text
        self.maximumTextLength = maximumTextLength
        self._isFocused = isFocused
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(.black)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .frame(height: 80)
            .scrollContentBackground(.hidden)
            .background(
                RoundedRectangle(cornerRadius: 23)
                    .foregroundStyle(Color.yrGrayLight)
            )
            .autocorrectionDisabled()
            .overlay(alignment: .topLeading) {
                if !isFocused && text.isEmpty {
                    Text(placeholder)
                        .padding(12)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.yrGray)
                }
            }
    }
}

extension TextEditor {
    @MainActor
    func asTextEditorStyle(
        placeholder: String,
        text: Binding<String>,
        maximumTextLength: Int,
        isFocused: FocusState<Bool>.Binding
    ) -> some View {
        self.modifier(
            AsTextEditorStyle(
                placeholder: placeholder,
                text: text,
                maximumTextLength: maximumTextLength,
                isFocused: isFocused
            )
        )
    }
}
