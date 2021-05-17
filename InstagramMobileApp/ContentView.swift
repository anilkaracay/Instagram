//
//  ContentView.swift
//  InstagramMobileApp
//
//  Created by Macbook Air on 15.05.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            TabView()
        }
    }
}

struct TabView: View{
    @State var index = 1
    @Environment(\.colorScheme) var scheme
    var colors = [Color("Color1"),Color("Color2")]
    
    var body: some View{
        ZStack(alignment:.bottom){
            if self.index == 1 {
                Home()
            } else if self.index == 2 {
                Search().navigationBarHidden(true)
            } else if self.index == 3 {
                Notifications().navigationBarHidden(true)
            } else {
                Profile().navigationBarHidden(true)
            }
            
            //TabView
            
            ZStack(alignment: .top){
                HStack(spacing:0){
                    Button(action:{self.index = 1}){
                        Image(systemName: "homekit").foregroundColor(self.index == 1 ? Color.primary : Color.primary.opacity(1)).padding(.horizontal)
                    }.padding(.trailing,30)
                    Button(action:{self.index = 2}){
                        Image(systemName: "magnifyingglass").foregroundColor(self.index == 2 ? Color.primary : Color.primary.opacity(0.40)).padding(.horizontal)
                    }.padding(.trailing,30)
                    
                    Spacer(minLength: 0)
                    Button(action: {self.index = 3}, label: {
                        Image(systemName: "suit.heart.fill").font(.system(size: 24)).foregroundColor(self.index == 3 ? Color.primary : Color.primary.opacity(0.25)).padding(.horizontal)
                    }).padding(.trailing,30)
                    Button(action: {self.index = 4}, label: {
                        Image("profil").renderingMode(.original).resizable().frame(width:25,height: 25).clipShape(Circle()).padding(.horizontal)
                    })
                    
                    
                    
                }.padding(.horizontal).padding(.top).padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom).background(self.scheme == .dark ? Color.black : Color.white).clipShape(CShape()).shadow(color: Color.primary.opacity(0.08), radius: 5, x: 0, y: -10)
                
                Button(action: {}, label: {
                    Image(systemName: "plus").foregroundColor(.white).font(.system(size: 24)).padding().background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)).clipShape(Circle())
                }).offset(y:-25)
            }
            
            
        }.edgesIgnoringSafeArea(.bottom)
    }
    
}

struct Home : View{
    var colors = [Color("Color1"),Color("Color2")]
    @Environment(\.colorScheme) var scheme
    var body: some View{
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                ScrollView(.horizontal,showsIndicators : false){
                    HStack(spacing:15){
                        ZStack(alignment:.bottomTrailing){
                            Image("g1").resizable().aspectRatio(contentMode: .fill).frame(width:60, height: 60).clipShape(Circle())
                            Image(systemName: "plus.circle.fill").font(.system(size: 20)).foregroundColor(.primary)
                            
                        }
                        ForEach(2...8, id:\.self){ i in
                            ZStack{
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image("g\(i)").resizable().aspectRatio(contentMode: .fill).frame(width:60,height: 60).clipShape(Circle())
                                })
                                
                                
                                
                                Circle().stroke(AngularGradient(gradient: .init(colors: colors), center: .center),lineWidth: 3).frame(width:68,height: 68)
                            }
                            
                        }
                    }.padding()
                    
                }.background(self.scheme == .dark ? Color.black : Color.white).shadow(color: Color.primary.opacity(0.08), radius: 5, x: 5, y: 5)
                
                ForEach(postDatas){p in
                    PostView(postData: p)
                    
                    
                }
            }.padding(.bottom,110)
            
        }.navigationBarTitle("Instagram",displayMode: .inline).navigationBarItems(leading: Button(action: {}, label: {
            Image("kamera").foregroundColor(.gray)
        }), trailing: NavigationLink(
            destination: Text("Mesaj Gönder"),
            label: {
                Image("gonder").foregroundColor(.gray)
            }))
    
    }
}

