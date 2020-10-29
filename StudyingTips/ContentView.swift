//
//  ContentView.swift
//  StudyingTips
//
//  Created by Austin Felder on 10/23/20.
//

import SwiftUI



struct ContentView: View {
    @State var tips: [String] = ["Organize your study space",
                                  "Take regular breaks",
                                  "Use flowcharts and diagrams"
                                  ]
    
    
    init(){
        UITableView.appearance().backgroundColor = .gray
        UITableViewCell.appearance().backgroundColor = .gray
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                List (tips, id: \.self){ tip in
                    Text(tip)
    
                }
                .navigationBarTitle("Studying Tips")
                
       
            }
            
        
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


