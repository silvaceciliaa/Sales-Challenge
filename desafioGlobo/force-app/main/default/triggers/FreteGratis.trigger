trigger FreteGratis on Pedido__c (before update, before insert) {
    //Verifico se a ação ocorreu antes
       if(Trigger.isBefore){
       // Percorro os registros 
        for(Pedido__c pedi : trigger.new){
            //se o campo Valor Total for maior ou igual a 0
            if(pedi.Order_Total__c >= 250){
                //frete grátis
                pedi.Shipping__c = 0;
            }
            //senão
            else{
                //valor fixo do frete de 10 reais
                pedi.Shipping__c = 10;
            }
        }
    }


}