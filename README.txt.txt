
# 🖥🍔 SISTEMA DE E-COMMERCE
## Construindo seu primeiro projeto lógico de Banco de Dados

## Modelo EER

A imagem ecommerce.png descreve o modelo EER do banco de dados, contendo as relações Clients, Product, Payment, Seller, Supplier, Warehouse e Purchase Order e as relações entre estas, Product has Stock, Product /PO Relation, Product by Seller e Providing Product.

## Queries Solicitadas

Para cada tabela foi inserido um conjunto consolidado de dados respeitando as caraterísticas de cada um dos atributos definidos no escopo. As queries às quais se dá resposta no projeto são as seguintes:

1.  Qual é o número de clientes?

        SELECT count(*) FROM clients;

2. Quais os pedidos feitos pelos clientes?

        SELECT * FROM clients c, purchase_order o WHERE c.idCLient = idPurchaseClient;

3. Quais os pedidos feitos pelos clientes? Filtrando, concatenando e determinando Alias.

        SELECT concat(Fname,'', Lname) AS Client, idPurchaseOrder AS Purchase_Order, PurchaseStatus AS Purchase_Status FROM clients c, purchase_order o WHERE c.idCLient = idPurchaseClient;

4. Qual é o status dos pedidos dos clientes?

        SELECT concat(c.Fname,' ',c.Lname) AS NomeCliente, po.idPurchaseOrder, po.PurchaseDescription, po.PurchaseStatus
        FROM purchase_order po
        JOIN clients c ON po.idPurchaseClient = c.idClient;

5. Quantos produtos tem em cada estoque?

        SELECT p.PrName AS Product, phs.phsQuantity AS Quantity, p.Measure, w.WHType AS 'Warehouse Type', concat(w.WHDistrict,', ', w.WHCity,'/',w.WHUFF) AS Locals
        FROM prod_has_stock phs
        INNER JOIN product p ON phs.phs_idProduct = p.idProduct
        INNER JOIN warehouse w ON phs.phs_idWarehouse = w.idWarehouse
        ORDER BY phs.phsQuantity DESC;

6. Categorize os produtos de acordo com o preço unitário

        SELECT PrName, UnPrice,
            CASE
                WHEN UnPrice < 2.00 THEN 'Cheap'
                WHEN UnPrice >= 2.00 AND UnPrice < 5.00 THEN 'Average'
                WHEN UnPrice >= 5.00 THEN 'Expensive'
            END AS Rating
        FROM product
        ORDER BY UnPrice;

7. Calcule o total de vendas de cada categoria de produto

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
    
    
8.  Calcular o valor total dos pedidos de um cliente específico

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
    
9. Quantos fornecedores tem mais de 2 itens disponíveis para entrega?

        SELECT s.SNameSupplier AS Supplier, COUNT(pp.pp_idProduct) AS Available_Products
        FROM supplier s
        LEFT JOIN providing_product pp ON s.idSupplier = pp.pp_idSupplier
        GROUP BY s.SNameSupplier
        HAVING Available_Products > 2;


