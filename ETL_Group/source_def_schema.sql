DROP TABLE IF EXISTS source_def;
CREATE TABLE  source_def (
product_key bigint(20)  NOT NULL AUTO_INCREMENT,
def VARCHAR(120),
PRIMARY KEY (product_key)
);

insert into source_def   (def) values( 'Orginal');