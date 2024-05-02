trigger ItemEstoqueInvalido on Item__c (before update) {
    //Verifico se a ação ocorreu antes
       if(Trigger.isBefore){
        // Percorro os registros 
        for(Item__c item : trigger.new){
            //se o campo quantidade em estoque igual a 0
            if(item.Storage_Quantity__c <= 0){
                //Erro
                item.addError('Estoque indisponível');
            }
        }
    }
}