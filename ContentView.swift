//
//  ContentView.swift
//  DBInstall
//
//  Created by 채영민 on 2023/06/11.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var memoVM: MemoViewModel
    
    var body: some View {
        var memos = memoVM.memos.sorted {$0.postedDate > $1.postedDate}
        
        NavigationView {
            VStack {
                List(memos, id: \.self) {memo in
                    NavigationLink(destination: {
                        MemoDetailView(memo)
                    }, label: {
                        Text(memo.title)
                    })
                }
                .refreshable {
                    memoVM.refreshMemo()
                }
                .background(.white)
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                })
                .navigationTitle("Memo")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(
                            destination: {
                                CreateMemoView(Memo())
                            },
                            label:{
                                Image(systemName:"plus")}
                        )
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(memoVM: MemoViewModel())
    }
}
