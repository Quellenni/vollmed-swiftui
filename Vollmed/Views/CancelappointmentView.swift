//
//  CancelappointmentView.swift
//  Vollmed
//
//  Created by Quellenni Reis on 20/01/24.
//

import SwiftUI

struct CancelappointmentView: View {
    
    var appointmentID: String
    let service = WebService()
    
    @State private var reasonToCancel = ""
    @State private var showAlert = false
    @State private var isAppontementCancelled = false
    
    func cancelAppointment() async {
        do {
            if try await
                service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso")
            }
        } catch {
            print("Ocorreu um erro ao desmarcar a consulta: \(error)")
            isAppontementCancelled = false
        }
        showAlert = true
        
    }
    
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
        .alert(isAppontementCancelled ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isAppontementCancelled) { _ in
            Button("OK", action: {})
        } message: { isCancelled in
            if isCancelled {
                Text("A consulta foi cancelada com sucesso")
            } else {
                Text("Houve um erro ao cancelar a consulta. Por favor tente novamente ou entre em contato via telefone")
            }
        }
    }
}

#Preview {
    CancelappointmentView(appointmentID: "123")
}
