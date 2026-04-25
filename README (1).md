# 📊 Análise de Lucratividade de Vendas — SQL

Projeto de análise de dados utilizando **SQL puro** sobre uma base de vendas fictícia de 2024.  
O objetivo é responder perguntas reais de negócio sobre receita, margem e lucratividade.

---

## 🎯 Objetivo do Projeto

Explorar uma base de vendas com **75 pedidos** de diferentes regiões, segmentos e categorias de produto,  
respondendo perguntas estratégicas como:

- Qual categoria de produto é mais lucrativa?
- Qual região gera mais margem?
- Os descontos estão prejudicando o lucro?
- Quais produtos precisam de revisão de preço?

---

## 🗂️ Estrutura do Repositório

```
📁 analise-lucratividade-sql/
├── vendas_lucratividade.csv     # Dataset com 75 pedidos de vendas
├── analise_lucratividade.sql    # 6 queries SQL comentadas
└── README.md                    # Documentação do projeto
```

---

## 🔍 Queries Desenvolvidas

| # | Query | Conceito SQL |
|---|-------|-------------|
| 01 | Visão geral: receita, custo e lucro total | `SUM`, cálculo de margem |
| 02 | Lucratividade por categoria | `GROUP BY`, `ORDER BY` |
| 03 | Top 10 produtos mais lucrativos | `LIMIT`, múltiplos `GROUP BY` |
| 04 | Evolução mensal — tendência e sazonalidade | `SUBSTRING` para extrair mês |
| 05 | Impacto do desconto na margem | `CASE WHEN` |
| 06 | Produtos com margem abaixo de 20% | `HAVING` |

---

## 📌 Principais Insights

- **Tecnologia** é a categoria com maior lucro absoluto, mas **Móveis** apresenta margem mais alta por pedido
- A região **Sudeste** concentra o maior volume de receita, enquanto o **Norte** tem menor participação
- Pedidos com **desconto acima de 10%** apresentam margem significativamente inferior às demais faixas
- O total de desconto concedido ao longo do ano representou perda relevante de receita bruta

---

## 🧰 Ferramentas Utilizadas


- **Sql Online** — ambiente online, sem necessidade de instalação (data.world)
- Conceitos: `GROUP BY`, `HAVING`, `CASE WHEN`, `SUBSTR`, `COUNT DISTINCT`, agregações financeiras

---


[linkedin.com/in/igormeloss](https://linkedin.com/in/igormeloss) · [github.com/Igmeloss](https://github.com/Igmeloss)
