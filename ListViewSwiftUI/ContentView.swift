//
//  ContentView.swift
//  ListViewSwiftUI
//
//  Created by Akash on 15/10/21.
//

import SwiftUI
import SwiftUIRefresh

struct ContentView: View {
    var body: some View {
        ScrollView{
        VStack{
            navListView.frame(height: 300, alignment: .center)
                onlyList.frame(height: 300, alignment: .center)
                listViewForLoop.frame(height: 300, alignment: .center)
                sectionGroupListView.frame(height: 300, alignment: .center)
            }
        }
    }
    
    var onlyList: some View {
        List {
            Text("Australia")
            Text("Belgium")
            Text("Canada")
            Text("Denmark")
            Text("Finland")
            Text("Germany")
            Text("Japan")
            Text("United States of America")
        }
    }
    
    struct country:Hashable, Identifiable {
        let id = UUID()
        let name: String
        let flag: String
    }
    
    //programmatically
    @State private var countries = [
        country(name: "Australia", flag: "Australia"),
        country(name: "Belgium", flag: "Belgium"),
        country(name: "Canada", flag: "Canada"),
        country(name: "Denmark", flag: "Denmark"),
        country(name: "Finland", flag: "Finland"),
        country(name: "Germany", flag: "Germany"),
        country(name: "Japan", flag: "Japan"),
        country(name: "United States of America",
                flag: "United States of America"),
    ]
    
    
    var listViewForLoop: some View {
        List {
            ForEach(countries, id: \.name) { (country) in
                Text(country.name)
            }
        }
        
    }
    
    var navListView: some View {
        NavigationView{
            List {
                ForEach(countries) { (country) in
                    NavigationLink(destination:
                                    VStack{
                        Text(country.name).bold()
                        Image(country.flag)
                    }
                    ) {
                        HStack {
                            Image(country.flag)
                            Text(country.name)
                        }
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }
            .navigationBarTitle("List of Countries")
            .navigationBarItems(
                leading: Button(action: addCountry,
                                label: { Text("Add") }
                               ),
                trailing: EditButton()
            )
        }
    }
    
    struct NewsItem: Decodable, Identifiable {
        let id: Int
        let title: String
        let strap: String
    }
    @State private var news = [
        NewsItem(id: 0, title: "Want the latest news?", strap: "Pull to refresh!")
    ]
    
    @State private var isShowing = false
    var sectionGroupListView: some View {
        List {
            ForEach(news) { item in
                Section(header: EmptyView()) {
                    ForEach (news) {
                        (country) in
                        Text(country.title)
                    }
                }
            }
        }.listStyle(GroupedListStyle()).pullToRefresh(isShowing: $isShowing) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isShowing = false
            }
        }
    }
    
    
    
    func move(from source: IndexSet, to destination: Int){
        countries.move(fromOffsets: source,
                       toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        countries.remove(atOffsets: offsets)
    }
    
    func addCountry() {
        countries.append(
            country(name: "Norway", flag: "Norway")
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
