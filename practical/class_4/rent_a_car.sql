CREATE TABLE Cliente(
    [nif] INTEGER NOT NULL PRIMARY KEY,
    [nome] VARCHAR(32) NOT NULL,
    [endereco] VARCHAR(64),
    [num_carta] VARCHAR(32)
);


CREATE TABLE Balcao(
    [numero] INTEGER NOT NULL PRIMARY KEY,
    [nome] VARCHAR(32) NOT NULL,
    [endereco] VARCHAR(32)
);


CREATE TABLE Tipo_veiculo(
    [codigo] INTEGER NOT NULL PRIMARY KEY,
    [nome] VARCHAR(16) NOT NULL,
    [ar_condicionado] BIT
);


CREATE TABLE Veiculo(
    [matricula] VARCHAR(16) NOT NULL PRIMARY KEY,
    [ano] SMALLINT NOT NULL,
    [marca] VARCHAR(16) NOT NULL,
    [tipo_veiculo_codi ] INTEGER REFERENCES Tipo_veiculo(codigo) NOT NULL
);


CREATE TABLE Aluguer(
    [numero] INTEGER NOT NULL PRIMARY KEY,
    [duracao] INTEGER NOT NULL,
    [data_inicio] DATETIME NOT NULL,
    [data_entrega] DATETIME,
    [balcao_num] INTEGER REFERENCES Balcao(numero) NOT NULL,
    [cliente_nif] INTEGER REFERENCES Cliente(nif) NOT NULL,
    [veiculo_matricula] VARCHAR(16) REFERENCES VEICULO(matricula) NOT NULL
);

CREATE TABLE Similaridade(
    [veiculo_cod1] INTEGER REFERENCES Tipo_veiculo(codigo) NOT NULL,
    [veiculo_cod2] INTEGER REFERENCES Tipo_veiculo(codigo) NOT NULL,
    PRIMARY KEY(veiculo_cod1, veiculo_cod2)
);

CREATE TABLE Pesado(
    [tipo_veiculo_cod] INTEGER REFERENCES Tipo_veiculo(codigo) NOT NULL PRIMARY KEY,
    [peso] FLOAT NOT NULL,
    [passageiros] SMALLINT
);

CREATE TABLE Ligeiro(
    [tipo_veiculo_cod] INTEGER REFERENCES Tipo_veiculo(codigo) NOT NULL PRIMARY KEY,
    [num_lugares] SMALLINT,
    [portas] SMALLINT,
    [combustivel] VARCHAR(16),
    CONSTRAINT [check_combustivel] CHECK (combustivel IN ('gasolina', 'gasoleo', 'gpl', 'eletrico', 'hibrido', 'hidrogeneo'))
);


