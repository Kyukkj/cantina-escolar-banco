-- =========================================================
-- LIMPEZA (evita conflitos)
-- =========================================================

DROP TABLE IF EXISTS itens_venda;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS clientes;

-- =========================================================
-- CRIAÇÃO DAS TABELAS
-- =========================================================

CREATE TABLE clientes (
  id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL
);

CREATE TABLE produtos (
  id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  preco REAL NOT NULL
);

CREATE TABLE vendas (
  id INTEGER PRIMARY KEY,
  cliente_id INTEGER NOT NULL,
  data_venda TEXT NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_venda (
  id INTEGER PRIMARY KEY,
  venda_id INTEGER NOT NULL,
  produto_id INTEGER NOT NULL,
  quantidade INTEGER NOT NULL,
  FOREIGN KEY (venda_id) REFERENCES vendas(id),
  FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- =========================================================
-- INSERÇÃO DE DADOS
-- =========================================================

INSERT INTO clientes (id, nome) VALUES
(1, 'Ana Silva'),
(2, 'Bruno Santos'),
(3, 'Carlos Oliveira');

INSERT INTO produtos (id, nome, preco) VALUES
(1, 'Coxinha', 6.50),
(2, 'Suco Natural', 5.00),
(3, 'Sanduíche', 12.00),
(4, 'Refrigerante', 7.00),
(5, 'Chocolate', 4.50);

INSERT INTO vendas (id, cliente_id, data_venda) VALUES
(1, 1, '2025-11-20'),
(2, 2, '2025-11-21');

INSERT INTO itens_venda (id, venda_id, produto_id, quantidade) VALUES
(1, 1, 1, 2),
(2, 1, 2, 1),
(3, 2, 3, 1),
(4, 2, 4, 2);

-- =========================================================
-- ATUALIZAÇÕES
-- =========================================================

UPDATE produtos
SET preco = 13.50
WHERE id = 3;

UPDATE clientes
SET nome = 'Ana Maria Silva'
WHERE id = 1;

-- =========================================================
-- EXCLUSÃO
-- =========================================================

DELETE FROM itens_venda
WHERE id = 4;

-- =========================================================
-- CONSULTAS
-- =========================================================

-- 1. Listar todos os produtos
SELECT * FROM produtos;

-- 2. Produtos com preço maior que 10
SELECT * FROM produtos
WHERE preco > 10;

-- 3. Clientes pelo nome (LIKE)
SELECT * FROM clientes
WHERE nome LIKE '%Silva%';

-- 4. Vendas com nome do cliente
SELECT v.id AS venda_id, c.nome AS cliente, v.data_venda
FROM vendas v
JOIN clientes c ON v.cliente_id = c.id;

-- 5. Itens da venda com cliente, produto e quantidade
SELECT c.nome AS cliente,
       p.nome AS produto,
       iv.quantidade
FROM itens_venda iv
JOIN vendas v ON iv.venda_id = v.id
JOIN clientes c ON v.cliente_id = c.id
JOIN produtos p ON iv.produto_id = p.id;

-- =========================================================
-- COMPROVAÇÃO DO BANCO
-- =========================================================


SELECT version();

-- =========================================================
-- SEÇÃO: CONSIDERAÇÕES SOBRE O SQLITE
-- =========================================================
--
-- O banco de dados utilizado neste trabalho foi o SQLite,
-- um sistema gerenciador de banco de dados relacional leve,
-- embutido e amplamente utilizado em aplicações educacionais
-- e de pequeno porte.
--
-- O SQLite não utiliza servidor dedicado, funcionando de forma
-- local e simplificada, o que facilita a criação, execução e
-- testes de scripts SQL.
--
-- Neste script foram utilizados recursos compatíveis com o SQLite,
-- como:
-- - Criação de tabelas com PRIMARY KEY AUTOINCREMENT
-- - Restrições NOT NULL
-- - Chaves estrangeiras (FOREIGN KEY)
-- - Comandos INSERT, UPDATE e DELETE
-- - Consultas com JOIN entre múltiplas tabelas
--
-- Todas as instruções SQL presentes neste arquivo são compatíveis
-- com o padrão suportado pelo SQLite, garantindo a correta execução
-- do banco de dados no ambiente proposto.
--
-- =========================================================


