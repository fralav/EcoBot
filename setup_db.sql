drop database EcoBot_DB;
create database if not exists EcoBot_DB;
use  EcoBot_DB;

create table comuni (
    id int not null auto_increment,
    comune varchar(20) not null,
    primary key (id)
);

insert into comuni values 
    (1, "Altamura"),
    (2, "Cassano delle Murge"),
    (3, "Gravina in Puglia"),
    (4, "Grumo Appula"),
    (5, "Poggiorsini"),
    (6, "Santeramo in Colle"),
    (7, "Toritto");

create table giorni (
    id int not null auto_increment,
    giorno varchar(10),
    primary key (id)
);

insert into giorni values 
    (1, "lunedì"),
    (2, "martedì"),
    (3, "mercoledì"),
    (4, "giovedì"),
    (5, "venerdì"),
    (6, "sabato"),
    (7, "domenica");

create table rifiuti (
    id int not null auto_increment,
    rifiuto varchar(20),
    primary key (id)
);

insert into rifiuti values 
    (1, "carta"),
    (2, "indifferenziato"),
    (3, "organico"),
    (4, "plastica e metalli"),
    (5, "vetro"),
    (6, "sfalci e potature"),
    (7, "rifiuti ingombranti"),
    (8, "rifiuti pericolosi");

create table giorni_raccolta (
    comune int not null,
    giorno int not null,
    rifiuto int not null,
    primary key (comune, giorno, rifiuto),
    foreign key (comune) references comuni(id),
    foreign key (giorno) references giorni(id),
    foreign key (rifiuto) references rifiuti(id)
);

insert into giorni_raccolta values
    (1, 1, 3), (1, 3, 3), (1, 5, 3), (1, 2, 2), (1, 6, 2), (1, 4, 4), (1, 1, 5), (1, 5, 1), 
    (2, 1, 3), (2, 3, 3), (2, 5, 3), (2, 2, 2), (2, 1, 4), (2, 4, 4), (2, 3, 5), (2, 6, 5), (2, 6, 1),
    (3, 1, 3), (3, 3, 3), (3, 5, 3), (3, 2, 2), (3, 6, 4), (3, 3, 5), (3, 4, 1),
    (4, 1, 3), (4, 3, 3), (4, 5, 3), (4, 2, 6), (4, 4, 4), (4, 3, 5), (4, 2, 1),
    (5, 1, 3), (5, 4, 3), (5, 6, 3), (5, 3, 2), (5, 2, 4), (5, 5, 5), (5, 2, 1),
    (6, 1, 3), (6, 3, 3), (6, 5, 3), (6, 4, 2), (6, 6, 4), (6, 5, 5), (6, 2, 1),
    (7, 1, 3), (7, 3, 3), (7, 5, 3), (7, 6, 2), (7, 2, 4), (7, 4, 4), (7, 4, 1);