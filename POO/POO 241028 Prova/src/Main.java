public class Main {
    public static void main(String[] args){
        //?========= Criação de objetos ==========
        //*Classe pessoa
        Pessoa pessoa1 = new Pessoa("Lyam");
        Pessoa pessoa2 = new Pessoa("Kaue");

        //*Classe PessoaFisica
        PessoaFisica pessoaFisica1 = new PessoaFisica("259.164.238-96", "14/12/1973", "Karin");
        PessoaFisica pessoaFisica2 = new PessoaFisica("403.311.528-51", "03/01/2006", "Mayl");

        //*Classe Vendedor
        Vendedor vendedor1 = new Vendedor(1960, "583.604.294-27", "08/08/2005", "Kled");
        Vendedor vendedor2 = new Vendedor(1960, "485.295.583-XX", "09/09/1979", "Edvaldo");
        
        //*Classe VendedorGerente
        VendedorGerente vendedorGerente1 = new VendedorGerente(3050, "960.4856.385-64", "13/05/1999", "Gyehyeon");
        VendedorGerente vendedorGerente2 = new VendedorGerente(3000, "853.603.684-31", "13/11/2001", "Hyeju");

        //*Classe Cliente
        Cliente cliente1 = new Cliente("573.603.295-53", "16/03/2008", "Allin");
        Cliente cliente2 = new Cliente("849.302.198-02", "26/11/2008", "Ana");

        //*Classe PessoaJuridica
        PessoaJuridica pessoaJuridica1 = new PessoaJuridica("05.311.244/0001-09", "Casa da Mãe Joana");
        PessoaJuridica pessoaJuridica2 = new PessoaJuridica("34.124.756/0023-07", "Bandopolis");

        //*Classe ClienteEmpresa
        ClienteEmpresa clienteEmpresa1 = new ClienteEmpresa("Biscoito", "85.395.583/5820-59", "Escoteiros do Teemo");
        ClienteEmpresa clienteEmpresa2 = new ClienteEmpresa("Macarrão", "927.472.573/0047-43", "Kimberly Lippington");

        //*Classe Fornecedor
        Fornecedor fornecedor1 = new Fornecedor("Rato", "23/11/2024", "34.456.245/7331-96", "Semar");
        Fornecedor fornecedor2 = new Fornecedor("Água", "23/11/2024", "01.234.567/8901-23", "Poseidon");

        //?========= TESTE MÉTODOS ==========
        System.out.println("Nome da pessoa1: " + pessoa1.getNome());
        System.out.println("Id da pessoa2: " + pessoa2.getId());
        System.out.println("CPF da pessoaFisica1: " + pessoaFisica1.getCpf());
        System.out.println("DataNasc da pessoaFisica2:" + pessoaFisica2.getDataNasc());
        cliente1.compra(36.55, "Debito", 40, vendedor1);
        cliente1.avaliarLoja(10);
        cliente2.avaliarLoja(4);
        System.out.println("Avaliação do cliente2: " + cliente2.getAvaliacao());
        System.out.println("Salário do vendedor1 pós venda: " + vendedor1.aumentoPorVenda());
        System.out.println("Salário do vendedor2: " + vendedor2.getSalario());
        System.out.println("Compras efetuadas do vendedor gerente1: " + vendedorGerente1.getComprasEfetuadas());
        vendedorGerente2.acionarGerente("produto não encontrado");
        System.out.println("CNPJ da pessoaJuridica1: " + pessoaJuridica1.getCnpj());
        System.out.println("Nome da pessoaJuridica2: " + pessoaJuridica2.getNome());
        System.out.println("Produto da clienteEmpresa1: " + clienteEmpresa1.getProduto());
        clienteEmpresa2.pedidoAdiantamento("30/10/2024");
        fornecedor1.adiantarEntrega("02/11/2024");
        System.out.println("Proxima chegada do fornecedor2: " + fornecedor2.getProximaChegada());
    }
}
