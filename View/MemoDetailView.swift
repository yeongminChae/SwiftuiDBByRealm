//
//  MemoDetailView.swift
//  DBInstall
//
//  Created by 채영민 on 2023/06/12.
//

import SwiftUI

struct MemoDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var delCheck:Bool = false
    var proData: Memo
    
    init(_ proData: Memo) {
        self.proData = proData
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(proData.title)
                .font(.system(size:35))
                .bold()
            Divider()
            ScrollView {
                Text(proData.text)
                    .frame(width: 330, height: .infinity, alignment: .leading)
            }
        }
        .frame(width: 330, height: .infinity, alignment: .topTrailing)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    self.delCheck = true
                } label : {
                    Image(systemName: "trash")
                }
                
                NavigationLink {
                    CreateMemoView(proData)
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .alert("정말 삭제 하시겠어요?", isPresented: $delCheck) {
            Button("확인", role: .destructive) {
                self.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5 ) {
                    Memo.delMemo(proData)
                }
            }
            Button("아니요", role: .cancel){}
        }
    }
}

struct MemoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MemoDetailView(Memo())
    }
}
