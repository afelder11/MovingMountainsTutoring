//
//  DataStore.swift
//  StudyingTips
//
//  Created by Austin Felder on 10/23/20.
//

import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
    
    //Add note complicated stuff later
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
