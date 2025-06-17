CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;
-- DDL (Data Definition Language) para criar o esquema conceitual da Oficina Mecânica

-- Tabela Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT, -- Ou SERIAL para PostgreSQL, IDENTITY para SQL Server
    nome_cliente VARCHAR(100) NOT NULL,
    endereco_cliente VARCHAR(255),
    telefone_cliente VARCHAR(20),
    email_cliente VARCHAR(100) UNIQUE
);

-- Tabela Veiculos
CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa_veiculo VARCHAR(10) UNIQUE NOT NULL,
    marca_veiculo VARCHAR(50) NOT NULL,
    modelo_veiculo VARCHAR(50) NOT NULL,
    ano_veiculo INT,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabela Mecanicos
CREATE TABLE Mecanicos (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome_mecanico VARCHAR(100) NOT NULL,
    endereco_mecanico VARCHAR(255),
    especialidade_mecanico VARCHAR(100)
);

-- Tabela Ordens_Servico
CREATE TABLE Ordens_Servico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_emissao_os DATE NOT NULL,
    data_conclusao_os DATE,
    valor_total_os DECIMAL(10, 2),
    status_os VARCHAR(50) NOT NULL DEFAULT 'Aberta', -- Ex: 'Aberta', 'Em Andamento', 'Aguardando Aprovação', 'Concluída', 'Cancelada'
    aprovacao_cliente BOOLEAN DEFAULT FALSE,
    id_veiculo INT NOT NULL,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);

-- Tabela Servicos
CREATE TABLE Servicos (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao_servico VARCHAR(255) NOT NULL,
    valor_mao_de_obra DECIMAL(10, 2) NOT NULL
);

-- Tabela Pecas
CREATE TABLE Pecas (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome_peca VARCHAR(100) NOT NULL,
    valor_unitario_peca DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT DEFAULT 0
);

-- Tabela Associativa OS_Mecanico (para relacionamento N:M entre Ordens_Servico e Mecanicos)
CREATE TABLE OS_Mecanico (
    id_os_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    id_os INT NOT NULL,
    id_mecanico INT NOT NULL,
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanicos(id_mecanico),
    UNIQUE (id_os, id_mecanico) -- Garante que um mecânico não seja associado duas vezes à mesma OS
);

-- Tabela Associativa OS_Servico (para relacionamento N:M entre Ordens_Servico e Servicos)
CREATE TABLE OS_Servico (
    id_os_servico INT PRIMARY KEY AUTO_INCREMENT,
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    valor_servico_executado DECIMAL(10, 2) NOT NULL, -- Valor do serviço específico na OS
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico),
    UNIQUE (id_os, id_servico)
);

-- Tabela Associativa OS_Peca (para relacionamento N:M entre Ordens_Servico e Pecas)
CREATE TABLE OS_Peca (
    id_os_peca INT PRIMARY KEY AUTO_INCREMENT,
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade_peca INT NOT NULL, -- Quantidade de peças usadas na OS
    FOREIGN KEY (id_os) REFERENCES Ordens_Servico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Pecas(id_peca),
    UNIQUE (id_os, id_peca)
);