//
//  ContentView.swift
//  Covid19
//
//  Created by Jung-Hua Liu on 2020/12/9.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetch = FetchData()
    var body: some View {
        VStack {
            WarningLevel()
            if(fetch.features.count>0){
            if let result = fetch.features[0].attributes{
              
                if (result["cases7_per_100k"]! > 0.0){
                    Text("my float is \(result["cases7_per_100k"]!)")
                }else{
                    Text("No Data")
                }
                
            }
            }else{
                Text("No data")
            }
          
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
