
public class DataService{

	def generateInitialJSON(feedUrl,keyType) {
		def feed = new XmlSlurper().parse(feedUrl)
		def returnMap = [:]
		for(item in feed.channel.item){
			//retreive all the successful builds
			//if(item.description.equals("Build passed")){
			def url = item.link.text().replace('buildresults','logs')
			url = url.replace('?log=','/')
			//retrieve all the modifications from the successful builds
			def buildResults = new XmlSlurper().parse(url)
			def modifications = buildResults.modifications
				for(modification in modifications.children()){
					if(keyType=='filename'){
						def filename = modification.file.filename.text()
						filename = filename.substring(filename.lastIndexOf('/')+1)
						def fileCount = returnMap[filename]
						if(fileCount==null)
							fileCount = 1
						else
							fileCount++
						returnMap[filename] = fileCount
						}
					else if(keyType=='user'){
						def user = modification.user.text()
						def userCount = returnMap[user]
						if(userCount==null)
							userCount = 1
						else
							userCount++
						returnMap[user] = userCount
								
					}
					else if (keyType=='package'){
						def fullName = modification.file.filename.text()
						if(fullName.contains('src')){
						def packageName = fullName.substring(fullName.lastIndexOf('src')+4)
						def fileName = fullName.substring(fullName.lastIndexOf('/')+1);
						packageName = packageName.replaceAll('/','.').replace('.'+fileName,'')
						def packageCount = returnMap[packageName]
						if(packageCount==null)
							packageCount = 1
						else
							packageCount++
						returnMap[packageName] = packageCount
						}
					}
					
				}

			//}
		}
		  return returnMap  

	}
	
	
}
