# projeto-oficina-mecanica
# Esquema Conceitual - Sistema de Gerenciamento de Ordens de Serviço (Oficina Mecânica)

## Contexto do Projeto

Este projeto consiste na criação de um esquema conceitual para um sistema de controle e gerenciamento de ordens de serviço em uma oficina mecânica. O objetivo é modelar as entidades, atributos e relacionamentos essenciais para a gestão das operações, desde a entrada de veículos até a conclusão dos serviços.

A narrativa base para este esquema conceitual foi:

"Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões periódicas. Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega. A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra. O valor de cada peça também irá compor a OS. O cliente autoriza a execução dos serviços. A mesma equipe avalia e executa os serviços. Os mecânicos possuem código, nome, endereço e especialidade. Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos."

## Esquema Conceitual

[Aqui você pode inserir o diagrama textual ou, se preferir, um link para uma imagem do diagrama feito em alguma ferramenta.]

### Entidades e Atributos

* **Cliente:**
    * `id_cliente` (Chave Primária)
    * `nome_cliente`
    * `endereco_cliente`
    * `telefone_cliente`
    * `email_cliente`
* **Veículo:**
    * `id_veiculo` (Chave Primária)
    * `placa_veiculo` (Chave Única)
    * `marca_veiculo`
    * `modelo_veículo`
    * `ano_veiculo`
    * `id_cliente` (Chave Estrangeira para Cliente)
* **Mecânico:**
    * `id_mecanico` (Chave Primária)
    * `nome_mecanico`
    * `endereco_mecanico`
    * `especialidade_mecanico`
* **Ordem_Serviço (OS):**
    * `id_os` (Chave Primária)
    * `data_emissao_os`
    * `data_conclusao_os`
    * `valor_total_os`
    * `status_os`
    * `aprovacao_cliente`
    * `id_veiculo` (Chave Estrangeira para Veículo)
* **Serviço:**
    * `id_servico` (Chave Primária)
    * `descricao_servico`
    * `valor_mao_de_obra`
* **Peça:**
    * `id_peca` (Chave Primária)
    * `nome_peca`
    * `valor_unitario_peca`
    * `quantidade_estoque`

### Relacionamentos

* **Cliente - Veículo:** Um Cliente pode possuir N Veículos (1:N).
* **Veículo - Ordem_Serviço:** Um Veículo pode ter N Ordens de Serviço (1:N).
* **Ordem_Serviço - Mecânico:** Uma Ordem de Serviço pode ser executada por N Mecânicos, e um Mecânico pode trabalhar em N Ordens de Serviço (N:M).
    * Tabela Associativa: `OS_Mecanico` (`id_os`, `id_mecanico`)
* **Ordem_Serviço - Serviço:** Uma Ordem de Serviço pode conter N Serviços, e um Serviço pode estar em N Ordens de Serviço (N:M).
    * Tabela Associativa: `OS_Servico` (`id_os`, `id_servico`, `valor_servico_executado`)
* **Ordem_Serviço - Peça:** Uma Ordem de Serviço pode utilizar N Peças, e uma Peça pode ser utilizada em N Ordens de Serviço (N:M).
    * Tabela Associativa: `OS_Peca` (`id_os`, `id_peca`, `quantidade_peca`)


Durante a criação deste esquema conceitual, algumas decisões foram tomadas para complementar a narrativa fornecida, visando uma modelagem mais robusta e funcional. Seguem as justificativas:

* **Atributos para Cliente:** Adicionados `telefone_cliente` e `email_cliente` para facilitar a comunicação com o cliente.
* **Atributo para Peça:** Incluído `quantidade_estoque` na entidade `Peça` para permitir o controle de inventário, algo comum e importante em uma oficina.
* **Atributo para Ordem de Serviço:** Adicionado `aprovacao_cliente` como um booleano para representar a autorização mencionada na narrativa, crucial para o fluxo de trabalho.
* **Tabelas Associativas:** Foram criadas tabelas associativas (`OS_Mecanico`, `OS_Servico`, `OS_Peca`) para modelar os relacionamentos N:M, que são essenciais para representar que várias entidades se relacionam entre si em ambas as direções.
    * Para `OS_Servico` e `OS_Peca`, foram adicionados atributos (`valor_servico_executado` e `quantidade_peca`, respectivamente) para registrar detalhes específicos daquele relacionamento na OS (o valor do serviço naquele momento, a quantidade de peças usadas), que podem variar e não são apenas atributos da entidade `Serviço` ou `Peça` em si.

---
