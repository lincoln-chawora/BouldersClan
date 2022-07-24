//
//  AddClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import CoreData
import SwiftUI

struct AddClimbView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowingGridView: Bool
    
    @State private var isSent = true
    @State private var grade = 0
    @State private var attempts = 1
    @State private var selectedColourIndex = 0
    @State private var date = Date.now
    let colours = ["White", "Green", "Blue", "Black", "Pink", "Red", "Purple", "Yellow", "Orange"]
    @State private var routeColour = "White"
    
    func gradeCalculation(_ direction: Bool) {
        if direction == true && grade < 10 {
            grade += 1
        }
        
        if direction == false && grade > 0 {
            grade -= 1
        }
    }
    
    func resetClimb() {
        attempts = 1
        isSent = true
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("Add climb")
                    .font(.title)
                Spacer()
            }
            .padding(.vertical)
            HStack(alignment: .top) {
                // Grade Stack.
                VStack {
                    Button("V\(grade)") {
                        gradeCalculation(true)
                    }
                    .frame(width: 50, height: 35)
                    .border(colorScheme == .dark ? .white : .black, width: 2)
                    
                    Button("-") {
                        gradeCalculation(false)
                    }
                }
                Spacer()
                // Attemps Stack.
                VStack {
                    Button("\(attempts)") {
                        attempts += 1
                    }
                    .frame(width: 40, height: 35)
                    .border(colorScheme == .dark ? .white : .black, width: 2)
                    
                    
                    Button("-") {
                        if attempts > 1 {
                            attempts -= 1
                        }
                    }
                }
                Spacer()
                VStack {
                    Toggle("Status",isOn: $isSent).toggleStyle(.switch).labelsHidden()
                    Text(isSent ? "Sent" : "No send")
                        .frame(width: 85, height: 20)
                        .onTapGesture {
                            isSent.toggle()
                        }
                }
                
                Spacer()
                Picker("Grade color", selection: $routeColour, content: {
                    ForEach(colours, id: \.self, content: { color in
                        Text(color)
                    })
                })
                .accentColor(BouldersClan.routeColour(routeColour, colorScheme))
                .frame(width: 65, height: 35)
                .border(BouldersClan.routeColour(routeColour, colorScheme), width: 2)
                .pickerStyle(.menu)
                Spacer()
                Button("Save") {
                    withAnimation {
                        let climb = Climb(context: moc)
                        climb.id = UUID()
                        climb.grade = Int16(grade)
                        climb.attempts = Int16(attempts)
                        climb.isSent = isSent
                        climb.routeColour = routeColour
                        climb.date = Date.now
                        climb.isKeyProject = climb.attempts > 5 && climb.isSent == false
                        climb.selectedColourIndex = Int16(selectedColourIndex)

                        if moc.hasChanges {
                          try? moc.save()
                        }
                    }
                    resetClimb()
                }
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .frame(width: 55, height: 35)
                .border(colorScheme == .dark ? .white : .black, width: 2)
                .background(colorScheme == .dark ? .white : .black)
            }
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(alignment: .bottom)

        }
        .padding([.horizontal, .bottom], 10)
        .background(colorScheme == .dark ? Color.gray.opacity(0.1) : Color.black.opacity(0.1))
    }
}
