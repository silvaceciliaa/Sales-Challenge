public class Pedido {
    
    public String Id;
    public String ClienteId;
    public Date DataPedido;
    public List<PedidoItens__c> lstItems = new List<PedidoItens__c>();
    public String Status;
    
    public Pedido__c novoPedido(String clienteId, Date dataPedido){
        
        //Crio um novo pedido
        Pedido__c pedido = new Pedido__c(Client__c=clienteId, Order_Date__c=dataPedido);
        
        //Insiro o novo pedido
        insert pedido;
        return pedido;
    }
    
    public PedidoItens__c adicionarItem(String itemPedido, Integer quantidade, String idPedido){
        //Procuro pelo Item passado como parâmetro
        Item__c item = [SELECT Id, Name, Storage_Quantity__c, Unit_Price__c FROM Item__c WHERE Id =:itemPedido LIMIT 1];
        PedidoItens__c pedidoItens = new PedidoItens__c();
        
        //Insiro as informações do Item encontrado, do Pedido e quantidade passados como parâmetro e por fim eu multiplico o preço unitário
        // do item com a quantidade desejada
        pedidoItens.Item__c = item.Id;
        pedidoItens.Pedido__c = idPedido;
        pedidoItens.Name = item.Name;
        pedidoItens.Quantity__c= quantidade;
        pedidoItens.Item_Total_Price__c = item.Unit_Price__c * quantidade;
        
        //Diminuo a quantidade do Item do estoque
        item.Storage_Quantity__c = (item.Storage_Quantity__c - quantidade);
        
        //atualizo o item
        update item;
        
        //insiro o novo pedido
        insert pedidoItens;
        
        return pedidoItens;
    }
    
    public void calcularTotal(String idPedido){
        //Procuro os itens do pedido passado
         List<PedidoItens__c> itensPedido = [SELECT Id, Item_Total_Price__c FROM PedidoItens__c WHERE Pedido__r.Id =:idPedido];
        
        //Inicio o contador zerado
        Decimal valorTotal = 0;
        
        //percorro todos os item do pedido e adiciono seu valor ao contador
        for(PedidoItens__c item : itensPedido) {
        	valorTotal += item.Item_Total_Price__c;
        }
        
        //Procuro o pedido passado
        Pedido__c pedido = [SELECT Id, Order_Total__c FROM Pedido__c WHERE Id =:idPedido];
        
        //atualizado o valor do campo de total do pedido
        pedido.Order_Total__c = valorTotal;
        
        //atualizo o registro
        update pedido;

    }
    
    public Pedido__c aprovarPedido(String idPedido){
        //Procuro o pedido passado
        Pedido__c pedido = [SELECT Id, Status__c FROM Pedido__c WHERE Id =:idPedido LIMIT 1];
        
        //Se o status do pedido encontrado for igual a Pendente, ele é atualizado para Aprovado, senão nada acontece
        if(pedido.Status__c == 'Pendente'){
           pedido.Status__c = 'Aprovado';
           update pedido;
        }
       
        return pedido;
    }
    
    public Pedido__c enviarPedido(String idPedido){
        
        //Procuro o pedido passado
        Pedido__c pedido = [SELECT Id, Status__c FROM Pedido__c WHERE Id =:idPedido LIMIT 1];
        
        //Se o status do pedido encontrado for igual a Aprovado, ele é atualizado para Enviado, senão nada acontece
        if(pedido.Status__c == 'Aprovado'){
           pedido.Status__c = 'Enviado';
           update pedido;
        }
       
        return pedido;
    }
    
    public Pedido__c cancelarPedido(String idPedido){
        
        //Procuro o pedido passado
        Pedido__c pedido = [SELECT Id, Status__c FROM Pedido__c WHERE Id =:idPedido LIMIT 1];
        
        //Se o status do pedido encontrado for diferente de Enviado ou Entregue, ele é atualizado para Cancelado e valor total da compra é 
        //igual a 0, senão nada acontece
        if(pedido.Status__c != 'Enviado' || pedido.Status__c != 'Entregue' ){
           pedido.Status__c = 'Cancelado';
           pedido.Order_Total__c = 0;
           update pedido;
        }
        return pedido;
    }
    
}