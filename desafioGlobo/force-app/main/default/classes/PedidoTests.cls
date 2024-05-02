@isTest
public class PedidoTests {
    
    @isTest
    static void novoPedidoTestePositivo(){
        // Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
        
        // Chamo o método novoPedido com os parâmetros necessários
        Pedido pedido = new Pedido();
        pedido.novoPedido(cliente.Id, Date.Today());
        
        // Verifico se o pedido foi inserido corretamente
        Pedido__c pedidoDois = [SELECT Id, Client__c, Status__c, Order_Date__c FROM Pedido__c WHERE Client__c =:cliente.Id LIMIT 1];
        
        System.assertEquals(cliente.Id, pedidoDois.Client__c);
    }
    
     @isTest
     static void adicionarItemTestePositivo(){         
        
        //Crio dados de teste
        Pedido pedidoTeste = new Pedido();
         
        Item__c itemTeste = new Item__c(Name='Item Teste', Storage_Quantity__c=10, Unit_Price__c=20);
        insert itemTeste;
         
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;

        Pedido__c pedidoCriado = pedidoTeste.novoPedido(cliente.Id, Date.Today());

        // Chamo o método adicionarItem com os parâmetros necessários
        Integer quantidade = 2;
        PedidoItens__c pedidoItemCriado = pedidoTeste.adicionarItem(itemTeste.Id, quantidade, pedidoCriado.Id);
        
        PedidoItens__c pedidoItemBuscado = [SELECT Id, Pedido__c FROM PedidoItens__c WHERE Id =: pedidoItemCriado.Id];

        // Verifico se o pedidoItemCriado contém os valores esperados
        System.assertEquals(pedidoItemCriado.Pedido__c, pedidoItemBuscado.Pedido__c);
        System.assertEquals(pedidoItemCriado.Id, pedidoItemBuscado.Id);
        
        // Verifico se a quantidade de estoque do item foi atualizada corretamente
        Item__c itemAtualizado = [SELECT Storage_Quantity__c FROM Item__c WHERE Id = :itemTeste.Id];
        System.assertEquals(itemTeste.Storage_Quantity__c - quantidade, itemAtualizado.Storage_Quantity__c);
    
        }
    
    @isTest
    static void atualizarValorTotalPedidoTestePositivo() {
        
        Pedido pedido = new Pedido();
        
        //Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;

        Pedido__c pedidoCriado = pedido.novoPedido(cliente.Id, Date.Today());
        
        Item__c itemTeste = new Item__c(Name='Item Teste', Storage_Quantity__c=10, Unit_Price__c=20);
        insert itemTeste;

        PedidoItens__c ItensPedidoUm = new PedidoItens__c(Pedido__c = pedidoCriado.Id, Item_Total_Price__c = 100, Item__c = itemTeste.Id);
        PedidoItens__c ItensPedidoDois = new PedidoItens__c(Pedido__c = pedidoCriado.Id, Item_Total_Price__c = 200, Item__c = itemTeste.Id);
        insert ItensPedidoUm;
        insert ItensPedidoDois;

        // Chamo o método calcularTotal com os parâmetros necessários
        pedido.calcularTotal(pedidoCriado.Id);

        // Verifico se o valor total do pedido foi atualizado corretamente
        Pedido__c pedidoAtualizado = [SELECT Order_Total__c FROM Pedido__c WHERE Id = :pedidoCriado.Id];
        System.assertEquals(300, pedidoAtualizado.Order_Total__c);
    }
    
    @isTest
    static void aprovarPedido(){
        //Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
            
        Pedido pedidoTeste = new Pedido();

        Pedido__c pedidoCriado = pedidoTeste.novoPedido(cliente.Id, Date.Today());
        
        // Chamo o método aprovarPedido com os parâmetros necessários
        Pedido__c pedidoAprovar = pedidoTeste.aprovarPedido(pedidoCriado.Id);   
        
        // Verifico se o status do pedido foi atualizado corretamente
        System.assertEquals('Aprovado', pedidoAprovar.Status__c);
        
    }
    
    @isTest
    static void enviarPedido(){
        //Crio dados de teste
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
            
        Pedido pedidoTeste = new Pedido();

        Pedido__c pedidoCriado = pedidoTeste.novoPedido(cliente.Id, Date.Today());
        
        pedidoTeste.aprovarPedido(pedidoCriado.Id);
        
        // Chamo o método enviarPedido com os parâmetros necessários
        Pedido__c pedidoEnviar = pedidoTeste.enviarPedido(pedidoCriado.Id);   
        
        // Verifico se o status do pedido foi atualizado corretamente
        System.assertEquals('Enviado', pedidoEnviar.Status__c);        
    }
    
    @isTest
    static void cancelarPedido(){
        Contact cliente = new Contact(FirstName='Cliente', LastName='Teste');
        insert cliente;
            
        Pedido pedidoTeste = new Pedido();
        
        Pedido__c pedidoCriado = pedidoTeste.novoPedido(cliente.Id, Date.Today());
        
        Pedido__c pedidoCancelar = pedidoTeste.cancelarPedido(pedidoCriado.Id);
        
        System.assertEquals('Cancelado', pedidoCancelar.Status__c);
    }
}