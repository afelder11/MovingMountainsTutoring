//
//  ContentView.swift
//  FAQ Page2
//
//  Created by Akhil Lal on 11/11/20.
//

import SwiftUI

struct Item: Identifiable   {
    let id = UUID()
    let name: String
    var answer: [Item]?
}

struct ContentView: View {
    
    let arr: [Item] = [.question1, .question2, .question3, .question4, .question5, .question6, .question7, .question8, .question9, .question10]
    
    var body: some View {
        NavigationView {
            List(arr, children: \.answer) { row in Text(row.name)   }
                .navigationBarTitle(Text("FAQ"))
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

extension Item  {
    static let answer1 = Item(name: "Due to the pandemic, we are currently fully virtual. We will resume face to face tutoring sessions once it is safe to do so.")
    
    static let answer2 = Item(name: "We utilize the Zoom platform. Once registered, we’ll send a personalized Zoom meeting ID and passcode for your child’s sessions.")
    
    static let answer3 = Item(name: "Anytime! Please keep in mind we do have peak seasons so slots are not always available. Check out the booking session to see our availability.")
    
    static let answer4 = Item(name: "Visit our website at URL")
    
    static let answer5 = Item(name: "Tutoring is in high demand. If you’re unable to make your scheduled appointment you must notify the tutor at least 24 hours before to reschedule or you will lose a session. The cancellation policy is listed in the contract you would receive upon registration.")
    
    static let answer6 = Item(name: "Gather assessment data from your child’s teacher and the designated tutor will call you to discuss their tutoring style and to find out your desired outcome.")
    
    static let answer7 = Item(name: "At least 1-2 hours a week are recommended for students who are on grade level. Students who are below grade level should complete 4 hours a week.")
    
    static let answer8 = Item(name: "Yes, if a package is purchased and there is availability.")
    
    static let answer9 = Item(name: "15 minutes of homework help only followed by targeted instruction in the areas of need.")
    
    static let answer10 = Item(name: "Contact us at URL")
    
    static let question1 = Item(name: "Where are you located?", answer: [Item.answer1])
    
    static let question2 = Item(name: "What platform do you use for virtual learning?", answer: [Item.answer2])
    
    static let question3 = Item(name: "When should I schedule a tutoring session?", answer: [Item.answer3])
    
    static let question4 = Item(name: "How do I make an appointment?", answer: [Item.answer4])
    
    static let question5 = Item(name: "What happens if I miss my appointment?", answer: [Item.answer5])
    
    static let question6 = Item(name: "How should I prepare for my child’s first tutoring session?", answer: [Item.answer6])
    
    static let question7 = Item(name: "How long are the sessions?", answer: [Item.answer7])
    
    static let question8 = Item(name: "Can I have a set weekly appointment?", answer: [Item.answer8])
    
    static let question9 = Item(name: "What can I expect to be done during a tutoring session?", answer: [Item.answer9])
    
    static let question10 = Item(name: "How do I become a tutor?", answer: [Item.answer10])
}
