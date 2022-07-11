//
//  ClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbView: View {
    let climb: Climb
    
    var body: some View {
        Form {
            VStack {
                HStack {
                    Text("V\(climb.grade)")
                        .font(.largeTitle)
                        .foregroundColor(colorToShow(climb.routeColour))
                    Spacer()
                    Text("\(climb.date.formatted(date: .omitted, time: .shortened))")
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Attemps")
                        Text(climb.attempts == 1 && climb.isSent ? "Flashed" : "\(climb.attempts) attemps")
                            .font(.title2)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Completion")
                        Text(climb.isSent ? "Sent" : "No send")
                            .font(.title2)
                    }
                }
                HStack {
                    VStack(alignment: .center) {
                        Text("Route")
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 300, height: 300)
                    }
                }
            }
        }
    }
}

struct ClimbView_Previews: PreviewProvider {
    static var climbs = Climbs()
    static var previews: some View {
        ClimbView(climb: climbs.items[0])
    }
}
