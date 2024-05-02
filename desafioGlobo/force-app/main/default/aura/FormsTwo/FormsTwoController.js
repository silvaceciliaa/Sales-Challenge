({
	handleSuccess : function(component, event, helper) {
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type: "Success",
            "title": "Success!",
            "message": "Foi hein"
        });
        toastEvent.fire();
		
	}
})