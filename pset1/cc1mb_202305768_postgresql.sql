
-- Michel Gonçalves Salles
-- CC1MB


-- Excluir o banco de dados uvv  caso já exista, e excluir o usuário michel caso já exista
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS michel;


-- Criar o usuário michel com senha criptografada
CREATE USER michel 
CREATEDB CREATEROLE 
ENCRYPTED PASSWORD 'NeverGonnaGiveYouUp!';


-- Criar o banco de dados uvv com os parâmetros
CREATE 	DATABASE uvv 
WITH 	OWNER michel
		TEMPLATE template0
		ENCODING 'UTF8'
		LC_COLLATE 'pt_BR.UTF-8'
		LC_CTYPE 'pt_BR.UTF-8'
		ALLOW_CONNECTIONS TRUE;

	
-- Dar todos os privilégios para o usuário michel
GRANT ALL PRIVILEGES ON DATABASE uvv TO michel;


-- Script para conectar-se ao banco de dados sem digitar a senha
\c 'dbname=uvv user=michel password=NeverGonnaGiveYouUp!'


-- Criar um SCHEMA e dar autorização para o usuário michel.
CREATE SCHEMA lojas 
AUTHORIZATION michel;


-- Coloca o SCHEMA lojas na primeira ordem para o usuário michel
ALTER USER michel
SET SEARCH_PATH TO lojas, "user", public;


-- Criar a tabela produtos
CREATE TABLE 	lojas.produtos (
                produto_id 					NUMERIC(38) 		NOT NULL,
                nome 						VARCHAR(255) 		NOT NULL,
                preco_unitario 				NUMERIC(10,2),
                detalhes 					BYTEA,
                imagem 						BYTEA,
                imagem_mime_type 			VARCHAR(512),
                imagem_arquivo 				VARCHAR(512),
                imagem_charset 				VARCHAR(512),
                imagem_ultima_atualizacao 	DATE);


-- Criar as chaves da tabela produtos
ALTER TABLE 	lojas.produtos
ADD CONSTRAINT 	produtos_pk
PRIMARY KEY 	(produto_id);


-- Criar comentário referente a tabela produtos e criar comentários referente as colunas da tabela produtos
COMMENT ON TABLE  lojas.produtos 							IS 	'Tabela com as informações dos produtos.';
COMMENT ON COLUMN lojas.produtos.produto_id 				IS 	'Chave Primária (PK) da tabela produtos. Número do id de identificação do produto.';
COMMENT ON COLUMN lojas.produtos.nome 						IS 	'Nome do produto.';
COMMENT ON COLUMN lojas.produtos.preco_unitario 			IS 	'Preço unitário do produto.';
COMMENT ON COLUMN lojas.produtos.detalhes 					IS 	'Detalhes do produto.';
COMMENT ON COLUMN lojas.produtos.imagem 					IS 	'Imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type 			IS 	'MIME-type da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo 			IS 	'Tipo de arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_charset 			IS 	'Tipo de codificação dos caracteres do arquivo da imagem do produto.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao 	IS  'Data da última atualização do arquivo da imagem do produto.';


-- Criar as restrições de checagem para a tabela produtos
ALTER TABLE 	lojas.produtos
ADD CONSTRAINT 	check_produtos_produto_id
CHECK 			(produto_id > 0);

ALTER TABLE 	lojas.produtos
ADD CONSTRAINT 	check_produtos_preco_unitario
CHECK 			(preco_unitario >= 0);

ALTER TABLE 	lojas.produtos
ADD CONSTRAINT 	check_produtos_imagem_charset
CHECK 			(imagem_charset IN ('UTF-8','UTF-16','UTF-32'));


-- Criar a tabela lojas
CREATE TABLE 	lojas.lojas (
                loja_id 					NUMERIC(38) 	NOT NULL,
                nome 						VARCHAR(255) 	NOT NULL,
                endereco_web 				VARCHAR(100),
                endereco_fisico 			VARCHAR(512),
                latitude 					NUMERIC,
                longitude 					NUMERIC,
                logo 						BYTEA,
                logo_mime_type 				VARCHAR(512),
                logo_arquivo 				VARCHAR(512),
                logo_charset 				VARCHAR(512),
                logo_ultima_atualizacao 	DATE);


