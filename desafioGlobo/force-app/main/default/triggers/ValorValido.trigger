trigger ValorValido on Pedido__c (before update, before insert) {
    //Verifico se a ação ocorreu antes
       if(Trigger.isBefore){
        // Percorro os registros 
        for(Pedido__c pedi : trigger.new){
            //se o campo Valor Total for menor ou igual a 0
            if(pedi.Order_Total__c <= 0 && pedi.Status__c != 'Cancelado'){
                //Erro
                pedi.addError('Pedido Inválido! Valor total deve ser maior que 0');
            }
        }
    }


}