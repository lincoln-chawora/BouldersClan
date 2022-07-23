//
//  ClimbRowView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbRowView: View {
    @ObservedObject var climb: Climb
    
    var body: some View {
        HStack {
            VStack {
                Rectangle()
                    .fill(routeColour(climb.routeColour ?? "Unknown"))
                    .frame(width: 5, height: 50)
            }
            VStack {
                HStack {
                    Text(climb.climbDate)
                    Spacer()
                    Text(climb.climbTime)
                }
            
                HStack {
                    Text(climb.formattedGrade)
                    Spacer()
                    Text(climb.attempts == 1 && climb.isSent ? "Flashed" : climb.formattedAttempts(short: false))
                        .frame(width: 100, alignment: .leading)
                    Spacer()
                    Text(climb.isSent ? "Sent" : "No send")
                        .frame(width: 70, alignment: .trailing)
                }
            }
            VStack {
                Rectangle()
                    .fill(climb.isSent ? .green : .red)
                    .frame(width: 5, height: 50)
            }
        }
    }
}
