-- ============================================
-- DDL - MANUTENÇÃO DE EQUIPAMENTOS
-- ============================================

DROP DATABASE IF EXISTS manutencao_equipamentos;

CREATE DATABASE manutencao_equipamentos;

USE manutencao_equipamentos;

-- ============================================
-- TABELA EQUIPAMENTO
-- ============================================

CREATE TABLE equipamento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    numero_serie VARCHAR(50) UNIQUE,
    data_aquisicao DATE,
    status VARCHAR(30),
    setor VARCHAR(50),
    valor_aquisicao DECIMAL(10,2)
);

-- ============================================
-- TABELA TECNICO
-- ============================================

CREATE TABLE tecnico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

-- ============================================
-- TABELA PECA
-- ============================================

CREATE TABLE peca (
    id_peca INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    quantidade_estoque INT NOT NULL,
    estoque_minimo INT NOT NULL,
    preco DECIMAL(10,2)
);

-- ============================================
-- TABELA ORDEM DE MANUTENCAO
-- ============================================

CREATE TABLE ordem_manutencao (
    id_ordem INT PRIMARY KEY AUTO_INCREMENT,
    id_equipamento INT NOT NULL,
    tipo VARCHAR(50),
    descricao VARCHAR(255),
    data_abertura DATE,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(30),
    prioridade VARCHAR(20),

    CONSTRAINT fk_ordem_equipamento
        FOREIGN KEY (id_equipamento)
        REFERENCES equipamento(id)
);

-- ============================================
-- TABELA MANUTENCAO
-- ============================================

CREATE TABLE manutencao (
    id_manutencao INT PRIMARY KEY AUTO_INCREMENT,
    id_ordem INT NOT NULL,
    id_tecnico INT NOT NULL,
    descricao_servico VARCHAR(255),
    data_execucao DATE,
    horas_trabalhadas DECIMAL(5,2),
    observacoes VARCHAR(255),

    CONSTRAINT fk_manutencao_ordem
        FOREIGN KEY (id_ordem)
        REFERENCES ordem_manutencao(id_ordem),

    CONSTRAINT fk_manutencao_tecnico
        FOREIGN KEY (id_tecnico)
        REFERENCES tecnico(id)
);

-- ============================================
-- TABELA PECA DA MANUTENCAO
-- ============================================

CREATE TABLE peca_manutencao (
    id_manutencao INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,

    PRIMARY KEY (id_manutencao, id_peca),

    CONSTRAINT fk_peca_manutencao_manutencao
        FOREIGN KEY (id_manutencao)
        REFERENCES manutencao(id_manutencao),

    CONSTRAINT fk_peca_manutencao_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca)
);