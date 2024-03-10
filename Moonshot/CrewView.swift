//
//  CrewView.swift
//  Moonshot
//
//  Created by Margarita Mayer on 09/01/24.
//

import SwiftUI

struct CrewView: View, Hashable {
    
    struct CrewMember: Hashable {
        
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut), label: {
                                VStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        
                                        Text(crewMember.role)
                                            .foregroundStyle(.secondary)
                                        
                                    }
                                }
                                .padding(.horizontal)
                            })
                        
                    }
//                    .navigationDestination(for: CrewMember.self) { selection in
//                        AstronautView(astronaut: selection.astronaut) }
                   
                   
                    
                    //                    NavigationLink {
                    //                        AstronautView(astronaut: crewMember.astronaut)
                    //                    } label: {
                    //                        VStack {
                    //                            Image(crewMember.astronaut.id)
                    //                                .resizable()
                    //                                .frame(width: 104, height: 72)
                    //                                .clipShape(.capsule)
                    //                                .overlay(
                    //                                    Capsule()
                    //                                        .strokeBorder(.white, lineWidth: 1)
                    //                                )
                    //
                    //                            VStack(alignment: .leading) {
                    //                                Text(crewMember.astronaut.name)
                    //                                    .foregroundStyle(.white)
                    //                                    .font(.headline)
                    //
                    //                                Text(crewMember.role)
                    //                                    .foregroundStyle(.secondary)
                    //
                    //                            }
                    //                        }
                    //                        .padding(.horizontal)
                    //                    }
                    
                    
                }
            }
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut] ) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return CrewView(mission: missions[0], astronauts: astronauts)
}
