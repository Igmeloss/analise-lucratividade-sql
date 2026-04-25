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
├── analise_lucratividade.sql    # 10 queries SQL comentadas
└── README.md                    # Documentação do projeto
```

---

## 🔍 Queries Desenvolvidas

| # | Query | Conceito SQL |
|---|-------|-------------|
| 01 | Visão geral: receita, custo e lucro total | `SUM`, cálculo de margem |
| 02 | Lucratividade por categoria | `GROUP BY`, `ORDER BY` |
| 03 | Receita e lucro por região | `COUNT DISTINCT`, agregações |
| 04 | Top 10 produtos mais lucrativos | `LIMIT`, múltiplos `GROUP BY` |
| 05 | Desempenho por segmento de cliente | `AVG`, ticket médio |
| 06 | Evolução mensal — tendência e sazonalidade | `SUBSTR` para extrair mês |
| 07 | Impacto do desconto na margem | `CASE WHEN` |
| 08 | Produtos com margem abaixo de 20% | `HAVING` |
| 09 | Ranking região x categoria | subquery / cross analysis |
| 10 | Custo real dos descontos no ano | comparativo com/sem desconto |

---

## 📌 Principais Insights

- **Tecnologia** é a categoria com maior lucro absoluto, mas **Móveis** apresenta margem mais alta por pedido
- A região **Sudeste** concentra o maior volume de receita, enquanto o **Norte** tem menor participação
- Pedidos com **desconto acima de 10%** apresentam margem significativamente inferior às demais faixas
- O total de desconto concedido ao longo do ano representou perda relevante de receita bruta

---

## 🛠️ Como Executar

1. Acesse [sqliteonline.com](https://sqliteonline.com)
2. Clique em **"Import"** e selecione o arquivo `vendas_lucratividade.csv`
3. Abra o arquivo `analise_lucratividade.sql`
4. Execute as queries uma por vez e observe os resultados

---

## 🧰 Ferramentas Utilizadas

- **SQL** (SQLite)
- **SQLiteOnline** — ambiente online, sem necessidade de instalação
- Conceitos: `GROUP BY`, `HAVING`, `CASE WHEN`, `SUBSTR`, `COUNT DISTINCT`, agregações financeiras

---

## 👤 Autor

**Igor Leonardo dos Santos Silva**  
[linkedin.com/in/igormeloss](https://linkedin.com/in/igormeloss) · [github.com/Igmeloss](https://github.com/Igmeloss)
