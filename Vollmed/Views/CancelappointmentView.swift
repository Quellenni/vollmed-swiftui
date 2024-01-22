//
//  CancelappointmentView.swift
//  Vollmed
//
//  Created by Quellenni Reis on 20/01/24.
//

import SwiftUI

struct CancelappointmentView: View {
    
    @State private var reasonToCancel = ""
    let service = WebService()
    
    func cancelAppointment() async {
        do {
            if try await
                service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso")
            }
        } catch {
            print("Ocorreu um erro ao desmarcar a consulta: \(error)")
        }
        
    }
    
    var appointmentID: String
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CancelappointmentView(appointmentID: "123")
}
