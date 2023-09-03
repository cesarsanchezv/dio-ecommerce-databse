-- criação de banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;
-- criar tabela cliente
create table clients(
			idClient int auto_increment primary key,
            Fname varchar(10),
            Minit char(3),
            Lname varchar(20),
            ClientCPF char(11) not null,
            BirthDate date,
            ClientStreet varchar(45),
            ClientSNumber varchar(10),
            ClientDistrict varchar(45),
            ClientCity varchar(45),
            ClientUFF char(2),
            constraint unique_cpf_client unique (ClientCPF)
);
-- criar tabela produto
create table product(
			idProduct int auto_increment primary key,
            PrName varchar(45) not null,
            PrCategory ENUM('Food','Drink','Other') default 'Food',
            Measure ENUM('Unit','Kilo','Liter') default 'Unit',
            UnPrice float,
            constraint unique_product_name unique (PrName)
);
-- criar tabela vendedor
create table seller(
			idSeller int auto_increment primary key,
            SellCNPJ char(14) not null,
            SNameSeller varchar(100) not null,
            FNameSeller varchar(100) not null,
            SellStreet varchar(45) not null,
            SellSNumber varchar(10) not null,
            SellDistrict varchar(45) not null,
            SellCity varchar(45) not null,
            SellUFF char(2) not null,
            constraint unique_social_name unique (SnameSeller),
            constraint unique_CNPJ unique (SellCNPJ)
);
-- criar tabela fornecedor
create table supplier(
			idSupplier int auto_increment primary key,
            SuppCNPJ char(14) not null,
            SNameSupplier varchar(100) not null,
            FNameSupplier varchar(100) not null,
            SuppStreet varchar(45) not null,
            SuppSNumber varchar(10) not null,
            SuppDistrict varchar(45) not null,
            SuppCity varchar(45) not null,
            SuppUFF char(2) not null,
            constraint supp_unique_social_name unique (SnameSupplier),
            constraint supp_unique_CNPJ unique (SuppCNPJ)
);
-- criar tabela estoque
create table warehouse(
			idWarehouse int auto_increment primary key,
            WHType ENUM('Dry','Refrigerated','Frozen') not null,
            WHDistrict varchar(45) not null,
            WHCity varchar(45) not null,
            WHUFF char(2) not null
            
);
-- criar tabela forma de pagamento
create table payment(
			idPayment int auto_increment primary key,
			pay_idCLient int,
			typePayment ENUM('Invoice', 'Debit', 'Credit', 'Cash') not null,
			limitAvailable float default 100,
			constraint fk_pay_client foreign key (pay_idClient) references clients(idClient)
);
-- criar tabela pedido
create table purchase_order(
			idPurchaseOrder int auto_increment primary key,
            idPurchaseClient int,
            PurchaseStatus ENUM('In progress','Processing','Sent','Delivered') default 'In progress',
            PurchaseDescription varchar(255),
            Fare float default 10,
            paymentInvoice bool default false,
            po_idPayment int,
            constraint fk_porder_payment foreign key (po_idPayment) references payment(idPayment),
            constraint fk_porder_client foreign key (idPurcHaseClient) references clients(idClient) 
);
-- criar tabela relação produto/pedido
create table ppo_relation(
			ppo_idProduct int,
            ppo_idClient int,
            PPOStatus ENUM('Available','Unavailable') not null,
            PPOQuantity float not null,
            primary key(ppo_idProduct, ppo_idClient),
            constraint fk_ppo_product foreign key (ppo_idProduct) references product(idProduct),
            constraint fk_ppo_clients foreign key (ppo_idClient) references clients(idClient)
);
-- criar relação produto tem estoque
create table prod_has_stock(
			phs_idProduct int,
            phs_idWarehouse int,
            phsQuantity float not null,
            primary key(phs_idProduct, phs_idWarehouse),
            constraint fk_phs_product foreign key (phs_idProduct) references product(idProduct),
            constraint fk_phs_warehouse foreign key (phs_idWarehouse) references warehouse(idWarehouse)
);
-- criar tabela produto por vendedor
create table prod_by_seller(
			pbs_idProduct int,
            pbs_idSeller int,
            pbsQuantity float not null,
            primary key(pbs_idProduct, pbs_idSeller),
            constraint fk_pbs_product foreign key (pbs_idProduct) references product(idProduct),
            constraint fk_pbs_seller foreign key (pbs_idSeller) references seller(idSeller)
);
-- criar tabela disponibilizando produto
create table providing_product(
			pp_idSupplier int,
            pp_idProduct int,
            constraint fk_pp_product foreign key (pp_idProduct) references product(idProduct),
            constraint fk_pp_supplier foreign key(pp_idSupplier) references supplier(idSupplier)

);

