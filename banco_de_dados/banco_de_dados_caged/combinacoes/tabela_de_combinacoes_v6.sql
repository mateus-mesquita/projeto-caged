-- Tabela de combinações

-- considerando as variáveis:
-- 1) Local (Estado)
-- 2) Sexo
-- 3) Raça
-- 4) Idade (Faixa etária)
-- 5) grau de instrução
-- 6) seção - cnae

CREATE TABLE combinacoes_v6(
	id INTEGER,
	mes TEXT,
	uf TEXT,
	sexo TEXT,
	raca TEXT,
	idade TEXT,
	gdi TEXT,
	cnae TEXT
)