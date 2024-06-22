import SwiftUI

struct Settings: View {
    @Environment(\.dismiss) var dismiss
    @Binding var minimum: Int
    @Binding var maximum: Int
    @State private var rangeOptions = ["Upto 20", "Custom"]
    @Binding var currentRange: String
    
    @State private var min: Int = 0
    @State private var max: Int = 0
    
    @Binding var showElectronicConfig: Bool
    
    var body: some View { 
        NavigationView {
            Form {
                Section("Range") {
                    Picker("Select the range", selection: $currentRange) {
                        ForEach(rangeOptions, id: \.self) {
                            Text($0)
                        }
                    } .pickerStyle(.segmented)
                    if currentRange == "Custom" {
                        TextField("Minimum Atomic Number", value: $minimum, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                        TextField("Maximum Atomic Number", value: $maximum, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
                
                Section("More Options") {
                    Toggle("Electronic Configuration", isOn: $showElectronicConfig)
                }
                
                Section("Preview") {
                    HStack {
                        Spacer()
                        ZStack {
                            ZStack {
                                HStack {
                                    VStack {
                                        Text(String(20))
                                            .font(.system(.largeTitle, design: .rounded))
                                            .bold()
                                            .scaleEffect(0.5)
                                            .padding([.top, .leading], 0)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                            
                            VStack {
                                Text("Ca - Calcium")
                                    .font(.system(.title, design: .rounded))
                           
                                if showElectronicConfig {
                                    Text("2,8,8,2")
                                        .font(.system(.body, design: .rounded))
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            
                        }
                        .frame(height: 100)
                        .frame(maxWidth: 400)
                        .background(Color.secondary.opacity(0.2))
                        .cornerRadius(15)
                        .padding(20)
                        Spacer()
                    }
                }
                
            }
            .navigationTitle("Settings")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.caption.bold())
                        .padding(5)
                        .background(.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
        }
        .animation(.default, value: currentRange)
        .animation(.default, value: showValency)
        .animation(.default, value: showElectronicConfig)
    }
}
