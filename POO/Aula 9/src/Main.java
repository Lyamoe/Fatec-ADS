public class Main {
    public static void main(String[] args) {
        Fornecedor panificadora = new Fornecedor(1028475, "Panificadora", "8593-5830-534-53", "38956473", "Pão");
        Estoque pao = new Estoque("pao", 14, "C3-P4-D2");

        pao.venda(5);
        System.out.println(pao.getQuantidade());
        panificadora.mensagemCompraMercadoria();
        pao.compra(12);
        System.out.println(pao.getQuantidade());
    }
}