-- Criar as chaves da tabela lojas
ALTER TABLE 	lojas.lojas
ADD CONSTRAINT 	lojas_pk
PRIMARY KEY 	(loja_id);


-- Criar comentário referente a tabela lojas e criar comentários referente as colunas da tabela lojas
COMMENT ON TABLE  lojas.lojas 							IS 	'Tabela com as informações das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id 					IS 	'Chave Primária (PK) da tabela lojas. Número do id de identificação da loja.';
COMMENT ON COLUMN lojas.lojas.nome					 	IS 	'Nome da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_web 				IS 	'Endereço web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico 			IS 	'Endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude 					IS 	'Número da latitude da localização do endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.longitude 				IS 	'Número da longitude da localização do endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.logo 						IS 	'Logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type 			IS 	'MIME-type da imagem da loja.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo 				IS 	'Tipo de arquivo da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_charset 				IS 	'Tipo de codificação dos caracteres do arquivo da logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao 	IS 	'Data da última atualização do arquivo da logo da loja.';


-- Criar as restrições de checagem para a tabela lojas
ALTER TABLE 	lojas.lojas
ADD CONSTRAINT 	check_lojas_endereco_fisico_or_web
CHECK 			(endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

ALTER TABLE 	lojas.lojas
ADD CONSTRAINT 	check_lojas_loja_id
CHECK 			(loja_id > 0);

ALTER TABLE 	lojas.lojas
ADD CONSTRAINT 	check_lojas_logo_charset
CHECK 			(logo_charset IN ('UTF-8','UTF-16','UTF-32'));


-- Criar a tabela estoques
CREATE TABLE 	lojas.estoques (
                estoque_id 		NUMERIC(38) 	NOT NULL,
                loja_id 		NUMERIC(38) 	NOT NULL,
                produto_id 		NUMERIC(38) 	NOT NULL,
                quantidade 		NUMERIC(38) 	NOT NULL);


-- Criar as chaves da tabela estoques
ALTER TABLE 	lojas.estoques
ADD CONSTRAINT 	estoques_pk
PRIMARY KEY 	(estoque_id);


-- Criar comentário referente a tabela estoques e criar comentários referente as colunas da tabela estoques
COMMENT ON TABLE  lojas.estoques 				IS 	'Tabela com as informações dos estoques.';
COMMENT ON COLUMN lojas.estoques.estoque_id 	IS 	'Chave Primária (PK) da tabela estoques. Número do id de identificação do estoque.';
COMMENT ON COLUMN lojas.estoques.loja_id 		IS 	'Chave Estrangeira (FK) da Chave Primária (PK) loja_id da tabela lojas. Número do id de identificação da loja.';
COMMENT ON COLUMN lojas.estoques.produto_id 	IS 	'Chave Estrangeira (FK) da Chave Primária (PK) produto_id da tabela produtos. Número do id de identificação do produto.';
COMMENT ON COLUMN lojas.estoques.quantidade 	IS 	'Quantidade de determinado produto.';


-- Criar as relações referente a tabela estoques
ALTER TABLE 	lojas.estoques 
ADD CONSTRAINT 	produtos_estoques_fk
FOREIGN KEY 	(produto_id)
REFERENCES 		lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 	lojas.estoques 
ADD CONSTRAINT 	lojas_estoques_fk
FOREIGN KEY 	(loja_id)
REFERENCES 		lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Criar as restrições de checagem para a tabela estoques
ALTER TABLE 	lojas.estoques
ADD CONSTRAINT 	check_estoques_estoque_id
CHECK 			(estoque_id > 0);

ALTER TABLE 	lojas.estoques
ADD CONSTRAINT 	check_estoques_quantidade
CHECK 			(quantidade >= 0);


-- Criar a tabela clientes
CREATE TABLE 	lojas.clientes (
                cliente_id 	NUMERIC(38) 	NOT NULL,
                email 		VARCHAR(255) 	NOT NULL,
                nome 		VARCHAR(255) 	NOT NULL,
                telefone1 	VARCHAR(20),
                telefone2 	VARCHAR(20),
                telefone3 	VARCHAR(20));


-- Criar as chaves da tabela clientes
ALTER TABLE 	lojas.clientes
ADD CONSTRAINT 	clientes_pk
PRIMARY KEY 	(cliente_id);


-- Criar comentário referente a tabela clientes e criar comentários referente as colunas da tabela clientes
COMMENT ON TABLE  lojas.clientes 				IS 	'Tabela com as informações dos clientes.';
COMMENT ON COLUMN lojas.clientes.cliente_id 	IS 	'Chave Primária (PK) da tabela clientes. Número do id de identificação do cliente.';
COMMENT ON COLUMN lojas.clientes.email 			IS 	'endereço de email do cliente.';
COMMENT ON COLUMN lojas.clientes.nome 			IS 	'Nome completo do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 		IS 	'1º telefone para contato do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 		IS 	'2º telefone para contato do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 		IS 	'3º telefone para contato do cliente.';


-- Criar as restrições de checagem para a tabela clientes
ALTER TABLE 	lojas.clientes
ADD CONSTRAINT 	check_clientes_cliente_id
CHECK 			(cliente_id > 0);

ALTER TABLE 	lojas.clientes
ADD CONSTRAINT 	check_clientes_email
CHECK 			(email ~ '^.+@.+\.com$');

ALTER TABLE 	lojas.clientes
ADD CONSTRAINT 	check_clientes_nome
CHECK 			(nome ~ '^\w+\s\w+');


-- Criar a tabela envios
CREATE TABLE 	lojas.envios (
                envio_id 			NUMERIC(38) 	NOT NULL,
                loja_id 			NUMERIC(38) 	NOT NULL,
                cliente_id 			NUMERIC(38) 	NOT NULL,
                endereco_entrega 	VARCHAR(512) 	NOT NULL,
                status 				VARCHAR(15) 	NOT NULL);


-- Criar as chaves da tabela envios
ALTER TABLE 	lojas.envios
ADD CONSTRAINT 	envios_pk
PRIMARY KEY 	(envio_id);


-- Criar comentário referente a tabela envios e criar comentários referente as colunas da tabela envios
COMMENT ON TABLE  lojas.envios 						IS 	'Tabela com as informações dos envios.';
COMMENT ON COLUMN lojas.envios.envio_id 			IS 	'Chave Primária (PK) da tabela envios. Número do id de identificação do envio.';
COMMENT ON COLUMN lojas.envios.loja_id 				IS 	'Chave Estrangeira (FK) da Chave Primária (PK) loja_id da tabela lojas. Número do id de identificação da loja.';
COMMENT ON COLUMN lojas.envios.cliente_id 			IS 	'Chave Estrangeira (FK) da Chave Primária (PK) cliente_id da tabela clientes. Número do id de identificação do cliente.';
COMMENT ON COLUMN lojas.envios.endereco_entrega 	IS 	'Endereço de entrega do envio.';
COMMENT ON COLUMN lojas.envios.status 				IS 	'Status da entrega do envio.';


-- Criar as relações referente a tabela envios
ALTER TABLE 	lojas.envios 
ADD CONSTRAINT 	lojas_envios_fk
FOREIGN KEY 	(loja_id)
REFERENCES 		lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 	lojas.envios 
ADD CONSTRAINT 	clientes_envios_fk
FOREIGN KEY 	(cliente_id)
REFERENCES 		lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Criar as restrições de checagem para a tabela envios
ALTER TABLE 	lojas.envios
ADD CONSTRAINT 	check_envios_status
CHECK 			(status IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));

