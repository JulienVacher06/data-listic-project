/*==============================================================*/
/* Nom de SGBD :  PostgreSQL 8                                  */
/* Date de création :  27/03/2025 09:03:35                      */
/*==============================================================*/


drop table if exists AVOIR cascade;

drop table if exists CONTRAT cascade;

drop table if exists CONTRIBUTION cascade;

drop table if exists DEPOT cascade;

drop table if exists EQUIPEMENT cascade;

drop table if exists ETAPE cascade;

drop table if exists EXPLOITER cascade;

drop table if exists FAIRE cascade;

drop table if exists GUICHET cascade;

drop table if exists HEBERGER cascade;

drop table if exists PERSONNE cascade;

drop table if exists PROCEDURE cascade;

drop table if exists PROJET cascade;

drop table if exists PUBLICATION cascade;

drop table if exists REFLECHIR cascade;

drop table if exists SALLE cascade;

drop table if exists STATUT cascade;

drop table if exists TRAVAILLER cascade;

drop table if exists TYPE_CONTRAT cascade;

drop table if exists TYPE_EQUIPEMENT cascade;

drop table if exists TYPE_SALLe cascade;

/*==============================================================*/
/* Table : AVOIR                                                */
/*==============================================================*/
create sequence SQ_AVOIR_ID start with 1 increment by 1;

create table AVOIR (
   NUMCONTRAT           NUMERIC(10) DEFAULT NEXTVAL('SQ_AVOIR_ID')          not null,
   CODEETAPE            NUMERIC(10)          not null,
   CODEPROCEDURE        NUMERIC(10)          not null,
   constraint PK_AVOIR primary key (NUMCONTRAT, CODEETAPE, CODEPROCEDURE)
);

/*==============================================================*/
/* Table : CONTRAT                                              */
/*==============================================================*/
create sequence SQ_CONTRAT_ID start with 1 increment by 1;

create table CONTRAT (
   NUMCONTRAT           NUMERIC(10) DEFAULT NEXTVAL('SQ_CONTRAT_ID')          not null,
   CODETYPECONTRAT      NUMERIC(3)           not null,
   CODEINSEE            CHAR(5)              not null,
   DATEDEBUT            DATE                 null,
   DATEFIN              DATE                 null,
   constraint PK_CONTRAT primary key (NUMCONTRAT)
);

/*==============================================================*/
/* Table : CONTRIBUTION                                         */
/*==============================================================*/
create sequence SQ_CONTRIBUTION_ID start with 1 increment by 1;

create table CONTRIBUTION (
   CODECONTRIBUTION     NUMERIC(3) DEFAULT NEXTVAL('SQ_CONTRIBUTION_ID')        not null,
   TYPECONTRIBUTION     VARCHAR(20)          null,
   constraint PK_CONTRIBUTION primary key (CODECONTRIBUTION)
);

/*==============================================================*/
/* Table : DEPOT                                                */
/*==============================================================*/
create sequence SQ_DEPOT_ID start with 1 increment by 1;

create table DEPOT (
   CODEGUICHET          NUMERIC(4) DEFAULT NEXTVAL('SQ_DEPOT_ID')           not null,
   CODEPROJET           NUMERIC(4)           not null,
   DATEDEPOT            DATE                 null,
   constraint PK_DEPOT primary key (CODEGUICHET, CODEPROJET)
);


/*==============================================================*/
/* Table : EQUIPEMENT                                           */
/*==============================================================*/
create sequence SQ_EQUIPEMENT_ID start with 1 increment by 1;

create table EQUIPEMENT (
   CODEUSMB             CHAR(10) DEFAULT NEXTVAL('SQ_EQUIPEMENT_ID')             not null,
   IDSALLE              CHAR(4)              not null,
   NOMEQUIPEMENT        VARCHAR(50)          null,
   constraint PK_EQUIPEMENT primary key (CODEUSMB),
   constraint CK_EQUIPEMENT CHECK (CODEUSMB ~ '^\d{10}$')
);

/*==============================================================*/
/* Table : ETAPE                                                */
/*==============================================================*/
create sequence SQ_ETAPE_ID start with 1 increment by 1;

create table ETAPE (
   CODEETAPE            NUMERIC(10) DEFAULT NEXTVAL('SQ_ETAPE_ID')          not null,
   DATEMISEAJOUR        DATE                 null,
   STATUTACTUEL         VARCHAR(15)          null,
   constraint PK_ETAPE primary key (CODEETAPE),
   constraint CK_ETAPE_STATUTACTUEL CHECK (STATUTACTUEL IN ('Demarre', 'En signature', 'Termine'))
);