show tables;
select * from (purchase_order, ppo_relation);
desc clients;

-- Drop
drop database ecommerce;
drop table clients;
drop table product;
drop table seller;
drop table supplier;
drop table warehouse;
drop table payment;
drop table purchase_order;
drop table ppo_relation;
drop table prod_has_stock;
drop table prod_by_seller;
drop table providing_product;

INSERT INTO clients (Fname, Minit, Lname, ClientCPF, BirthDate, ClientStreet, ClientSNumber, ClientDistrict, ClientCity, ClientUFF)
VALUES
    ('João', 'A.', 'Silva', '12345678901', '1990-05-15', 'Rua das Flores','123', 'Bairro Alegre', 'São Paulo', 'SP'),
    ('Maria', 'B.', 'Santos', '23456789012', '1985-08-20', 'Avenida Central','456', 'Bairro Tranquilo', 'Rio de Janeiro', 'RJ'),
    ('Pedro', 'C.', 'Oliveira', '34567890123', '1992-03-10', 'Rua das Palmeiras','789', 'Bairro Verde', 'Belo Horizonte', 'MG'),
    ('Ana', 'D.', 'Pereira', '45678901234', '1980-12-05', 'Avenida dos Pássaros','101', 'Bairro Azul', 'Porto Alegre', 'RS'),
    ('Carlos', 'E.', 'Ferreira', '56789012345', '1988-06-25', 'Rua do Sol','222', 'Bairro Quente', 'Curitiba', 'PR'),
    ('Sandra', 'F.', 'Ribeiro', '67890123456', '1995-04-30', 'Avenida das Estrelas','333', 'Bairro Marítimo', 'Salvador', 'BA'),
    ('Fernando', 'G.', 'Martins', '78901234567', '1982-09-12', 'Rua da Lua','777', 'Bairro Noturno', 'Florianópolis', 'SC'),
    ('Mariana', 'H.', 'Almeida', '89012345678', '1991-11-03', 'Avenida das Rosas','888', 'Bairro das Flores', 'Fortaleza', 'CE'),
    ('Lucas', 'I.', 'Rodrigues', '90123456789', '1987-02-18', 'Rua das Árvores','444', 'Bairro Arborizado', 'Recife', 'PE'),
    ('Isabel', 'J.', 'Gonçalves', '01234567890', '1993-07-08', 'Avenida das Montanhas','555', 'Bairro Serrano', 'Brasília', 'DF');

INSERT INTO product (PrName, PrCategory, Measure, UnPrice)
VALUES
    ('Arroz', 'Food', 'Kilo', 5.99),
    ('Refrigerante', 'Drink', 'Liter', 3.49),
    ('Frango Assado', 'Food', 'Kilo', 8.75),
    ('Suco de Laranja', 'Drink', 'Liter', 2.99),
    ('Lasanha', 'Food', 'Kilo', 11.99),
    ('Cerveja', 'Drink', 'Liter', 4.99),
    ('Hamburguer', 'Food', 'Unit', 6.49),
    ('Água Mineral', 'Drink', 'Liter', 1.99),
    ('Caixa de Papelão', 'Other', 'Unit', 0.99),
    ('Garrafa Plástica', 'Other', 'Unit', 0.49);
    