ALTER TABLE 	lojas.envios
ADD CONSTRAINT 	check_envios_envio_id
CHECK 			(envio_id > 0);


-- Criar a tabela pedidos
CREATE TABLE 	lojas.pedidos (
                pedido_id 		NUMERIC(38) 	NOT NULL,
                data_hora 		TIMESTAMP 		NOT NULL,
                cliente_id 		NUMERIC(38) 	NOT NULL,
                status 			VARCHAR(15) 	NOT NULL,
                loja_id 		NUMERIC(38) 	NOT NULL);


-- Criar as chaves da tabela pedidos
ALTER TABLE 	lojas.pedidos
ADD CONSTRAINT 	pedidos_pk
PRIMARY KEY 	(pedido_id);


-- Criar comentário referente a tabela pedidos e criar comentários referente as colunas da tabela pedidos
COMMENT ON TABLE  lojas.pedidos 				IS 	'Tabela com as informações dos pedidos.';
COMMENT ON COLUMN lojas.pedidos.pedido_id 		IS 	'Chave Primária (PK) da tabela pedidos. Número do id de identificação do pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora 		IS 	'data e hora de registro do pedido.';
COMMENT ON COLUMN lojas.pedidos.cliente_id 		IS 	'Chave Estrangeira (FK) da Chave Primária (PK) cliente_id da tabela clientes. Número do id de identificação do cliente.';
COMMENT ON COLUMN lojas.pedidos.status 			IS 	'Status do pedido do cliente.';
COMMENT ON COLUMN lojas.pedidos.loja_id 		IS 	'Chave Estrangeira (FK) da Chave Primária (PK) loja_id da tabela lojas. Número do id de identificação da loja.';


