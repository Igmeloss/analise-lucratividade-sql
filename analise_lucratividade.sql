-- ============================================================
--  ANÁLISE DE LUCRATIVIDADE DE VENDAS — 2024
--  Autor: Igor Leonardo dos Santos Silva
--  Ferramenta: SQLiteOnline.com
--  Dataset: vendas_lucratividade.csv
-- ============================================================

-- PASSO 1: Criar a tabela
CREATE TABLE vendas (
    id_pedido         TEXT,
    data_pedido       TEXT,
    regiao            TEXT,
    segmento          TEXT,
    categoria         TEXT,
    produto           TEXT,
    quantidade        REAL,
    preco_unitario    REAL,
    desconto          REAL,
    custo_unitario    REAL
);

-- Após criar a tabela, importe o arquivo CSV pelo botão "Import" do SQLiteOnline.
-- Em seguida, execute as queries abaixo uma por vez.

-- ============================================================
-- QUERY 01 — Visão geral: receita, custo e lucro total
-- Objetivo: entender o resultado financeiro consolidado do ano
-- ============================================================
SELECT
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)  AS receita_liquida,
    ROUND(SUM(quantidade * custo_unitario), 2)                   AS custo_total,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                   AS lucro_total,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                         AS margem_lucro_pct
FROM vendas;


-- ============================================================
-- QUERY 02 — Lucratividade por categoria de produto
-- Objetivo: identificar quais categorias são mais rentáveis
-- ============================================================
SELECT
    categoria,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)  AS receita_liquida,
    ROUND(SUM(quantidade * custo_unitario), 2)                   AS custo_total,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                   AS lucro,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                         AS margem_pct
FROM vendas
GROUP BY categoria
ORDER BY lucro DESC;


-- ============================================================
-- QUERY 03 — Receita e lucro por região
-- Objetivo: mapear desempenho geográfico
-- ============================================================
SELECT
    regiao,
    COUNT(DISTINCT id_pedido)                                     AS total_pedidos,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS receita_liquida,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                          AS margem_pct
FROM vendas
GROUP BY regiao
ORDER BY lucro DESC;


-- ============================================================
-- QUERY 04 — Top 10 produtos mais lucrativos
-- Objetivo: identificar os produtos que mais geram margem
-- ============================================================
SELECT
    produto,
    categoria,
    SUM(quantidade)                                               AS unidades_vendidas,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS receita_liquida,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                          AS margem_pct
FROM vendas
GROUP BY produto, categoria
ORDER BY lucro DESC
LIMIT 10;


-- ============================================================
-- QUERY 05 — Desempenho por segmento de cliente
-- Objetivo: entender qual perfil de cliente é mais rentável
-- ============================================================
SELECT
    segmento,
    COUNT(DISTINCT id_pedido)                                     AS total_pedidos,
    ROUND(AVG(quantidade * preco_unitario * (1 - desconto)), 2)   AS ticket_medio,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro_total,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                          AS margem_pct
FROM vendas
GROUP BY segmento
ORDER BY lucro_total DESC;


-- ============================================================
-- QUERY 06 — Evolução mensal da receita e lucro (tendência)
-- Objetivo: identificar sazonalidade e meses de pico
-- ============================================================
SELECT
    SUBSTR(data_pedido, 1, 7)                                     AS ano_mes,
    COUNT(DISTINCT id_pedido)                                     AS pedidos,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS receita_liquida,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro
FROM vendas
GROUP BY ano_mes
ORDER BY ano_mes;


-- ============================================================
-- QUERY 07 — Impacto do desconto na margem (CASE WHEN)
-- Objetivo: analisar se pedidos com desconto alto prejudicam o lucro
-- ============================================================
SELECT
    CASE
        WHEN desconto = 0           THEN 'Sem desconto'
        WHEN desconto <= 0.05       THEN 'Desconto baixo (até 5%)'
        WHEN desconto <= 0.10       THEN 'Desconto médio (6–10%)'
        ELSE                             'Desconto alto (>10%)'
    END                                                           AS faixa_desconto,
    COUNT(*)                                                      AS qtd_pedidos,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS receita_liquida,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                          AS margem_pct
FROM vendas
GROUP BY faixa_desconto
ORDER BY margem_pct DESC;


-- ============================================================
-- QUERY 08 — Produtos com margem abaixo de 20% (alerta)
-- Objetivo: identificar produtos que precisam de revisão de preço
-- ============================================================
SELECT
    produto,
    categoria,
    ROUND(
        (SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario))
        / SUM(quantidade * preco_unitario * (1 - desconto)) * 100
    , 2)                                                          AS margem_pct,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro_total
FROM vendas
GROUP BY produto, categoria
HAVING margem_pct < 20
ORDER BY margem_pct ASC;


-- ============================================================
-- QUERY 09 — Ranking de regiões por categoria (subquery)
-- Objetivo: cruzar região x categoria para achar combinações top
-- ============================================================
SELECT
    regiao,
    categoria,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro
FROM vendas
GROUP BY regiao, categoria
ORDER BY regiao, lucro DESC;


-- ============================================================
-- QUERY 10 — Comparativo: lucro real vs lucro sem desconto
-- Objetivo: quantificar o quanto os descontos custaram no ano
-- ============================================================
SELECT
    ROUND(SUM(quantidade * preco_unitario), 2)                    AS receita_bruta_sem_desconto,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS receita_liquida_com_desconto,
    ROUND(SUM(quantidade * preco_unitario)
        - SUM(quantidade * preco_unitario * (1 - desconto)), 2)   AS total_descontado,
    ROUND(
        (SUM(quantidade * preco_unitario)
        - SUM(quantidade * preco_unitario * (1 - desconto)))
        / SUM(quantidade * preco_unitario) * 100
    , 2)                                                          AS pct_receita_perdida_desconto,
    ROUND(SUM(quantidade * preco_unitario * (1 - desconto))
        - SUM(quantidade * custo_unitario), 2)                    AS lucro_real,
    ROUND(SUM(quantidade * preco_unitario)
        - SUM(quantidade * custo_unitario), 2)                    AS lucro_sem_desconto
FROM vendas;
