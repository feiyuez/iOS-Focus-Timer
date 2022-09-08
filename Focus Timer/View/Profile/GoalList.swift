//
//  GoalList.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/13/21.
//

import SwiftUI

struct GoalList: View {
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Goal.timestamp, ascending: false)]
    ) var goals: FetchedResults<Goal>

    var body: some View {
        if goals.count > 0 {
            ForEach(goals) { Goal in
                GoalRow(goal: Goal)
            }
        } else {
            Text("You haven't started any timer yet.")
                .font(.caption)
        }
    }
}

struct GoalList_Previews: PreviewProvider {
    static var previews: some View {
        GoalList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
