//
//  MessageHelper.swift
//  ML-Derkach-Sydorova
//
//

import Foundation
class MessageHelper{
    var stylesValue: [String:Float] = [:]
    var messages:[String] = []
    
    func getStyles(_ stylesValueGot: [String:Float]){
        self.stylesValue = stylesValueGot
        setDescriptionStyle()
    }
    
    private func setDescriptionStyle(){
        let possibleStyle = stylesValue.max { $0.value < $1.value }?.key
        
        var percentagePair: [String:String] = [:]
        for pair in stylesValue{
            percentagePair[pair.key]=floatToPercentage(pair.value)
        }
        
        guard let possibleStyle = possibleStyle else{
            return
        }
        let message = "Your possible style is " + possibleStyle + " - " + percentagePair[possibleStyle]!
        
        self.messages.append(message)
        let advice = getAdvice(possibleStyle)
        self.messages.append(advice)
        otherStyles(percentagePair, possibleStyle)
    }
    
    private func floatToPercentage(_ value: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let formattedValue = formatter.string(from: NSNumber(value: value)) {
            return formattedValue
        } else {
            return ""
        }
    }
    
    private func getAdvice(_ possibleStyle:String)->String{
        switch possibleStyle{
        case "Casual":
            self.messages.append("catCasual.jpg")
            return "Casual clothes are perfect for relaxed outings and informal occasions. They allow you to express your personal style while staying comfortable. Remember, casual attire is suitable for outings with friends, brunches, and casual gatherings. Avoid wearing casual clothes to formal events or professional settings, where a more polished and formal dress code is expected. Dress comfortably and confidently, reflecting your unique personality!"
        case "Party":
            self.messages.append("catParty.jpg")
            return "Party style is all about embracing fun and expressing your individuality. However, it's important to consider the party's theme or dress code. For formal parties, go for a cocktail dress or a tailored suit. And for more casual parties, you can experiment with trendy separates or a fashionable jumpsuit. Let loose, dance, and enjoy the celebration!"
        case "Formal":
            self.messages.append("catFormal.jpeg")
            return "Formal style exudes elegance and sophistication. It's important to dress appropriately for formal occasions to show respect and professionalism. Choose attire that is refined and well-fitted. Remember to dress modestly, with appropriate hemlines and necklines. Formal style is ideal for events like weddings, galas, and corporate functions. Embrace the refined aesthetic and make a lasting impression with your impeccable formal attire."
        default: //SPORT
            self.messages.append("catSport.jpg")
            return "Sport style is all about comfort and functionality. When dressing for a sporty look, prioritize clothes that allow ease of movement. Choose materials that wick away sweat and provide breathability. Sport style is perfect for workouts, outdoor activities, and casual athletic events. Embrace an active lifestyle while looking effortlessly cool and ready for action!"
        }
    }
    private func otherStyles(_ styles:[String:String], _ possibleStyle: String){
        var allOtherStyles: String = "\n \n Other possible styles here:"
        for style in styles{
            if style.key != possibleStyle{
                allOtherStyles += "\n" + style.key + " - " + style.value
            }
        }
        self.messages.append(allOtherStyles)
        
    }
}
