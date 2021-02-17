//
//  HomeView.swift
//  Project-12
//
//  Created by Innei on 2021/2/16.
//

import SwiftUI

extension Array {
    mutating func push(_ el: Element) {
        append(el)
    }
}

enum SFSymbol: String, View {
    case right = "chevron.forward"

    var body: some View {
        Image(systemName: self.rawValue)
    }
}

struct TestView: View {
    @State var people: [Person] = []
    @State private var editMode: EditMode = EditMode.inactive

//    fileprivate func Item1() -> some View {
//        return HStack {
//            Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: "https://resume.innei.ren/avatar.ec3d4d8d.png")!))!)
//                .resizable()
//                .clipShape(Circle())
//                .frame(width: 30, height: 30, alignment: .center)
//            Spacer()
//        }
//    }

    var body: some View {
        VStack {
//            GroupBox(label: Label("title", systemImage: "house")) {
//                List {
//                    Text("inside")
//                    Text("inside")
//                }
//
//            }
            ScrollViewReader { reader in
                List {
                    Section {
                        Text("Section-1").id("top")

//                        Item1()
                        Button(action: {
                            self.editMode = self.editMode == EditMode.inactive ? EditMode.active : EditMode.inactive
                        }) {
                            Text(self.editMode == EditMode.inactive ? "Edit" : "Done")
                        }
                        Button(action: {
                            let ac = UIAlertController(title: "", message: nil, preferredStyle: .alert)

                            ac.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { _ in

                            }))

                            ac.addAction(UIAlertAction(title: "To top", style: .default, handler: { _ in
                                withAnimation {
                                    reader.scrollTo("top")
                                }

                            }))

                            rootController.present(ac, animated: true, completion: {
                            })
                        }) {
                            Text("Click")
                        }
                    }
                    Button(action: {
                        myNavigationController.pushViewController(UIHostingController(rootView: StorageView()), animated: true)
                    }) {
                        HStack {
                            Text("Next")
                            Spacer()
                            SFSymbol.right.foregroundColor(Color.red).opacity(0.8).scaleEffect(0.5)
                        }
                    }
                    NavigationLink("Next", destination: StorageView())

                    ForEach(self.people) {
                        Text($0.name)
                    }.onDelete { indexSet in

                        withAnimation {
                            self.people.remove(atOffsets: indexSet)
                        }
//                        var cp = self.people.map {$0}
//                        cp.remove(atOffsets: indexSet)
//                        self.people.remove(atOffsets: indexSet)
                        let defaults = UserDefaults.standard
                        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: self.people, requiringSecureCoding: false) {
                            print(String(data: savedData, encoding: .utf8) ?? nil)
                            defaults.set(savedData, forKey: "people")
                        }
                    }
                }

                .listStyle(GroupedListStyle())
            }
            HStack {
                Spacer()
                Button(action: {
                    let defaults = UserDefaults.standard
                    var obj = self.people
                    let randomInt = Int.random(in: 0 ... 100)
                    let el = Person(name: "person-\(randomInt)", image: "image-1", uuid: nil)
                    obj.append(el)

                    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: obj, requiringSecureCoding: false) {
                        print(savedData)
                        defaults.set(savedData, forKey: "people")
                        withAnimation {
                            self.people.append(el)
                        }
                    }
                }, label: {
                    Text("Add")
                })
                Spacer()
                Button(action: {
                    guard let jsonString = self.people.first?.rawJSONString() else { return }
                    let ac = UIAlertController(title: "JSON RAW", message: jsonString, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in

                    }))
                    UIApplication.shared.windows.first?.rootViewController?.present(ac, animated: true, completion: {
                    })

                }) {
                    Text("JSON")
                }
                Spacer()
            }
        }
        .environment(\.editMode, $editMode)
        .navigationBarTitle(Text("Today‘s Flavors"))
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    myNavigationController.pushViewController(ImagePickerViewController(), animated: true)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
        )
        .onAppear {
            let defaults = UserDefaults.standard

            if let savedPeople = defaults.object(forKey: "people") as? Data {
                if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
                    self.people = decodedPeople
                }
            }
        }
    }
}

extension View {
    var rootController: UIViewController {
        UIApplication.shared.windows.first!.rootViewController!
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
