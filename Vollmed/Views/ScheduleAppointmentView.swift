//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Quellenni Reis on 16/01/24.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @State private var selectedDate = Date.now
    
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
                print(selectedDate.convertToString().convertDateStringToReadleDate())
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
    }
}

#Preview {
    ScheduleAppointmentView()
}
