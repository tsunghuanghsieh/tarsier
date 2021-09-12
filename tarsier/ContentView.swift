//
//  ContentView.swift
//  tarsier
//
//  Created by zonghuan on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var _findLogsim = false;
    @State private var _findSynthetic = false;

    // Agent Type
    @State private var _hasAgentActionAnimation = false;
    @State private var _hasAgentActionSpeed = false;
    @State private var _hasAgentActionStop = false;

    // Agent Actions
    @State private var _hasAgentTypeCar = false;
    @State private var _hasAgentTypeCyclist = false;
    @State private var _hasAgentTypePedestrian = false;

    @State private var _hasEvaluatorV1 = false;
    @State private var _hasEvaluatorV2 = false;
    
    @State private var _hasTrafficLight = false;
    
    @State private var _lyftcarTime = Date()
    
    class CarIdLimiter: ObservableObject {
        private let limit: Int = 9
        @Published var value = "" {
            didSet {
                if value.count > self.limit {
                    value = String(value.prefix(self.limit))
                }
            }
        }
    }
    
    @ObservedObject private var _carId = CarIdLimiter()

    @State private var _aaa = ""
    
    var body: some View {
        VStack(content: {
            HStack(alignment: .firstTextBaseline, content: {
                // Synthetic specfic criteria
                VStack(alignment: .leading) {
                    Toggle("Synthetic", isOn: $_findSynthetic)
                    Section {
                        GroupBox(label: Text("Agent Type:")
                                    .bold()
                                    .padding(.leading, -7.0)) {
                            Section {
                                Toggle("Car", isOn: $_hasAgentTypeCar)
                                Toggle("Cyclist", isOn: $_hasAgentTypeCyclist)
                                Toggle("Pedestrian", isOn: $_hasAgentTypePedestrian)
                            }
                            .padding(.leading)
                        }
                        .padding(.leading)
                        GroupBox(label: Text("Agent Action:")
                                    .bold()
                                    .padding(.leading, -7.0)) {
                            Section {
                                Toggle("Animation", isOn: $_hasAgentActionAnimation)
                                Toggle("Speed Action", isOn: $_hasAgentActionSpeed)
                                Toggle("Stop Action", isOn: $_hasAgentActionStop)
                            }
                            .padding(.leading)
                        }
                        .padding(.leading)
                        Toggle("Traffic light", isOn: $_hasTrafficLight)
                            .padding(.leading)
                    }
                    .disabled(_findSynthetic == false)
                }
                .padding(.leading)
                
                // Logsim specific criteria
                VStack(alignment: .leading) {
                    Toggle("Logsim", isOn: $_findLogsim)
                    Section {
                        HStack (alignment: .center) {
                            Text("Car ID:")
                            TextField(_carId.value, text: $_aaa)
                                .frame(width: 100, height: 15)
                        }
                        .padding(.leading)
                        Picker(selection: .constant(1), label: Text("Triage Mode:")) {
                            Text("LOGSIM").tag(1)
                            Text("LOGSIM_WITH_PERCEPTION").tag(2)
                        }
                        .padding(.leading)
                        DatePicker(selection: $_lyftcarTime, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                            .padding(.leading)
                    }
                    .disabled(_findLogsim == false)
                }
            })
            .padding([.top, .trailing])
            
            // Common criteria
            HStack(alignment: .firstTextBaseline) {
                GroupBox(label: Text("Evaluator Framework:")
                            .bold()
                            .padding(.leading, -7.0)) {
                    Section {
                        Toggle("V1", isOn: $_hasEvaluatorV1)
                        Toggle("V2", isOn: $_hasEvaluatorV2)
                    }
                    .padding(.leading)
                }
                .padding(.leading)
                Picker(selection: .constant(5), label: Text("Map:")) {
                    Text("EPA").tag(1)
                    Text("Golden Unicorn").tag(2)
                    Text("Gomentun").tag(3)
                    Text("Kirby").tag(4)
                    Text("MP++").tag(5)
                }
                Toggle("AAAAAAAAAAAAAAAAAA", isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/)
            }
            
            // Button row
            GeometryReader { geometry in
                HStack {
                    Section {
                        Spacer()
                        Button(action: {
                            exit(0);
                        }, label: {
                            Text("Cancel")
                                .frame(width: geometry.size.width * 0.11)
                        })
                        Button(action: {
                            
                        }, label: {
                            Text("Find")
                                .frame(width: geometry.size.width * 0.11)
                        })
                    }
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}
