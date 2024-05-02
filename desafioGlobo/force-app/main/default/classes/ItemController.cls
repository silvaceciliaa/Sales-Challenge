public class ItemController {
    
    public String Nome {get; set;}
    public Integer Quantidade {get; set;}
    public Double ValorUnitario {get; set;}
    public String DescricaoProduto {get; set;}
    public String NomeFornecedor {get; set;}
    
    public void salvarItem(){
        try {
            Item__c objItem = new Item__c();
            objItem.Name = Nome;
            objItem.Storage_Quantity__c = Quantidade;
            objItem.Unit_Price__c = ValorUnitario;
            objItem.Product_Description__c = DescricaoProduto;
            objItem.Supplier_Name__c = NomeFornecedor;
            
            insert objItem;
            
            Nome = null;
            Quantidade = null;
            ValorUnitario = null;
            DescricaoProduto = null;
            NomeFornecedor = null;
                
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.CONFIRM, 'Item inserido com sucesso!'));
        } catch(Exception e) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, 'Erro ao salvar item: ' + e.getMessage()));
        }
    
    }
}