/*==============================================================*/
/* Table : EXPLOITER                                            */
/*==============================================================*/
create table EXPLOITER (
   CODEUSMB             CHAR(10)             not null,
   CODEPROJET           NUMERIC(4)           not null,
   constraint PK_EXPLOITER primary key (CODEUSMB, CODEPROJET)
);

/*==============================================================*/
/* Table : FAIRE                                                */
/*==============================================================*/
create table FAIRE (
   CODEINSEE            CHAR(5)              not null,
   CODEPUBLICATION      NUMERIC(4)           not null,
   CODECONTRIBUTION     NUMERIC(3)           not null,
   constraint PK_FAIRE primary key (CODEINSEE, CODEPUBLICATION, CODECONTRIBUTION)
);

/*==============================================================*/
/* Table : GUICHET                                              */
/*==============================================================*/
create sequence SQ_GUICHET_ID start with 1 increment by 1;

create table GUICHET (
   CODEGUICHET          NUMERIC(4) DEFAULT NEXTVAL('SQ_GUICHET_ID')           not null,
   NOMGUICHET           VARCHAR(50)          null,
   constraint PK_GUICHET primary key (CODEGUICHET)
);

/*==============================================================*/
/* Table : HEBERGER                                             */
/*==============================================================*/
create table HEBERGER (
   IDSALLE              CHAR(4)              not null,
   CODEINSEE            CHAR(5)              not null,
   DATEDEBUT            DATE                 null,
   DATEFIN              DATE                 null,
   constraint PK_HEBERGER primary key (IDSALLE, CODEINSEE)
);

/*==============================================================*/
/* Table : PERSONNE                                             */
/*==============================================================*/
create table PERSONNE (
   CODEINSEE            CHAR(5)              not null,
   CODESTATUT           NUMERIC(5)           not null,
   NOMPERSONNE          VARCHAR(50)          null,
   PRENOMPERSONNE       VARCHAR(50)          null,
   COURRIELPERSONNEL    VARCHAR(200)         null,
   COURIELPROFESSIONNEL VARCHAR(200)         null,
   POSITIONPERSONNE     CHAR(7)              null,
   IDENTIFIANTHAL       CHAR(12)             null,
   constraint PK_PERSONNE primary key (CODEINSEE),
   constraint CK_PERSONNE_CODEINSEE CHECK (CODEINSEE ~ '^\d{15}$'),
   constraint CK_PERSONNE_IDENTIFIANTHAL CHECK (IDENTIFIANTHAL ~ '^hal-\d{7,8}$')
);

/*==============================================================*/
/* Table : PROCEDURE                                            */
/*==============================================================*/
create sequence SQ_PROCEDURE_ID start with 1 increment by 1;

create table PROCEDURE (
   CODEPROCEDURE        NUMERIC(10) DEFAULT NEXTVAL('SQ_PROCEDURE_ID')          not null,
   CODESTATUT           NUMERIC(5)           not null,
   LIBELLEPROCEDURE     VARCHAR(50)          null,
   constraint PK_PROCEDURE primary key (CODEPROCEDURE)
);

/*==============================================================*/
/* Table : PROJET                                               */
/*==============================================================*/
create sequence SQ_PROJET_ID start with 1 increment by 1;

create table PROJET (
   CODEPROJET           NUMERIC(4) DEFAULT NEXTVAL('SQ_PROJET_ID')           not null,
   NOMPROJET            VARCHAR(100)         null,
   DATEDEBUT            DATE                 null,
   DUREEPREVISIONEL     VARCHAR(25)          null,
   MONTANTINITIAL       NUMERIC(10)          null,
   constraint PK_PROJET primary key (CODEPROJET)
);

/*==============================================================*/
/* Table : PUBLICATION                                          */
/*==============================================================*/
create sequence SQ_PUBLICATION_ID start with 1 increment by 1;

create table PUBLICATION (
   CODEPUBLICATION      NUMERIC(4) DEFAULT NEXTVAL('SQ_PUBLICATION_ID')           not null,
   CODEPROJET           NUMERIC(4)           not null,
   MOYENEDITION         VARCHAR(50)          null,
   NOMPARUTION          VARCHAR(200)         null,
   TYPEPUBLICATION      VARCHAR(25)          null,
   RANGPUBLICATION      NUMERIC(3,1)         null,
   constraint PK_PUBLICATION primary key (CODEPUBLICATION),
   constraint CK_PUBLICATION_RANGPUBLICATION CHECK (RANGPUBLICATION IN (0, 1, 2, 3, 4, 5)),
   constraint CK_PUBLICATION_TYPEPUBLICATION  CHECK (TYPEPUBLICATION  IN ('Journal scientifique', 'Conference scientifique'))
);

