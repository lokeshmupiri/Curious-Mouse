({
     doInit : function(component, event, helper) {
         var action = component.get("c.getUser");
          console.log('---'+component.get("v.user"));
         action.setCallback(this, function(response) {
              console.log('---'+component.get("v.user"));
             var state = response.getState();
             if (component.isValid() && state === "SUCCESS") {
                 component.set("v.user", response.getReturnValue());
                 console.log('---'+component.get("v.user"));
             } else {
                 console.log('There was an error');
             }
         });
         $A.enqueueAction(action);
     },
    handleMenuSelect: function(component, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        console.log('---'+selectedMenuItemValue);
        
        if(selectedMenuItemValue == 'Profile'){
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": '/profile/' + component.get("v.user").Id
            });
            urlEvent.fire();  
        } else if(selectedMenuItemValue == 'Logout'){
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": '/logout' 
            });
            urlEvent.fire(); 
        }
        console.log(selectedMenuItemValue);
    }	
})