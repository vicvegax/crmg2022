--
-- File generated with SQLiteStudio v3.3.3 on sex mar 4 06:40:11 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: plMovimento
CREATE TABLE if not EXISTS plMovimento (
    id     INTEGER    PRIMARY KEY AUTOINCREMENT,
    id_inv INTEGER,
    id_loc INTEGER,
    st_ini CHAR (1),
    st_fim CHAR (1),
    data   DATE,
    cd_mov INTEGER,
    obs    TEXT (255),
    valor  REAL,
    dt_inc DATE,
    us_inc TEXT (8) 
);


-- Table: tbCateg
CREATE TABLE if not EXISTS tbCateg (
    id     INTEGER    PRIMARY KEY AUTOINCREMENT,
    cod    TEXT (20),
    descr  TEXT (50),
    obs    TEXT (255),
    ativo  INTEGER,
    dt_inc DATE,
    us_inc TEXT (8),
    dt_alt DATE,
    us_alt TEXT (8),
    rg_alt TEXT (500) 
);


-- Table: tbInvent
CREATE TABLE if not EXISTS tbInvent (
    id       INTEGER     PRIMARY KEY AUTOINCREMENT,
    cod      TEXT (20),
    descr    TEXT (50),
    id_cat   INTEGER,
    id_local INTEGER,
    dt_comp  DATE,
    vl_comp  REAL,
    vid_util INTEGER,
    obs      TEXT (255),
    situa    INTEGER,
    dt_man   DATE,
    id_man   INTEGER,
    ativo    INTEGER,
    dt_inc   DATE,
    us_inc   TEXT (8),
    dt_alt   DATE,
    us_alt   TEXT (8),
    rg_alt   TEXT (1000) 
);


-- Table: tbLocal
CREATE TABLE if not EXISTS tbLocal (
    id     INTEGER    PRIMARY KEY AUTOINCREMENT,
    cod    TEXT (20),
    descr  TEXT (50),
    local  TEXT (50),
    obs    TEXT (255),
    ativo  INTEGER,
    dt_inc DATE,
    us_inc TEXT (8),
    dt_alt DATE,
    us_alt TEXT (8),
    rg_alt TEXT (500) 
);


-- Table: tbPessoal
CREATE TABLE if not EXISTS tbPessoal (
    id     INTEGER    PRIMARY KEY AUTOINCREMENT,
    cod    TEXT (20),
    descr  TEXT (50),
    obs    TEXT (255),
    id_loc INTEGER,
    ativo  INTEGER,
    dt_inc DATE,
    us_inc TEXT (8),
    dt_alt DATE,
    us_alt TEXT (8),
    rg_alt TEXT (500) 
);


-- Table: tbUsuario
CREATE TABLE if not EXISTS tbUsuario (
    id     INTEGER    PRIMARY KEY AUTOINCREMENT,
    descr  TEXT (50),
    cd_usu TEXT (8),
    pass   TEXT (16),
    ativo  INTEGER,
    dt_inc DATE,
    us_inc TEXT (8),
    dt_alt DATE,
    us_alt TEXT (8),
    rg_alt TEXT (200) 
);


-- Index: idLocDescr
CREATE UNIQUE INDEX if not EXISTS idLocDescr ON tbLocal (
    descr ASC
);


-- Index: idPesDescr
CREATE UNIQUE INDEX if not EXISTS idPesDescr ON tbPessoal (
    descr ASC
);


-- Index: idUsuDescr
CREATE UNIQUE INDEX if not EXISTS idUsuDescr ON tbUsuario (
    descr ASC
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
