-- Criando tabelas:

-- Tabela de combinações:
CREATE TABLE combinacoes (
	n INTEGER PRIMARY KEY,
	mes TEXT NOT NULL,
	uf TEXT NOT NULL,
	sexo TEXT NOT NULL,
	raca TEXT NOT NULL,
	gdi TEXT NOT NULL,
	cnae TEXT NOT NULL
	
);

-- Tabela com resultados das contagens de admissões e demissões:
CREATE TABLE resultados_2022(
	id_combinacao INTEGER NOT NULL, 
		FOREIGN KEY (id_combinacao) REFERENCES combinacoes (n),
	n_admissoes INTEGER NOT NULL,
	n_demissoes INTEGER NOT NULL
);