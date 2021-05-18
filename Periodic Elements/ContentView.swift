//
//  ContentView.swift
//  Periodic Elements
//
//  Created by Student on 5/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var elements = [Element]()
    var body: some View {
        NavigationView {
            List(elements) { element in
                NavigationLink(
                    destination: VStack {
                        Text(element.name)
                            .padding()
                        Text(element.symbol)
                            .padding()
                        Text(element.history)
                            .padding()
                        Text(element.facts)
                            .padding()
                    },
                    label: {
                        HStack {
                            Text(element.symbol)
                            Text(element.name)
                        }
                    })
            }
            .navigationTitle("Periodic Elements")
        }
        .onAppear(perform: {
            queryAPI()
        })
    }

func queryAPI() {
    let apiKey = "?rapidapi-key=af566fcbb4msh88e63ad4be99311p19bc23jsn2e7d2831ba5d"
    let query = "https://periodictable.p.rapidapi.com/\(apiKey)"
    if let url = URL(string: query) {
        if let data = try? Data(contentsOf: url) {
            let json = try! JSON(data: data)
            let contents = json.arrayValue
            for item in contents {
                let name = item["name"].stringValue
                let symbol = item["symbol"].stringValue
                let facts = item["facts"].stringValue
                let history = item["history"].stringValue
                let element = Element(name: name, symbol: symbol, facts: facts, history: history)
                elements.append(element)
            }
        }
        
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Element: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let facts: String
    let history: String
}