/*==============================================================*/
/* Table : REFLECHIR                                            */
/*==============================================================*/
create table REFLECHIR (
   CODEINSEE            CHAR(5)              not null,
   CODEPROJET           NUMERIC(4)           not null,
   constraint PK_REFLECHIR primary key (CODEINSEE, CODEPROJET)
);

/*==============================================================*/
/* Table : SALLE                                                */
/*==============================================================*/
create table SALLE (
   IDSALLE              CHAR(4)              not null,
   NUMEROETAGE          INT4                 null,
   CAPACITEACCEUIL      INT4                 null,
   constraint PK_SALLE primary key (IDSALLE),
   constraint CK_SALLE_IDSALLE CHECK (IDSALLE ~ '^[A-Za-z]\d{3}$'),
   constraint CK_SALLE_CAPACITEACCEUIL CHECK (CAPACITEACCEUIL BETWEEN 0 AND 300)
);

/*==============================================================*/
/* Table : STATUT                                               */
/*==============================================================*/
create sequence SQ_STATUT_ID start with 1 increment by 1;

create table STATUT (
   CODESTATUT           NUMERIC(5) DEFAULT NEXTVAL('SQ_STATUT_ID')            not null,
   LIBELLESTATUT        VARCHAR(25)          null,
   constraint PK_STATUT primary key (CODESTATUT),
   constraint CK_STATUT_LIBELLE CHECK (LIBELLESTATUT IN ('Stagiaire', ' Etudiant doctorant', 'Post-doctorant', 'BIATSS', 'Enseignant-chercheur'))
);

/*==============================================================*/
/* Table : TRAVAILLER                                           */
/*==============================================================*/
create table TRAVAILLER (
   CODEPROJET           NUMERIC(4)           not null,
   CODEINSEE            CHAR(5)              not null,
   ROLE                 VARCHAR(100)         null,
   constraint PK_TRAVAILLER primary key (CODEPROJET, CODEINSEE),
   constraint CK_TRAVAILLER_ROLE CHECK (ROLE IN ('Chef de projet', 'Redacteur', 'Coordinateur', 'Developpeur', 'Testeur', 'Consultant', 'Responsable de la communication', 'Administrateur'))
);

/*==============================================================*/
/* Table : TYPE_CONTRAT                                         */
/*==============================================================*/
create sequence SQ_TYPE_CONTRAT_ID start with 1 increment by 1;

create table TYPE_CONTRAT (
   CODETYPECONTRAT      NUMERIC(3) DEFAULT NEXTVAL('SQ_TYPE_CONTRAT_ID')           not null,
   LIBELLETYPECONTRAT   VARCHAR(100)         null,
   constraint PK_TYPE_CONTRAT primary key (CODETYPECONTRAT),
   constraint CK_TYPE_CONTRAT_LIBELLE CHECK (LIBELLETYPECONTRAT in ('Duree determines', 'Duree indetermine', 'Chercheur associe'))
);

/*==============================================================*/
/* Table : TYPE_EQUIPEMENT                                      */
/*==============================================================*/
create sequence SQ_TYPE_EQUIPEMENT_ID start with 1 increment by 1;

create table TYPE_EQUIPEMENT (
   CODETYPEEQUIPEMENT   NUMERIC(3) DEFAULT NEXTVAL('SQ_TYPE_EQUIPEMENT_ID')            not null,
   TYPEEQUIPEMENT       VARCHAR(50)          null,
   constraint PK_TYPE_EQUIPEMENT primary key (CODETYPEEQUIPEMENT)
);

/*==============================================================*/
/* Table : TYPE_SALLE                                           */
/*==============================================================*/
create sequence SQ_TYPE_SALLE_ID start with 1 increment by 1;

create table TYPE_SALLE (
   CODETYPESALLE        NUMERIC(3) DEFAULT NEXTVAL('SQ_TYPE_SALLE_ID')            not null,
   TYPESALLE            VARCHAR(30)          null,
   constraint PK_TYPE_SALLE primary key (CODETYPESALLE),
   constraint CK_TYPE_SALLE_TYPESALLE CHECK (TYPESALLE IN ('Technique', 'Bureau', 'Stockage', 'Archivage', 'Blanche', 'Experimentation', 'Serveur', 'Reunion'))
);

alter table AVOIR
   add constraint FK_AVOIR_AVOIR_CONTRAT foreign key (NUMCONTRAT)
      references CONTRAT (NUMCONTRAT)
      on delete restrict on update restrict;

