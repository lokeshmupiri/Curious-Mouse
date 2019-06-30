({
doInit: function(cmp){
    var action = cmp.get("c.getUser");
    action.setCallback(this, function(response){
        var state = response.getState();
        console.log('-----------state');
        if (state === "SUCCESS") {
            cmp.set("v.Name", response.getReturnValue());
            console.log('-----------rtrtr-'+cmp.get("v.Name"));
         }
      });
    	console.log('------------'+cmp.get("v.Name"));
     }
 })