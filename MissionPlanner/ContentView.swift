//
//  ContentView.swift
//  MissionPlanner
//
//  Created by apple on 18/04/2023.
//

import SwiftUI


struct ContentView: View {
    let appData: Appdata
    @State var countdowntimer=900
    @State var timerrunning=false
    @State var checker=1
    @State var earnedscore=0
   // @State var imageName="square";
    @State var t:[Bool]=[];
    @State var tc=false;
    @State var imageName = Array(repeating: "square", count: 50)
    @State var index=0;
    
    @State var isPlaying = Array(repeating: false, count: 60)
    
   
   let timer=Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    init(){
       self.appData = Appdata(list:loadJsonData())
    }

    var body: some View {
        
        VStack (alignment: .leading){
            HStack {
                //Left col
                LazyVStack {
                    
                    //timer
                    Text("\(countdowntimer/60)"+" : "+"\(countdowntimer%60)")

                        .padding(.vertical, 150.0)
                        .onReceive(timer){_ in
                            if countdowntimer>0 && timerrunning{
                                countdowntimer-=1
                            }else{
                                timerrunning=false
                            }
                        }
                        .font(.system(size:80,weight:.bold))
                        .opacity(0.8)
                        .background(
                            Circle()
                                .fill(Color(hue: 0.439, saturation: 0.337, brightness: 0.871))
                                .frame(width: 300.0, height: 300.0)
                            
                        )
                    //timer button
                    VStack(alignment: .center, spacing: 5.0){//timer button
                        Button("START") {
                            timerrunning=true
                        }
                        .frame(width: 150.0, height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .background(Color(hue: 1.0, saturation: 0.023, brightness: 0.588))
                        
                        Spacer()
                        
                        
                        Button("PAUSE") {
                            timerrunning=false
                        }
                        .frame(width: 150.0, height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .background(Color(hue: 1.0, saturation: 0.023, brightness: 0.588))
                        Spacer()
                        
                        Button("CONTINUE") {
                            timerrunning=true
                        }
                        .frame(width: 150.0, height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .background(Color(hue: 1.0, saturation: 0.023, brightness: 0.588))
                        Spacer()
                        
                        Button("RESET") {
                            countdowntimer=900
                            timerrunning=false
                        }
                        .frame(width: 150.0, height: 50.0)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .background(Color(hue: 1.0, saturation: 0.023, brightness: 0.588))
                        
                        Spacer()
                        ForEach(1...6, id: \.self) { count in
                                                   Spacer()
                                               }
                    }
                    
                    
                    
                }
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.901))
                .frame(width: 400, height:.none, alignment:.topLeading)
                
                //Right col
                VStack{
                    Spacer()
                    Spacer()
                    Text("TaskList")
                        .font(.system(size: 45.0))
                    Spacer()
                    Spacer()
                    Text("The Score: "+"\(earnedscore)")
                        .font(.title3)
                        .fontWeight(.regular)
                        .foregroundColor(Color.red)
                        //.padding(.top, 5.0)
                        
                    
                    HStack(alignment:.center , spacing: 40.0){
                        Button("Task1") {
                            checker=1
                        }
                        .frame(width: 150.0, height: 50.0)//.foregroundColor(.red)
                        .background(Color(hue: 0.439, saturation: 0.092, brightness: 0.936))
                        .foregroundColor(.black)
                        .font(.system(size: 25.0))
                        .cornerRadius(30.0)
                        Button("Task2") {
                            checker=2
                        }
                        .frame(width: 150.0, height: 50.0)//.foregroundColor(.red)
                        .background(Color(hue: 0.439, saturation: 0.092, brightness: 0.936))
                        .foregroundColor(.black)
                        .font(.system(size: 25.0))
                        .cornerRadius(30.0)
                        Button("Task3") {
                            checker=3
                        }
                        .frame(width: 150.0, height: 50.0)//.foregroundColor(.red)
                        .background(Color(hue: 0.439, saturation: 0.092, brightness: 0.936))
                        .foregroundColor(.black)
                        .font(.system(size: 25.0))
                        .cornerRadius(30.0)
                        
                        
                    }
                    .padding(.horizontal)
                    //.padding(.vertical, 10.0)
                    ForEach(1...3, id: \.self) { count in
                        Spacer()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        
                        
                       List(self.appData.list){Tasklist in
                            if(Int(Tasklist.id/1)==checker){
                                Text(Tasklist.task)
                                    .font(.title3)
                                    .fontWeight(.light)

                                ForEach(Tasklist.subtask){ sub in
                                    
                                    HStack{
                                        Text(sub.content+" - "+"\(sub.point)"+"P")
                                        Button (action:{
                                            if(imageName[sub.index]=="checkmark"){
                                                self.imageName[sub.index]="square"
                                                earnedscore-=sub.point
                                            }else{
                                                self.imageName[sub.index]="checkmark"
                                                earnedscore+=sub.point
                                            }
                                            },label:{
                                                Image(imageName[sub.index])
                                                  .resizable()
                                                  .frame(width: 20.0, height: 20.0)
                                                  .scaledToFit()
                                            })
                                            .frame(width: 20.0, height: 20.0)

                                    }
                                }
                            }
                            
                        }
                    }.background(Color("AccentColor"))
                    
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
