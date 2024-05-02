({
    
    toggleDarkMode : function(component, event, helper) {
        var darkMode = component.get("v.darkMode");
        component.set("v.darkMode", !darkMode);
        
        var mainDiv = component.find("mainDiv");
        var classList = mainDiv.getElement().classList;
        if (darkMode) {
            classList.remove("dark-mode");
        } else {
            classList.add("dark-mode");
        }
    }, 
    
    numberClicked : function(component, event, helper) {
        
        if(component.get("v.strOperator") === '='){
            component.set("v.strInput", "");
            component.set("v.strOperator", "");
        }
        
        var numClicked = event.target.innerText;
        component.set("v.strInput", component.get("v.strInput") + numClicked);
        var strCurrentNumber = component.get("v.strCurrentNumber");
        if(strCurrentNumber){
            component.set("v.strCurrentNumber", strCurrentNumber + numClicked);
        }else{
            component.set("v.strCurrentNumber", numClicked);
        }
    },
    
    calculate : function(component, event, helper) {
        var lstNumbers = component.get("v.lstNumbers");
        var result = 0;
        lstNumbers.push(Number(component.get("v.strCurrentNumber")));
        component.set("v.lstNumbers", lstNumbers);
        
        switch(component.get("v.strOperator")){
            case '+':
                for(let num of lstNumbers){
                    result = result + num;
                }
                break;
            case '-':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result - lstNumbers[i];
                }
                break;
            case '/':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result / lstNumbers[i];
                }
                break;
            case 'x':
                result = lstNumbers[0];
                for(let i in lstNumbers){
                    if(i==0){
                        continue;
                    }
                    result = result * lstNumbers[i];
                }
                break;
            default:
                component.set("v.result", 0);
                console.log("Invalid Operator");
        }
        component.set("v.result", result);
        component.set("v.lstNumbers", []);
        component.set("v.strCurrentNumber", "");
        component.set("v.strOperator", '=');
    },
    
    operatorClicked : function(component, event, helper) {
        var op = event.target.innerText;
        component.set("v.strInput", component.get("v.strInput") +' ' + op +' ');
        component.set("v.strOperator", op);
        
        var lstNumbers = component.get("v.lstNumbers");
        lstNumbers.push(Number(component.get("v.strCurrentNumber")));
        component.set("v.lstNumbers", lstNumbers);
        component.set("v.strCurrentNumber", "");
        
    },
    
    clearClicked : function(component, event, helper) {
        component.set("v.lstNumbers", []);
        component.set("v.strCurrentNumber", "");
        component.set("v.strInput", "");
        component.set("v.strOperator", "");
        component.set("v.result", 0);
    }
})