INSERT INTO seller (SellCNPJ, SNameSeller, FNameSeller, SellStreet, SellSNumber, SellDistrict, SellCity, SellUFF)
VALUES
    ('12345678901234', 'Empresa ABC Ltda', 'ABC Ltda', 'Rua Comercial', '123', 'Centro', 'São Paulo', 'SP'),
    ('23456789012345', 'Empresa XYZ S.A.', 'XYZ S.A.', 'Avenida Principal', '456', 'Centro', 'Rio de Janeiro', 'RJ'),
    ('34567890123456', 'Comércio Rápido Ltda', 'Comércio Rápido', 'Rua das Vendas', '789', 'Centro', 'Belo Horizonte', 'MG'),
    ('45678901234567', 'Serviços Excelentes S.A.', 'Serviços Excelentes', 'Avenida das Oportunidades', '101', 'Centro', 'Porto Alegre', 'RS'),
    ('56789012345678', 'Vendas Online Ltda', 'Vendas Online', 'Rua do E-commerce', '222', 'Centro', 'Curitiba', 'PR'),
    ('67890123456789', 'Distribuição Eficiente S.A.', 'Distribuição Eficiente', 'Avenida Logística', '333', 'Centro', 'Salvador', 'BA'),
    ('78901234567890', 'Comércio Seguro Ltda', 'Comércio Seguro', 'Rua das Transações', '444', 'Centro', 'Fortaleza', 'CE'),
    ('89012345678901', 'Vendas Rápidas S.A.', 'Vendas Rápidas', 'Avenida das Vendas', '555', 'Centro', 'Recife', 'PE'),
    ('90123456789012', 'Distribuidora Eficiente Ltda', 'Distribuidora Eficiente', 'Rua das Distribuições', '666', 'Centro', 'Manaus', 'AM'),
    ('01234567890123', 'Comércio Global S.A.', 'Comércio Global', 'Avenida Global', '777', 'Centro', 'Brasília', 'DF');

INSERT INTO supplier (SuppCNPJ, SNameSupplier, FNameSupplier, SuppStreet, SuppSNumber, SuppDistrict, SuppCity, SuppUFF)
VALUES
    ('12345678901234', 'Fornecedor ABC Ltda', 'ABC Ltda', 'Rua Comercial', '123', 'Centro', 'São Paulo', 'SP'),
    ('23456789012345', 'Fornecedor XYZ S.A.', 'XYZ S.A.', 'Avenida Principal', '456', 'Centro', 'Rio de Janeiro', 'RJ'),
    ('34567890123456', 'Comércio Rápido Ltda', 'Comércio Rápido', 'Rua das Vendas', '789', 'Centro', 'Belo Horizonte', 'MG'),
    ('45678901234567', 'Serviços Excelentes S.A.', 'Serviços Excelentes', 'Avenida das Oportunidades', '101', 'Centro', 'Porto Alegre', 'RS'),
    ('56789012345678', 'Fornecedor de Peças Ltda', 'Peças Ltda', 'Rua do Fornecimento', '222', 'Centro', 'Curitiba', 'PR'),
    ('67890123456789', 'Distribuição Eficiente S.A.', 'Distribuição Eficiente', 'Avenida Logística', '333', 'Centro', 'Salvador', 'BA'),
    ('78901234567890', 'Fornecedora Segura Ltda', 'Segura Ltda', 'Rua das Transações', '444', 'Centro', 'Fortaleza', 'CE'),
    ('89012345678901', 'Fornecedor Global S.A.', 'Global S.A.', 'Avenida Global', '555', 'Centro', 'Recife', 'PE'),
    ('90123456789012', 'Distribuidora Eficiente Ltda', 'Distribuidora Eficiente', 'Rua das Distribuições', '666', 'Centro', 'Manaus', 'AM'),
    ('01234567890123', 'Comércio Global S.A.', 'Comércio Global', 'Avenida Global', '777', 'Centro', 'Brasília', 'DF');

