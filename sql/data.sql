BEGIN;
-- contact Countries
INSERT INTO contact.countries (id, alpha3, name) VALUES (39, 'EUR', 'Italy');
INSERT INTO contact.countries (id, alpha3, name) VALUES (45, 'DKK', 'Denmark');
INSERT INTO contact.countries (id, alpha3, name) VALUES (46, 'SEK', 'SWeden');

-- gl Currencies
INSERT INTO gl.currencies (id, country_id, alpha3, name) VALUES (208, 45, 'dkk', 'Danish Krone');
INSERT INTO gl.currencies (id, country_id, alpha3, name) VALUES (978, 45, 'eur', 'Euro');

-- contact Organisations
INSERT INTO contact.organisations (currency_id) VALUES (208);

-- gl Rates
INSERT INTO gl.rates VALUES (default,'DKK','active',1,208);
INSERT INTO gl.rates VALUES (default,'Euro','active',7.4516,978);

-- Product vats
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(9.00, 45, '1962-01-01', '1967-06-03');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(10.00, 45, '1967-06-03', '1968-03-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(12.50, 45, '1968-03-01', '1970-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(15.00, 45, '1970-01-01', '1975-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(9.25, 45, '1975-01-01', '1976-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(15.00, 45, '1976-01-01', '1977-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(18.00, 45, '1977-01-01', '1978-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(20.25, 45, '1978-01-01', '1980-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(22.00, 45, '1978-01-01', '1992-01-01');
INSERT INTO product.vats (rate, country_id, start_time, end_time) VALUES(25.00, 45, '1992-01-01', NULL);

-- gl chartofaccount
-- Autocreated from kontoplan.xls on July 09, 2008 20:29

CREATE TABLE init_ids (name text, id integer);
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24100, 'Udgående moms (salgsmoms)', 208, 'asset');
INSERT INTO init_ids (name, id) SELECT 'ud', currval(' gl.chartofaccounts_id_seq');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24200, 'Indgående moms (købsmoms)', 208, 'asset');
INSERT INTO init_ids (name, id) SELECT 'ind', currval(' gl.chartofaccounts_id_seq');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 1000, 'Omsætning', 208, 'revenue');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ud';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 1600, 'Gebyr før moms', 208, 'revenue');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ud';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 1610, 'Gebyr efter moms', 208, 'revenue');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 1990, 'Afgivne rabatter', 208, 'revenue');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2000, 'Vareforbrug', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2450, 'Gebyr før moms', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2460, 'Gebyr efter moms', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2800, 'Lagerregulering', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2810, 'Tab / vind lager', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2900, 'Fragt', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 2990, 'Modtagne rabatter', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3010, 'Løn A-indkomst', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3020, 'AM-bidrag arb.giver', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3030, 'AM-bidrag', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3040, 'A-conto løn', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3050, 'ATP', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3060, 'Pensionsbidrag ', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3070, 'Skattefrie tillæg', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3080, 'Kørselsgodtgørelse', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3090, 'ATP-kompensation', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3100, 'Løntilskud', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3110, 'AER kompensation', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3120, 'Fortæring under arbejde', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3130, 'Lærlingeudgifter', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3140, 'Feriepenge', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3150, 'Lovpligtig arb.skade forsikring', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 3160, 'Øvrige personaleomk. ', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4010, 'Annoncer og reklamer', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4020, 'Repr. vin/tobak/spiritus', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4030, 'Repr. gaver og blomster', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4040, 'Restaurantbesøg', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4210, 'Husleje', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4220, 'Rep. og vedligeholdelse', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4230, 'Rengøring', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4240, 'El, vand og varme', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4610, 'Telefon og mobiltelefon', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4620, 'Privat andel af telefon', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4630, 'Småanskaffelser', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4640, 'Kontorartikler', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4650, 'Porto og gebyrer', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4660, 'Forsikringer', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4670, 'Abonnement og kontingent', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4680, 'Faglitteratur', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4690, 'Revision og regnskabsass.', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4700, 'Advokat', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 4990, 'Kassedifferencer', 208, 'cost');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ud';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 6100, 'Inventar', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 7110, 'Renter pengeinstitut mv.', 208, 'revenue');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 7120, 'Debitorrenter', 208, 'revenue');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 7510, 'Renter pengeinstitut mv.', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 7520, 'Kreditorrenter', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 7530, 'Andre renteudgifter', 208, 'cost');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 14100, 'Saldo primo', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 14200, 'Tilgang', 208, 'liability');
INSERT INTO gl.accountvat (coa_id,vat_coa,vat_id) SELECT currval(' gl.chartofaccounts_id_seq'),id,10 FROM init_ids WHERE name='ind';
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 14300, 'Afgang', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 14400, 'Afskrivninger', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16100, 'Varelager primo', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16200, 'Varelager tilgang DK', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16300, 'Varelager tilgang EU', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16400, 'Varelager tilgang 3. Land', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16500, 'Varelager afgang', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 16600, 'Regulering varelager', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 17100, 'Debitorer', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 17200, 'Øvrige tilgodehavender', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 18100, 'Kasse', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 18200, 'Bank', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 18300, 'Giro', 208, 'liability');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 21100, 'Kapital primo', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 23100, 'Kassekredit', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 23300, 'Lån', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24250, 'Moms af varekøb i udland', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24300, 'El-afgift', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24400, 'Co2-afgift', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24500, 'Vandafgift', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 24600, 'Momsafregningskonto', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 25100, 'Kreditorer', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 25200, 'Øvrige omkostninger', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26100, 'Skyldig a-skat', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26200, 'Skyldig am-bidrag', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26300, 'Skyldig ATP', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26400, 'Skyldig pensionsbidrag', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26500, 'Skyldig løn', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 26600, 'Skyldige feriepenge', 208, 'asset');
INSERT INTO gl.chartofaccounts (org_id, account_nr, name, currency_id, type) VALUES (1, 29995, 'Systemkonto', 208, 'asset');

-- Point to bank, kasse, Giro, ...
INSERT INTO gl.accountsoas (coa_id,type) VALUES (67, 'pos');
INSERT INTO gl.accountsoas (coa_id,type) VALUES (68, 'bank');
INSERT INTO gl.accountsoas (coa_id,type) VALUES (69, 'bank');

-- Dimensions
INSERT INTO gl.dimensions (org_id,dimension,dimtable,dimcolumn) VALUES (1,1,'gl.chartofaccounts','account_nr');
INSERT INTO gl.dimensions (org_id,dimension,dimtable,dimcolumn) VALUES (1,2,'product.articlegroups','id');

COMMIT;
