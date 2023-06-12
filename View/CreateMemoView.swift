//
//  CreateMemoView.swift
//  DBInstall
//
//  Created by 채영민 on 2023/06/11.
//

import SwiftUI

struct CreateMemoView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var memoVM: MemoViewModel
    @State var placeholderText: String = "클릭해서 메모를 입력"
    
    @State private var text: String = ""
    @State private var title: String = ""
    
    var proData: Memo
    init(_ proData: Memo) {
        self.proData = proData
        self.memoVM = MemoViewModel()
    }
    
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case text
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("제목")
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size:20)) + Text("*")
                    .foregroundColor(.red)
                    .font(.system(size:20))
                ){
                    TextField("클릭해서 제목을 입력", text: $title)
                        .submitLabel(.done)
                        .disableAutocorrection(true)
                        .onAppear {
                            title = proData.title
                        }
                }
                Section(header: Text("내용")
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size:20)) + Text("*")
                    .foregroundColor(.red)
                    .font(.system(size:20))
                ){
                    ZStack {
                        if self.text.isEmpty {
                            TextEditor(text: $placeholderText)
                                .font(.body)
                                .foregroundColor(.gray)
                                .opacity(0.5)
                                .disabled(true)
                        }
                        TextEditor(text: $text)
                            .font(.body)
                            .opacity(self.text.isEmpty ? 0.25 : 1)
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .text)
                            .submitLabel(.done)
                            .frame(width: .infinity, height: 500)
                            .onAppear {
                                title = proData.title
                            }
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        focusedField = nil
                                    }
                                }
                            }
                    }
                }
            }
            .frame(width: .infinity)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if proData.title == "" {
                        Button {
                            memoVM.add(text: text, title: title)
                            self.presentationMode.wrappedValue.dismiss()
                        } label : {
                            Text("저장하기")
                        }
                    } else {
                        Button {
                            memoVM.editMemo(old: proData, title: text, text: title)
                            self.presentationMode.wrappedValue.dismiss()
                        } label : {
                            Text("편집완료")
                        }
                    }
                }
            }
            .background(Color.white)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.clear
                UITableViewCell.appearance().backgroundColor = UIColor.clear
            })
        }
    }
}

struct CreateMemoView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMemoView(Memo())
    }
}