INSERT INTO warehouse (WHType, WHDistrict, WHCity, WHUFF)
VALUES
    ('Dry', 'Bairro Tóquio', 'São Paulo', 'SP'),
    ('Refrigerated', 'Bairro Pequim', 'Curitiba', 'PR'),
    ('Frozen', 'Bairro Seul', 'Porto Alegre', 'RS'),
    ('Dry', 'Bairro Mumbai', 'Fortaleza', 'CE'),
    ('Refrigerated', 'Bairro Istambul', 'Belo Horizonte', 'MG');

-- Inserir 10 combinações válidas de dados na tabela 'payment' com referência aos clientes
INSERT INTO payment (pay_idClient, typePayment, limitAvailable)
VALUES
    (1, 'Invoice', 1000.00),
    (2, 'Debit', 500.00),
    (3, 'Credit', 800.00),
    (4, 'Cash', 300.00),
    (5, 'Invoice', 700.00),
    (6, 'Debit', 400.00),
    (7, 'Credit', 600.00),
    (8, 'Cash', 200.00),
    (9, 'Invoice', 900.00),
    (10, 'Debit', 100.00);

-- Inserir 10 combinações válidas de dados na tabela 'purchase_order' com referência aos clientes e pagamentos
INSERT INTO purchase_order (idPurchaseClient, PurchaseStatus, PurchaseDescription, Fare, paymentInvoice, po_idPayment)
VALUES
    (1, 'In progress', 'Pedido 1', 15.00, false, 1),
    (2, 'Processing', 'Pedido 2', 12.50, true, 2),
    (3, 'Sent', 'Pedido 3', 10.00, false, 3),
    (4, 'Delivered', 'Pedido 4', 8.50, true, 4),
    (5, 'In progress', 'Pedido 5', 15.00, false, 5),
    (6, 'Processing', 'Pedido 6', 12.50, true, 6),
    (7, 'Sent', 'Pedido 7', 10.00, false, 7),
    (8, 'Delivered', 'Pedido 8', 8.50, true, 8),
    (9, 'In progress', 'Pedido 9', 15.00, false, 9),
    (10, 'Processing', 'Pedido 10', 12.50, true, 10);

-- Inserir 10 combinações válidas de dados na tabela 'ppo_relation' com referência a produtos e clientes
INSERT INTO ppo_relation (ppo_idProduct, ppo_idClient, PPOStatus, PPOQuantity)
VALUES
    (1, 1, 'Available', 5000),
    (2, 2, 'Available', 3000),
    (3, 3, 'Unavailable', 2000),
    (4, 4, 'Available', 6000),
    (5, 5, 'Available', 4000),
    (6, 6, 'Unavailable', 1000),
    (7, 7, 'Available', 7000),
    (8, 8, 'Available', 2000),
    (9, 9, 'Unavailable', 3000),
    (10, 10, 'Available', 8000);

-- Inserir 10 combinações válidas de dados na tabela 'prod_has_stock' com referência a produtos e estoques
INSERT INTO prod_has_stock (phs_idProduct, phs_idWarehouse, phsQuantity)
VALUES
    (1, 1, 10000),
    (2, 2, 5000),
    (3, 3, 7500),
    (4, 4, 12000),
    (5, 5, 6000),
    (6, 1, 3000),
    (7, 2, 4500),
    (8, 3, 5500),
    (9, 4, 9000),
    (10, 5, 4000);

-- Inserir 10 combinações válidas de dados na tabela 'prod_by_seller' com referência a produtos e vendedores
INSERT INTO prod_by_seller (pbs_idProduct, pbs_idSeller, pbsQuantity)
VALUES
    (1, 1, 20),
    (2, 2, 15),
    (3, 3, 25),
    (4, 4, 18),
    (5, 5, 22),
    (6, 6, 10),
    (7, 7, 30),
    (8, 8, 12),
    (9, 9, 28),
    (10, 10, 14),
    (1, 2, 22),
    (2, 3, 17),
    (3, 4, 27),
    (4, 5, 20),
    (5, 6, 24),
    (6, 7, 12),
    (7, 8, 35),
    (8, 9, 15),
    (9, 10, 32),
    (10, 1, 16),
    (1, 3, 26),
    (2, 4, 20),
    (3, 5, 30),
    (4, 6, 22),
    (5, 7, 28),
    (6, 8, 14),
    (7, 9, 40),
    (8, 10, 18),
    (9, 1, 34),
    (10, 2, 12);
  