-- Criar as relações referente a tabela pedidos
ALTER TABLE 	lojas.pedidos 
ADD CONSTRAINT 	lojas_pedidos_fk
FOREIGN KEY 	(loja_id)
REFERENCES 		lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 	lojas.pedidos 
ADD CONSTRAINT 	clientes_pedidos_fk
FOREIGN KEY 	(cliente_id)
REFERENCES 		lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Criar as restrições de checagem para a tabela pedidos
ALTER TABLE 	lojas.pedidos
ADD CONSTRAINT 	check_pedidos_status
CHECK 			(status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

ALTER TABLE 	lojas.pedidos
ADD CONSTRAINT 	check_pedidos_pedido_id
CHECK 			(pedido_id > 0);


-- Criar a tabela pedidos_itens
CREATE TABLE 	lojas.pedidos_itens (
                pedido_id 			NUMERIC(38) 	NOT NULL,
                produto_id 			NUMERIC(38) 	NOT NULL,
                numero_da_linha 	NUMERIC(38) 	NOT NULL,
                preco_unitario 		NUMERIC(10,2) 	NOT NULL,
                quantidade 			NUMERIC(38) 	NOT NULL,
                envio_id 			NUMERIC(38));


-- Criar as chaves da tabela pedidos_itens
ALTER TABLE 	lojas.pedidos_itens
ADD CONSTRAINT 	pedidos_itens_pk
PRIMARY KEY 	(pedido_id, produto_id);


-- Criar comentário referente a tabela pedidos_itens e criar comentários referente as colunas da tabela pedidos_itens
COMMENT ON TABLE  lojas.pedidos_itens 					IS 	'Tabela com as informações sobre os itens dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id 		IS 	'Número do id de identificação do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id 		IS 	'Número do id de identificação do produto.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha 	IS 	'Número da linha do item de um pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario 	IS 	'Preço unitário do produto.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade 		IS 	'Quantidade de um determinado produto.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id 			IS 	'Chave Estrangeira (FK) da Chave Primária (PK) envio_id da tabela envios. Número do id de identificação do envio.';


-- Criar as relações referente a tabela pedidos_itens
ALTER TABLE 	lojas.pedidos_itens 
ADD CONSTRAINT 	produtos_pedidos_itens_fk
FOREIGN KEY 	(produto_id)
REFERENCES 		lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 	lojas.pedidos_itens 
ADD CONSTRAINT 	envios_pedidos_itens_fk
FOREIGN KEY 	(envio_id)
REFERENCES 		lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 	lojas.pedidos_itens 
ADD CONSTRAINT 	pedidos_pedidos_itens_fk
FOREIGN KEY 	(pedido_id)
REFERENCES 		lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- Criar as restrições de checagem para a tabela pedidos_itens
ALTER TABLE 	lojas.pedidos_itens
ADD CONSTRAINT 	check_pedidos_itens_numero_da_linha
CHECK 			(numero_da_linha > 0);

ALTER TABLE 	lojas.pedidos_itens
ADD CONSTRAINT 	check_pedidos_itens_preco_unitario
CHECK 			(preco_unitario > 0);

ALTER TABLE 	lojas.pedidos_itens
ADD CONSTRAINT 	check_pedidos_itens_quantidade
CHECK 			(quantidade >= 0);

