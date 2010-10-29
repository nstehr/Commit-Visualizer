import grails.converters.*
import org.codehaus.groovy.grails.web.json.JSONObject

class VisualizerController {

	def dataService
	
    def index = {}
    
	//makes a call to the service, which in turn dynamically generates the 
	//return object based on the lastest builds in cruise control
    def data = {
			def keyType = params['type']
			def branch = params['branch']
			def url = "http://localhost/cruisecontrol/rss/release$branch-lightweight-ossFramework"
			render dataService.generateInitialJSON(url,keyType) as JSON
    		
	}
	
	
	
	
}
