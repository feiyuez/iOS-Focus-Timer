//
// MainView.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/13/21.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var timerModel = TimerModel()
    
    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Goal.timestamp, ascending: false)]
    ) var goals: FetchedResults<Goal>
    
    var body: some View {
        VStack {
            HStack {
                Text("\(timerModel.completedFocus) / \(UserDefaults.standard.integer(forKey: "numOfSessions")/2)")
                    .font(.subheadline)
                    .padding(6)
                    .background(Color("lightGray"))
                    .cornerRadius(10)
                Spacer()
                VStack {
                    if timerModel.type == .relax {
                        Button(action: {
                            timerModel.skip()
                        }, label: {
                            Image(systemName: "forward.fill")
                                .padding(10)
                                .background(Color.yellow)
                                .cornerRadius(100)
                                .foregroundColor(.white)
                        })
                        Text("SKIP BREAK")
                            .font(.caption2)
                    }
                }
                VStack {
                    Button(action: {
                        updateGoal(goal: goals[0], completed: timerModel.completedFocus)
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "stop.fill")
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(100)
                            .foregroundColor(.white)
                    })
                    Text("END TIMER")
                        .font(.caption2)
                }
            }
            .padding()
            
            Spacer()
            
            if timerModel.status == .over {
                Text("Congrats!")
                    .font(.title)
                Text("You have finished your goal.")
                    .font(.title)
            } else {
                Text(secondsToMinutesAndSeconds(seconds: timerModel.secondsLeft))
                    .font(.largeTitle)
                Text(timerModel.type == .focus ? "until your next break" : "until your next focus")
                    .padding(.bottom)
                
                if timerModel.status == .initial || timerModel.status == .paused {
                    Button(action: {
                        timerModel.start()
                    }) {
                        Text(timerModel.status == .initial ? "START" : "CONTINUE")
                            .font(.headline)
                            .padding(15)
                            .background(Color.green)
                            .cornerRadius(100)
                            .foregroundColor(.white)
                    }
                } else {
                    Button(action: {
                        timerModel.pause()
                    }) {
                        Text("PAUSE")
                            .font(.headline)
                            .padding(15)
                            .background(Color.blue)
                            .cornerRadius(100)
                            .foregroundColor(.white)
                    }
                }
            }

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func secondsToMinutesAndSeconds(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        
        return "\(minuteStamp) : \(secondStamp)"
    }
    
    func updateGoal(goal: Goal, completed: Int) {
        viewContext.performAndWait {
//            goal.completedFocus = Int16(10)
//            try? viewContext.save()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
