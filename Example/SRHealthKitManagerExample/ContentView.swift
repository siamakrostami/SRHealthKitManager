//
//  ContentView.swift
//  SRHealthKitManagerExample
//
//  Created by Siamak Rostami on 2/22/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HealthKitViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section("Authorization") {
                    Button(action: {
                        Task {
                            await viewModel.requestAuthorization()
                        }
                    }) {
                        Text(viewModel.isAuthorized ? "Authorized ✅" : "Request Authorization")
                    }
                }
                
                Section("Step Count") {
                    VStack(alignment: .leading) {
                        Text("Today's Steps")
                            .font(.headline)
                        Text("\(viewModel.stepCount, specifier: "%.0f")")
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    Button("Refresh Steps") {
                        Task {
                            await viewModel.fetchStepCount()
                        }
                    }
                    
                    Button("Add Test Steps") {
                        Task {
                            await viewModel.addTestSteps()
                        }
                    }
                }
                
                Section("Heart Rate") {
                    VStack(alignment: .leading) {
                        Text("Latest Heart Rate")
                            .font(.headline)
                        Text("\(viewModel.heartRate, specifier: "%.0f") BPM")
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    Button("Refresh Heart Rate") {
                        Task {
                            await viewModel.fetchHeartRate()
                        }
                    }
                }
                
                Section("Test Workout") {
                    Button("Save Test Workout") {
                        Task {
                            await viewModel.saveTestWorkout()
                        }
                    }
                }
            }
            .navigationTitle("HealthKit Demo")
            .alert("HealthKit Error", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
            .alert("Save Workout", isPresented: $viewModel.showSuccess) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.saveSuccessfulMessage ?? "")
            }
        }
    }
}

#Preview {
    ContentView()
}
