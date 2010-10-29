<g:javascript library="jquery"/>
<g:javascript src="tagcloud.js" />
<link rel="stylesheet" href="${createLinkTo(dir:'css',file:'main.css')}"></link>
<html>
    <head>
        <title>Commit Visualizer</title>
		<jq:jquery> 
			renderVisualization('filename','7-1-0');
        </jq:jquery>
		
		<g:javascript>
		    var popupStatus = 0;
			function renderVisualization(dataType,branch){
				$("#tagcloud").remove();
				$('#viz').before('<div id="tagcloud" style="position: relative; width: 700px; height: 700px;"><div id="loading"><h2>Loading Visualization....</h2></div></div>');

				$.getJSON("data?type="+dataType+"&branch="+branch,
        			function(data){
        				var tagcloud = new TagCloud(document.getElementById('tagcloud'),'random',[{r:30,g:144,b:255},{r:28,g:134,b:238},{r:24,g:116,b:205}]);
        				tagcloud.setClickHandler(function(name,size){
        				alert(name+"\n Frequency: "+size);
        				
        			});
     			for(key in data){
          		tagcloud.addNode(new Node(key,data[key]));
          		}
          		$("#loading").fadeOut(200);
          		tagcloud.draw();
        		});
			}
			function readValuesAndVisualize(){
				var branch = $('#branchList :selected').text()
				var selection = $('input[name=typeSelection]:checked').val() 
				renderVisualization(selection,branch)
			}
			
			
		</g:javascript>
    </head>
    <body>
    
<div id="framecontent">
<div class="innertube">
<p>
Branch:
<select id="branchList" onchange="readValuesAndVisualize()">
  <option>7-1-0</option>
  <option>7-1-1</option>
  <option>7-2-0</option>
</select>
</p>
<p><input type="radio" name="typeSelection" value="filename" checked="checked" onclick="readValuesAndVisualize()">By Filename </input></p>
<p><input type="radio" name="typeSelection" value="package" onclick="readValuesAndVisualize()">By Package</input></p>
<p><input type="radio" name="typeSelection" value="user" onclick="readValuesAndVisualize()">By Developer</input></p>


</div>
</div>


<div id="maincontent">
<h2>Commit Visualizer</h2>
<p>A visualization of commits to an svn repository over the period of a few days.  Visualization can be rendered based
on the source files, the packages the code belongs to, or the developers who commited the code.</p>

<div id = "viz">
</div>
      
      
 </body>
</html>