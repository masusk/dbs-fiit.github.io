## Cvičenia v druhom týždni - Riešenia

### Dátové modelovanie M - Letisko

V diagrame je zobrazený zjednodušený logický entitno-relačný model letiska.

* A: Vytvorte z tohto modelu fyzický relačný model. Identifikujte potrebné entity, ich vzťahy, a správne do neho umiestnite primárne a cudzie kľúče. Ďalšie atribúty môžete pri riešení zanedbať.
* B: Zavedte do modelu entitu letenky, na základe ktorej pasažier cestuje z počiatočného letiska do svojho cieľa. Uvažujte pritom aj možnosť, že aj po vydaní boarding passu môže byť let zrušený, a pasažier bude musieť cestovať odlišným letom.

![Logický model letisko](/labs/files/lab03/letisko_zadanie.png "Logický model letisko")

Riešenie A:

![Fyzický model letisko A](/labs/files/lab03/letisko_riesenieA.png "Fyzický model letisko A")

Riešenie B:

![Fyzický model letisko B](/labs/files/lab03/letisko_riesenieB.png "Fyzický model letisko B")

### Dátové modelovanie M - Morské akvárium

Uvažujme morské akvárium, ktoré návštevníkom umožnuje z blízka sledovať život pod morskou hladinou. 
Akvárium disponuje mnohými nádržami, z ktorých každá nádrž má rôzny objem a teplotu vody, 
a tiež môžu byť napustené, ale aj vypustené pre údržbu. Každá nádrž má svojho správcu z rád zamestnancov, 
ktorý v danej nádrži riadi čistenie a kŕmenie, a dozerá na celkový stav zvierat v nádrži. V každej nádrži môže byť umiestnený
ľubovolný počet živočíchov rôznych druhov. Každý živočích je identifikovaný podľa mena a tiež 10-znakového kódu čipu, ktorým je označený. 
O všetkých živočíchoch akvárium eviduje, či boli narodeni v zajatí a aký je ich dátum narodenia. 
Každý živočíšny druh má o sebe evidovaný názov, latinský názov, a dlhší opis pre návštevníkov. 
Živočíchy môžu byť premiestňované medzi jednotlivými nádržami, napríklad pri väčšom čistení, preto akvárium 
musí evidovať odkedy a dokedy sa kde ktorý živočích nachádzal. Živočíchy v akváriu musia z času na čas prejsť 
veterinárnou prehliadkou. Prehliadky uskutočňuje vždy jeden z veterinárov zamestnaných v akváriu. 
Na z8klade prehliadky môže byť živočíchovi diagnostikovaný určitý symptóm, ktorý má svoj názov a textový opis. 
K diagnóze je následne evidovaný fakt, či sa s nej živočích úspešne vyliečil.

* Vytvorte najskôr logický model, identifikujte entity, vzťahy medzi entitami a nakreslite ER diagram.
* Pre tento model vytvorte fyzický model, pre ktorý identifikujte potrebné entity, vzťahy medzi nimi, kardinalitu, definujte atribúty a ich typy, primárne a cudzie kľúče.
* Napíšte výrazy relačnej algebry poskytujúce odpovede na nasledujúce dopyty (predpokladajte, že
máte vyplnené tabuľky)
 * Latinské názvy druhov živočíchov, ktoré mali dnes veterinárnu prehliadku
 * Názvy nádrží, ktorých správcovia sú veterinári
 * Mená správcov, ktorí majú v nádrži kosatky.
 * Názvy symptómov všetkých živočíchov v karanténe (Názov nádrže "Karanténa")
 
 Riešenie:
 
 ![Fyzický model akvárium](/labs/files/lab03/morsky_svet_riesenieA.png "Fyzický model akvárium")
 
 ![Relačná algebra akvárium](/labs/files/lab03/morsky_svet_riesenieB.png "Relačná algebra akvárium")