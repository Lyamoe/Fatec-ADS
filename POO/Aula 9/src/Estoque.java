public class Estoque {
    String produto;
    int quantidade;
    String localArmazenamento;

    public Estoque (String produto, int quantidade, String localArmazenamento) {
        this.produto = produto;
        this.quantidade = quantidade;
        this.localArmazenamento = localArmazenamento;
    }

    public int getQuantidade() {
        return this.quantidade;
    }
    public String getLocalArmazenamento() {
        return this.localArmazenamento;
    }

    public void venda(int qt) {
        this.quantidade -= qt;
    }
    public void compra(int qt) {
        this.quantidade += qt;
    }
}
