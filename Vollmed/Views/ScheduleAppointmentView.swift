//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Quellenni Reis on 16/01/24.
//

import SwiftUI

struct ScheduleAppointmentView: View {

    @Environment(\.presentationMode) var presentationMode

    let service = WebService()
    var specialistID: String
    
    @State private var selectedDate = Date.now
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    
    func scheduleAppointment() async {
        do {
            if let _ = try await
                service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                    isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
      
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date.now...)
                .datePickerStyle(.graphical)
           
            Button(action: {
                Task {
                    await scheduleAppointment()
                }
            }, label: {
                ButtonView(text: "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
                   UIDatePicker.appearance().minuteInterval = 15
               }
        .alert(isAppointmentScheduled ? "Sucesso" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Ok")
            })

        } message: { isSchedule in
            if isSchedule {
                Text("A consulta foi agendada com sucesso!")
            } else {
                Text("Houve um erro ao agendar sua consulta. Por favor tente novamente ou entre em contato pelo telefone")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
