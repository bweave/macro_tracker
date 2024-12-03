struct TabItem {
  let title: String
  let image: String
  let selectedImage: String
  let path: String
  
  init(attributes: [String: String]) {
    self.title = attributes["title"] ?? ""
    self.image = attributes["image"] ?? "circle"
    self.selectedImage = attributes["selectedImage"] ?? "circle"
    self.path = attributes["path"] ?? ""
  }
}
