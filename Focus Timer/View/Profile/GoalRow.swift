//
//  GoalRow.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/12/21.
//

import SwiftUI

struct GoalRow: View {
    var goal: Goal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(goal.timestamp!, style: .date)
                    .font(.caption2)
                HStack(alignment: .bottom) {
                    Text("Proposed")
                        .frame(width: 150, alignment: .leading)
                    Spacer()
                    Text(String(goal.numOfSessions * goal.lengthOfFocus) + " min")
                        .fontWeight(.semibold)
                    Spacer()
                }
//                HStack(alignment: .bottom) {
//                    Text("Finished")
//                        .frame(width: 150, alignment: .leading)
//                    Spacer()
//                    Text(String(goal.completedFocus * goal.lengthOfFocus) + " min")
//                        .fontWeight(.semibold)
//                    Spacer()
//                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
        }
        .padding(15)
        .background(
            RadialGradient(gradient: Gradient(colors: [Color("blue1"), Color("blue2"), Color("blue3")]), center: .bottomLeading, startRadius: 20, endRadius: 200)
        )
        .cornerRadius(10)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct GoalRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalRow(goal: Goal())
    }
}
