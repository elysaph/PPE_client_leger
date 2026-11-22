CREATE DATABASE IF NOT EXISTS proxiprof;
USE proxiprof;

CREATE TABLE IF NOT EXISTS utilisateur (
    id_utilisateur INT NOT NULL AUTO INCREMENT,
    enum_role VARCHAR(50),
    nom VARCHAR(50),
    prenom VARCHAR(50),
    mail VARCHAR(255),
    mdp VARCHAR(255),
    statut VARCHAR(50),
    PRIMARY KEY (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Professeur (
    id_utilisateur INT NOT NULL,
    bio BIGINT,
    tarif DECIMAL(15, 2),
    latitude DECIMAL(15, 2),
    adresse VARCHAR(50),
    matiere VARCHAR(50),
    rayon INT,
    statut_validation VARCHAR(20),
    PRIMARY KEY (id_utilisateur),
    CONSTRAINT fk_professeur_utilisateur
        FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Enfant (
    id_utilisateur INT NOT NULL,
    tranche_age VARCHAR(20),
    niveau VARCHAR(50),
    PRIMARY KEY (id_utilisateur),
    CONSTRAINT fk_enfant_utilisateur
        FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Matiere (
    id_matiere INT NOT NULL,
    libelle VARCHAR(50),
    PRIMARY KEY (id_matiere)
);

CREATE TABLE IF NOT EXISTS Disponibilite (
    id_dispo INT NOT NULL,
    jours VARCHAR(10),
    heure_debut TIME,
    heure_fin TIME,
    id_utilisateur INT NOT NULL,
    PRIMARY KEY (id_dispo),
    CONSTRAINT fk_disponi_professeur
        FOREIGN KEY (id_utilisateur) REFERENCES Professeur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Ressource (
    id_ressource INT NOT NULL,
    titre VARCHAR(100),
    fichier VARCHAR(255),
    date_depot DATE,
    id_utilisateur INT NOT NULL,
    PRIMARY KEY (id_ressource),
    CONSTRAINT fk_ressource_professeur
        FOREIGN KEY (id_utilisateur) REFERENCES Professeur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Seance (
    id_seance INT NOT NULL,
    statut VARCHAR(20),
    date_debut DATE,
    date_fin DATE,
    id_utilisateur INT NOT NULL,
    id_utilisateur_1 INT NOT NULL,
    PRIMARY KEY (id_seance),
    CONSTRAINT fk_seance_enfant
        FOREIGN KEY (id_utilisateur) REFERENCES Enfant (id_utilisateur),
    CONSTRAINT fk_seance_professeur
        FOREIGN KEY (id_utilisateur_1) REFERENCES Professeur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Parent (
    id_utilisateur INT NOT NULL,
    profession VARCHAR(50),
    PRIMARY KEY (id_utilisateur),
    CONSTRAINT fk_parent_utilisateur
        FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Avis (
    id_avis INT NOT NULL,
    note INT,
    commentaire TEXT,
    date_avis DATE,
    id_utilisateur INT NOT NULL,
    PRIMARY KEY (id_avis),
    CONSTRAINT fk_avis_parent
        FOREIGN KEY (id_utilisateur) REFERENCES Parent (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Collaborer (
    id_utilisateur INT NOT NULL,
    id_utilisateur_1 INT NOT NULL,
    date_inscription DATE,
    PRIMARY KEY (id_utilisateur, id_utilisateur_1),
    CONSTRAINT fk_collaborer_professeur
        FOREIGN KEY (id_utilisateur) REFERENCES Professeur (id_utilisateur),
    CONSTRAINT fk_collaborer_enfant
        FOREIGN KEY (id_utilisateur_1) REFERENCES Enfant (id_utilisateur)
);

CREATE TABLE IF NOT EXISTS Enseigner (
    id_utilisateur INT NOT NULL,
    id_matiere INT NOT NULL,
    PRIMARY KEY (id_utilisateur, id_matiere),
    CONSTRAINT fk_enseigner_professeur
        FOREIGN KEY (id_utilisateur) REFERENCES Professeur (id_utilisateur),
    CONSTRAINT fk_enseigner_matiere
        FOREIGN KEY (id_matiere) REFERENCES Matiere (id_matiere)
);

CREATE TABLE IF NOT EXISTS Acceder (
    id_utilisateur INT NOT NULL,
    id_ressource INT NOT NULL,
    PRIMARY KEY (id_utilisateur, id_ressource),
    CONSTRAINT fk_acceder_enfant
        FOREIGN KEY (id_utilisateur) REFERENCES Enfant (id_utilisateur),
    CONSTRAINT fk_acceder_ressource
        FOREIGN KEY (id_ressource) REFERENCES Ressource (id_ressource)
);

CREATE TABLE IF NOT EXISTS identification_matiere (
    id_matiere INT NOT NULL,
    id_ressource INT NOT NULL,
    PRIMARY KEY (id_matiere, id_ressource),
    CONSTRAINT fk_identification_matiere
        FOREIGN KEY (id_matiere) REFERENCES Matiere (id_matiere),
    CONSTRAINT fk_identification_ressource
        FOREIGN KEY (id_ressource) REFERENCES Ressource (id_ressource)
);

CREATE TABLE IF NOT EXISTS recevoir (
    id_utilisateur INT NOT NULL,
    id_avis INT NOT NULL,
    PRIMARY KEY (id_utilisateur, id_avis),
    CONSTRAINT fk_recevoir_professeur
        FOREIGN KEY (id_utilisateur) REFERENCES Professeur (id_utilisateur),
    CONSTRAINT fk_recevoir_avis
        FOREIGN KEY (id_avis) REFERENCES Avis (id_avis)
)