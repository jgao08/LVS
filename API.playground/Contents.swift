import Foundation

struct Ingredient : Codable, Identifiable{
    let id : Int
    let name : String
    let amount : Float
    let original : String
    let originalName : String
    let unit : String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case amount
        case original
        case originalName
        case unit
    }
    
}



struct Step_Ingredient : Codable {
    let id : Int
    let name : String
    
    enum Coding: String, CodingKey{
        case id
        case name
    }
}

struct Step_Equipment : Codable {
    let id : Int
    let name : String
    
    enum Coding: String, CodingKey{
        case id
        case name
    }
}

struct Recipe_Step : Codable{
    let number : Int
    let step : String
    let ingredients : [Step_Ingredient]
    let equipment : [Step_Equipment]
    
    enum CodingKeys: String, CodingKey{
        case number
        case step
        case ingredients
        case equipment
    }
}
struct Recipe_Instructions : Codable{
    let name : String
    let steps : [Recipe_Step]
    
    enum CodingKeys: String, CodingKey{
        case name
        case steps
    }
}



struct Recipe_Info : Codable{
    let servings : Int
    let readyInMinutes : Int
    let author : String
    let authorURL : String
    let spoonURL : String
    let summary : String
    
    let cuisines : [String]
    let dishTypes : [String]
    let ingredientInfo : [Ingredient]
    let ingredientSteps : [Recipe_Instructions]
    
    enum CodingKeys: String, CodingKey{
        case servings
        case readyInMinutes
        case author = "sourceName"
        case authorURL = "sourceUrl"
        case spoonURL = "spoonacularSourceUrl"
        case summary
        case cuisines
        case dishTypes
        case ingredientInfo = "extendedIngredients"
        case ingredientSteps = "analyzedInstructions"
    }
}

struct Recipe : Codable, Identifiable{
    let id : Int
    let title : String
    let image : String
    let imageType : String

    enum CodingKeys: String, CodingKey{
        case id
        case title
        case image
        case imageType
    }
}
struct Recipes: Codable, Identifiable{
    let id = UUID()
    let offset : Int
    let numberOfRecipes : Int
    let totalRecipes : Int
    let recipes : [Recipe]
    
    
    enum CodingKeys: String, CodingKey {
        case offset
        case numberOfRecipes = "number"
        case totalRecipes = "totalResults"
        case recipes = "results"
    }
    
}


let decoder = JSONDecoder()

if let apiRequest = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&number=30&apiKey=74b60b38e65b4633a29943638466c700") {
    let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        if let data = data {
            do {
                let contents = try decoder.decode(Recipes.self, from: data)
                print("Offset: \(contents.offset)")
                print("Number Of Recipes: \(contents.numberOfRecipes)")
                print("Total Recipes: \(contents.totalRecipes)")
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    task.resume()
} else {
    print("Invalid URL")
}


if let apiRequest = URL(string: "https://api.spoonacular.com/recipes/511728/information?apiKey=74b60b38e65b4633a29943638466c700") {
    let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        if let data = data {
            do {
                let contents = try decoder.decode(Recipe_Info.self, from: data)
                print("Servings: \(contents.servings)")
                print("Ready In _ Minutes: \(contents.readyInMinutes)")
                print("Author: \(contents.author)")
                print("AuthorURL: \(contents.authorURL)")
                print("SpoonURL: \(contents.spoonURL)")
                print("Summary: \(contents.summary)")
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    task.resume()
} else {
    print("Invalid URL")
}