alter table AVOIR
   add constraint FK_AVOIR_AVOIR2_ETAPE foreign key (CODEETAPE)
      references ETAPE (CODEETAPE)
      on delete restrict on update restrict;

alter table AVOIR
   add constraint FK_AVOIR_AVOIR3_PROCEDUR foreign key (CODEPROCEDURE)
      references PROCEDURE (CODEPROCEDURE)
      on delete restrict on update restrict;

alter table CONTRAT
   add constraint FK_CONTRAT_ASSOCIATI_PERSONNE foreign key (CODEINSEE)
      references PERSONNE (CODEINSEE)
      on delete restrict on update restrict;

alter table CONTRAT
   add constraint FK_CONTRAT_ASSOCIATI_TYPE_CON foreign key (CODETYPECONTRAT)
      references TYPE_CONTRAT (CODETYPECONTRAT)
      on delete restrict on update restrict;

alter table DEPOT
   add constraint FK_DEPOT_ASSOCIATI_PROJET foreign key (CODEPROJET)
      references PROJET (CODEPROJET)
      on delete restrict on update restrict;

alter table DEPOT
   add constraint FK_DEPOT_ASSOCIATI_GUICHET foreign key (CODEGUICHET)
      references GUICHET (CODEGUICHET)
      on delete restrict on update restrict;

alter table EQUIPEMENT
   add constraint FK_EQUIPEME_ASSOCIATI_SALLE foreign key (IDSALLE)
      references SALLE (IDSALLE)
      on delete restrict on update restrict;

alter table EXPLOITER
   add constraint FK_EXPLOITE_ASSOCIATI_EQUIPEME foreign key (CODEUSMB)
      references EQUIPEMENT (CODEUSMB)
      on delete restrict on update restrict;

alter table EXPLOITER
   add constraint FK_EXPLOITE_ASSOCIATI_PROJET foreign key (CODEPROJET)
      references PROJET (CODEPROJET)
      on delete restrict on update restrict;

alter table FAIRE
   add constraint FK_FAIRE_ASSOCIATI_CONTRIBU foreign key (CODECONTRIBUTION)
      references CONTRIBUTION (CODECONTRIBUTION)
      on delete restrict on update restrict;

alter table FAIRE
   add constraint FK_FAIRE_ASSOCIATI_PERSONNE foreign key (CODEINSEE)
      references PERSONNE (CODEINSEE)
      on delete restrict on update restrict;

alter table FAIRE
   add constraint FK_FAIRE_ASSOCIATI_PUBLICAT foreign key (CODEPUBLICATION)
      references PUBLICATION (CODEPUBLICATION)
      on delete restrict on update restrict;

alter table HEBERGER
   add constraint FK_HEBERGER_ASSOCIATI_SALLE foreign key (IDSALLE)
      references SALLE (IDSALLE)
      on delete restrict on update restrict;

alter table HEBERGER
   add constraint FK_HEBERGER_ASSOCIATI_PERSONNE foreign key (CODEINSEE)
      references PERSONNE (CODEINSEE)
      on delete restrict on update restrict;

alter table PERSONNE
   add constraint FK_PERSONNE_POSSEDER_STATUT foreign key (CODESTATUT)
      references STATUT (CODESTATUT)
      on delete restrict on update restrict;

alter table PROCEDURE
   add constraint FK_PROCEDUR_ASSOCIATI_STATUT foreign key (CODESTATUT)
      references STATUT (CODESTATUT)
      on delete restrict on update restrict;

alter table PUBLICATION
   add constraint FK_PUBLICAT_ASSOCIATI_PROJET foreign key (CODEPROJET)
      references PROJET (CODEPROJET)
      on delete restrict on update restrict;

alter table REFLECHIR
   add constraint FK_REFLECHI_ASSOCIATI_PROJET foreign key (CODEPROJET)
      references PROJET (CODEPROJET)
      on delete restrict on update restrict;

alter table REFLECHIR
   add constraint FK_REFLECHI_ASSOCIATI_PERSONNE foreign key (CODEINSEE)
      references PERSONNE (CODEINSEE)
      on delete restrict on update restrict;

alter table TRAVAILLER
   add constraint FK_TRAVAILL_ASSOCIATI_PROJET foreign key (CODEPROJET)
      references PROJET (CODEPROJET)
      on delete restrict on update restrict;

alter table TRAVAILLER
   add constraint FK_TRAVAILL_ASSOCIATI_PERSONNE foreign key (CODEINSEE)
      references PERSONNE (CODEINSEE)
      on delete restrict on update restrict;

