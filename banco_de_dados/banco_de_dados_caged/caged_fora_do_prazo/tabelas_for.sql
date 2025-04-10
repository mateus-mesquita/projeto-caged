-- Criando tabelas:

-- Tabela de combinações:
CREATE TABLE combinacoes (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	mes TEXT NOT NULL,
	uf TEXT NOT NULL,
	sexo TEXT NOT NULL,
	raca TEXT NOT NULL,
	idade TEXT NOT NULL,
	gdi TEXT NOT NULL,
	cnae TEXT NOT NULL
	
);

-- Tabela com resultados das contagens de admissões e demissões:
CREATE TABLE resultados_2022(
	id_combinacao INTEGER NOT NULL, 
		FOREIGN KEY (id_combinacao) REFERENCES combinacoes (id),
	n_admissoes INTEGER NOT NULL,
	n_demissoes INTEGER NOT NULL
);