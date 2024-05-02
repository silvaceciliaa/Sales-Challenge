@isTest
public class TriggersTests {
    
    @isTest
    static void testeFreteGratis(){
        //Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
        
        Pedido__c pedido = new Pedido__c(Client__c=cliente.Id, Order_Date__c=Date.Today(), Order_Total__c=200);
        insert pedido;
        
        //Procuro pelo campo frete do pedido criado
        List<Pedido__c> pedidos = [SELECT Shipping__c FROM Pedido__c WHERE Id =:pedido.id];
            
        Pedido__c pedidoRecebido = pedidos[0];
        
        //Verifico se o valor fixo está correto
        System.assertEquals(10, pedidoRecebido.Shipping__c);
    }
    
    @isTest
    static void testeValorValido(){
        //Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
        
        //Tento fazer a inserção de um pedido com valor total zerado 
        Pedido__c pedido = new Pedido__c(Client__c=cliente.Id, Order_Date__c=Date.Today(), Order_Total__c=0);
        try{
            insert pedido;
        } catch (DmlException e) {
            //Lançamento de erro
            System.assert(e.getMessage().contains('Pedido Inválido! Valor total deve ser maior que 0'));
        }

    }
    
    @isTest
    static void testeEstoqueInvalido(){
        
        //Faço a inserção de um item
        Item__c item = new Item__c(Name='Óleo Elseve', Storage_Quantity__c=1);
        insert item;
        
        //Tento atualizar a quantidade para 0
        item.Storage_Quantity__c=0;
        try{
            update item;
        } catch (DmlException e) {
            //Lançamento de erro
            System.assert(e.getMessage().contains('Estoque indisponível'));
        }

    }

}