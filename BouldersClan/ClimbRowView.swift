//
//  ClimbRowView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbRowView: View {
    var grade: Int
    var isSent: Bool
    var attempts: Int
    var date: Date
    var selectedColour: String
    
    var body: some View {
        HStack {
            VStack {
                Rectangle()
                    .fill(colorToShow(selectedColour))
                    .frame(width: 5, height: 50)
            }
            VStack {
                HStack {
                    Text("\(date.formatted(date: .numeric, time: .omitted))")
                    Spacer()
                    Text("\(date.formatted(date: .omitted, time: .shortened))")
                }
            
                HStack {
                    Text("V\(grade)")
                    Spacer()
                    Text(attempts == 1 && isSent ? "Flashed" : "\(attempts) attemps")
                    Spacer()
                    Text(isSent ? "Sent" : "No send")
                }
            }
            VStack {
                Rectangle()
                    .fill(isSent ? .green : .red)
                    .frame(width: 5, height: 50)
            }
        }
    }
}

struct ClimbRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClimbRowView(grade: 0, isSent: true, attempts: 1, date: Date.now, selectedColour: "White")
    }
}