-- Inserir 10 combinações válidas de dados na tabela 'providing_product' com referência a produtos e fornecedores
INSERT INTO providing_product (pp_idProduct, pp_idSupplier)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (1, 2),
    (2, 3),
    (3, 4),
    (4, 5),
    (5, 6),
    (6, 7),
    (7, 8),
    (8, 9),
    (9, 10),
    (10, 1),
    (1, 3),
    (2, 4),
    (3, 5),
    (4, 6),
    (5, 7),
    (6, 8),
    (7, 9),
    (8, 10),
    (9, 1),
    (10, 2);

-- PERGUNTAS E RESPOSTAS

-- número de clientes:
SELECT count(*) FROM clients;

-- pedidos feitos pelos clientes
SELECT * FROM clients c, purchase_order o WHERE c.idCLient = idPurchaseClient;

-- selecionando apenas alguns atributos
SELECT concat(Fname,'', Lname) AS Client, idPurchaseOrder AS Purchase_Order, PurchaseStatus AS Purchase_Status FROM clients c, purchase_order o WHERE c.idCLient = idPurchaseClient;

-- Qual é o status dos pedidos dos clientes?
SELECT concat(c.Fname,' ',c.Lname) AS NomeCliente, po.idPurchaseOrder, po.PurchaseDescription, po.PurchaseStatus
FROM purchase_order po
JOIN clients c ON po.idPurchaseClient = c.idClient;

-- Quantos produtos tem em cada estoque?
SELECT p.PrName AS Product, phs.phsQuantity AS Quantity, p.Measure, w.WHType AS 'Warehouse Type', concat(w.WHDistrict,', ', w.WHCity,'/',w.WHUFF) AS Locals
FROM prod_has_stock phs
INNER JOIN product p ON phs.phs_idProduct = p.idProduct
INNER JOIN warehouse w ON phs.phs_idWarehouse = w.idWarehouse
ORDER BY phs.phsQuantity DESC;

-- Categorize os produtos de acordo com o preço unitário
SELECT PrName, UnPrice,
    CASE
        WHEN UnPrice < 2.00 THEN 'Cheap'
        WHEN UnPrice >= 2.00 AND UnPrice < 5.00 THEN 'Average'
        WHEN UnPrice >= 5.00 THEN 'Expensive'
    END AS Rating
FROM product
ORDER BY UnPrice;

-- Calcule o total de vendas de cada categoria de produto
SELECT
    PrCategory AS Category,
    TRUNCATE(SUM(PPOQuantity), 2) AS Total_Quantity,
    TRUNCATE(SUM(PPOQuantity * UnPrice), 2) AS Total_Value
FROM
    ppo_relation
JOIN
    product ON ppo_relation.ppo_idProduct = product.idProduct
GROUP BY
    PrCategory;
    
    -- Calcular o valor total dos pedidos de um cliente específico
SELECT
    CONCAT(c.Fname,' ',c.Lname) AS Clients,
    TRUNCATE(SUM(po.Fare + (ppo.PPOQuantity * p.UnPrice)), 2) AS Total_Cost
FROM
    clients c
LEFT JOIN
    purchase_order po ON c.idClient = po.idPurchaseClient
LEFT JOIN
    ppo_relation ppo ON po.idPurchaseOrder = ppo.ppo_idClient
LEFT JOIN
    product p ON ppo.ppo_idProduct = p.idProduct
WHERE
    c.Fname = 'Fernando' AND c.Lname = 'Martins'
GROUP BY
    c.idClient;
    
-- Quantos fornecedores tem mais de 20 itens disponíveis para entrega?
SELECT s.SNameSupplier AS Supplier, COUNT(pp.pp_idProduct) AS Available_Products
FROM supplier s
LEFT JOIN providing_product pp ON s.idSupplier = pp.pp_idSupplier
GROUP BY s.SNameSupplier
HAVING Available_Products > 2;


