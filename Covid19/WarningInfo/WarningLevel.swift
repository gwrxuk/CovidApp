//
//  WarningLevel.swift
//  Covid19
//
//  Created by Jung-Hua Liu on 2020/12/10.
//

import SwiftUI

struct WarningLevel: View {
    @ObservedObject var rules = WarningString()
    var content = ""
    var case7: Float?
    var body: some View {
        
        ForEach(0..<rules.settings.count){i in
            if let criteria = case7{
                if criteria >= rules.settings[i].minCase && criteria < rules.settings[i].maxCase{
                    Circle()
                        .fill(Color(rules.settings[i].color))
                        .frame(width: 50, height: 50)
                    
                    Text("Cases: \(criteria)")
                    Text("\(NSLocalizedString(rules.settings[i].instruction, comment: "comment"))")
                        .font(.system(size: 15))
                        .lineSpacing(2)
                }
            }
        }
    }
}

struct WarningLevel_Previews: PreviewProvider {
    static var previews: some View {
        WarningLevel()
    }
}
