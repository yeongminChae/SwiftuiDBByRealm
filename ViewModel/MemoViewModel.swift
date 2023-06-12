//
//  MemoViewModel.swift
//  DBInstall
//
//  Created by 채영민 on 2023/06/11.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memos: [Memo] = Array(Memo.findAll())
    
    func add(text:String, title:String) -> Void {
        guard !text.isEmpty else {return}
        guard !title.isEmpty else {return}
        let memo = Memo()
        memo.text = text
        memo.title = title
        self.memos.append(memo)
        Memo.addMemo(memo)
    }
    
    func refreshMemo() -> Void {
        self.memos = Array(Memo.findAll())
    }
    
    func editMemo(old: Memo, title:String, text:String ) -> Void {
        guard !text.isEmpty else {return}
        guard !title.isEmpty else {return}
        Memo.editMemo(memo: old, title: title, text: text)
    }
}
