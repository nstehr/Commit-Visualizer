class UrlMappings {
    static mappings = {
      "/data"(controller:"visualizer", action:"data")
      "/"(controller:"visualizer", view:"/index")
	  "500"(view:'/error')
	}
}
