//
//  WarningLevel.swift
//  Covid19
//
//  Created by Jung-Hua Liu on 2020/12/10.
//

import SwiftUI

struct WarningLevel: View {
    let ruleString = "Rule"
    var body: some View {
        Text(ruleString).onAppear(perform: {
            self.getWarning()
        })
    }
    
    func getWarning(){
     
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Warning", ofType: "plist"){
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                print(dict)
            }
        }
    }
}

struct WarningLevel_Previews: PreviewProvider {
    static var previews: some View {
        WarningLevel()
    }
}
