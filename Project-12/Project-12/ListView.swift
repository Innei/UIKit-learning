//
//  ListView.swift
//  Project-12
//
//  Created by Innei on 2021/2/17.
//

import SwiftUI

struct LinkButton: View {
    var text: String
    var tapped: () -> Void

    var body: some View {
        Button(action: {
            tapped()
        }) {
            HStack {
                Text(text).foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.forward").foregroundColor(.gray).opacity(0.8).scaleEffect(0.8)
            }
        }
    }
}

struct ListView: View {
    var body: some View {
        List {
            Section(header: Text("UIKit View Group")) {
                LinkButton(text: "ImageView") {
                    myNavigationController.pushViewController(ImageViewController(), animated: true)
                }
                LinkButton(text: "MapView") {
                    myNavigationController.pushViewController(MapViewController(), animated: true)
                }
                LinkButton(text: "NotificationView") {
                    myNavigationController.pushViewController(NotificationViewController(), animated: true)
                }
                LinkButton(text: "NSAttributedStringView") {
                    myNavigationController.pushViewController(NSAttributedStringViewController(), animated: true)
                }
                LinkButton(text: "FlexLayoutView") {
                    myNavigationController.pushViewController(FlexLayoutViewController(), animated: true)
                }
                LinkButton(text: "DrawShapeView") {
                    myNavigationController.pushViewController(DrawShapeViewController(), animated: true)
                }
                LinkButton(text: "EditorView") {
                    myNavigationController.pushViewController(EditorViewController(), animated: true)
                }
                LinkButton(text: "AuthenticationView") {
                    myNavigationController.pushViewController(AuthenticationViewController(), animated: true)
                }
            }

            Section(header: Text("SwiftUI View Group")) {
                NavigationLink("StorageView", destination: StorageView())
                NavigationLink(destination: TestView()) {
                    Text("View")
                }
                NavigationLink(destination: LocationView()) {
                    Text("LocationView")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Menu")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
