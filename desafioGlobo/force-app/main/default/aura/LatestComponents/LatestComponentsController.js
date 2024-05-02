({
    getLatestLeads : function(component, event, helper) {
        var action = component.get("c.getLeads");
        action.setCallback(this, function(data) {
            component.set("v.leads", data.getReturnValue());
            console.log(data.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})