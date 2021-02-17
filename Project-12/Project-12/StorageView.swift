//
//  StorageView.swift
//  Project-12
//
//  Created by Innei on 2021/2/16.
//

import SwiftUI

struct StorageView: View {
    @AppStorage("name", store: UserDefaults.standard) var name: String = "Anonymous"

    var body: some View {
        Form {
            Section(footer:
                Text(name)
            ) {
                TextField("Username", text: $name)
            }
        }
    }
}

//class MyTextField: UIViewRepresentable {
//    func updateUIView(_ uiView: UITextField, context: Context) {
//
//    }
//
//    func makeUIView(context: Context) -> UITextField {
//        UITextField()
//    }
//}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