struct PostView : View{
    var postData : Post
    @State var comment = ""
    var body: some View{
        VStack(alignment:.leading){
            HStack(spacing:12){
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(self.postData.profilePicture).resizable().aspectRatio(contentMode: .fill).frame(width:30,height:30).clipShape(Circle()).buttonStyle(PlainButtonStyle())
                })
                
                VStack(alignment:.leading,spacing:6){
                    Text(self.postData.username)
                    Text(self.postData.time).font(.caption).foregroundColor(.gray)
                }
                Spacer(minLength: 0)
                Button(action: {}, label: {
                    Image("menu").resizable().frame(width:22,height: 22).foregroundColor(.gray)
                })
            }
            Image(self.postData.postView).resizable().aspectRatio(contentMode: .fill).frame(width:UIScreen.main.bounds.width-30,height: 200).cornerRadius(20).padding(.vertical,10)
            
            HStack(spacing:20){
                Button(action: {}, label: {
                    Image(systemName: "suit.heart.fill").font(.system(size: 24)).foregroundColor(self.postData.liked ? Color.red : Color.gray)
                    
                })
                Button(action: {}, label: {
                    Image("gonder").foregroundColor(.gray)
                })
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    Image("kaydet").resizable().frame(width:18,height: 22).foregroundColor(.gray)
                })
            }
            Text(self.postData.likeAmount + "Beğeni")
            Text(self.postData.postTitle).padding(.top,5)
            Button(action: {}, label: {
                Text("Tüm Yorumları (452) Görüntüle")
            }).foregroundColor(.gray).padding(.vertical,10)
            
            HStack(spacing:15){
                TextField("Yorum ekle",text: self.$comment).font(.system(size: 12))
                Button(action: {}, label: {
                    Image(systemName: "plus").foregroundColor(.gray)
                })
            }.padding(.horizontal).padding(.vertical,10).background(Capsule().stroke(Color.gray,lineWidth: 1))
            
        }.padding(.horizontal).padding(.top)
    }
}

struct Search: View{
    var body: some View{
        GeometryReader{ _ in
            VStack{
                Text("Search Area").font(.system(size: 50,weight:.bold)).foregroundColor(.red)
            }
        }
        
    }
}

struct Notifications : View{
    var body: some View {
        GeometryReader{ _ in
            VStack{
                Text("Notifion Area").foregroundColor(.red).font(.system(size: 55,weight:.bold))
            }
            
        }
    }
}
struct Profile : View{
    var body: some View {
        GeometryReader{ _ in
            VStack{
                Text("Profile Area").foregroundColor(.red).font(.system(size: 55,weight:.bold))
            }
            
        }
    }
}

struct CShape : Shape{
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x:0,y:0))
            path.addLine(to: CGPoint(x:0,y:rect.height))
            path.addLine(to: CGPoint(x:rect.width,y:rect.height))
            path.addLine(to: CGPoint(x:rect.width,y:0))
            
            path.addArc(center: CGPoint(x: rect.width / 2, y:0), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: false)
        }
    }
}

struct Post : Identifiable{
    var id : Int
    var username : String
    var profilePicture : String
    var postView: String
    var postTitle: String
    var time : String
    var likeAmount : String
    var liked: Bool
}

var postDatas = [
    Post(id: 0, username: "oyunDiyari", profilePicture: "g1", postView: "post1", postTitle: "Yeni Resident Evil Village...", time: "24 dk önce", likeAmount: "1525", liked: true),
    Post(id: 1, username: "iJustine", profilePicture: "goruntu", postView: "post2", postTitle: "Iphone 11 vs Iphone 12", time: "58 dk önce", likeAmount: "2562", liked: false),
    Post(id: 2, username: "Apple", profilePicture: "g2", postView: "post3", postTitle: "WWDC 2020 @ June 22", time: "1 s önce", likeAmount: "24565", liked: true),
    Post(id: 3, username: "Deniz", profilePicture: "g4", postView: "post4", postTitle: "Nice Day :))", time: "28 dk önce", likeAmount: "1905", liked: false),
    Post(id: 4, username: "TeknoKayit", profilePicture: "g5", postView: "post5", postTitle: "Yeni Macbook Pro Kutu Açılımı", time: "2 dk önce", likeAmount: "312123", liked: true),
    Post(id: 5, username: "anilkaracay", profilePicture: "anil", postView: "anil", postTitle: "deneme", time: "3dk önce", likeAmount: "9999", liked: true)
    
    


]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
