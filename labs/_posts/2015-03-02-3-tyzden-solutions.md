---
layout: dbs
categories: labs
title: 3. týždeň - riešenia
published: true
---

﻿## Cvičenia v treťom týždni - Riešenia

### Dátové modelovanie #1 - Krajčírstvo
Z  logického modelu vytvorte fyzický model. Identifikujte potrebné entity, vzťahy medzi nimi, kardinalitu, definujte atribúty a ich typy, primárne a cudzie kľúče. Doplňte model  tak, aby umožňoval lepšiu evidenciu jednotlivých zákaziek a množstvo spotrebovaného materiálu.

Doplňte model tak, aby umožňoval lepšiu evidenciu jednotlivých zákaziek a množstvo spotrebovaného materiálu.

![ER-diagram krajcir](/labs/files/lab03/krajcir_zadanie.png "E-R diagram krajcir")

![ER-diagram krajcir riesenie](/labs/files/lab03/krajcir_riesenie.png "E-R diagram krajcir riesenie")


Doplňte model tak, aby zobrazoval históriu pôsobení hráča v tímoch a možnosť sledovania štatistík jednotlivých hráčov.

### Dátové modelovanie #2 - Futbalová liga

Doplňte model tak, aby zobrazoval históriu pôsobení hráča v tímoch a možnosť sledovania štatistík jednotlivých hráčov.

![ER-diagram football](/labs/files/lab03/football_zadanie.png "E-R diagram football")

Riešenie: Sorry, nemám obrázok, ale riešenie je jasné. Rozbiť Hrac-Tim na M:N a prepojit Hrac-Zapas (a tam evidovat hráčove body, trestné minúty a pod.)


### Dátové modelovanie #3 - Autopožičovňa

Uvažujte spoločnosť na požičiavanie automobilov.  Táto spoločnosť poskytuje niekoľko automobilov rôznych značiek a modelov. Zákazník si môže požičať automobil na dobu určitú. Spoločnosť si eviduje výnosy z výpožičiek. Automobil vyžaduje poistenie a údržbu. Údržbu automobilov zabezpečujú servisné strediská. Tieto strediská poskytujú rôzne služby, pričom dve rozdielne strediská môžu poskytovať rovnakú službu za rozdielnu cenu. Spoločnosť si eviduje náklady na údržbu automobilov. 

Vytvorte najskôr logický model, identifikujte entity, vzťahy medzi entitami a nakreslite ER diagram. 
Pre tento model vytvorte fyzický model, pre ktorý identifikujte potrebné entity, vzťahy medzi nimi,  kardinalitu, definujte atribúty a ich typy, primárne a cudzie kľúče.

Napíšte výrazy relačnej algebry poskytujúce odpovede na nasledujúce dopyty (predpokladajte, že máte vyplnené tabuľky)
1. Ceny všetkých ukončených výpožičiek zákazníka s menom „Jozef Mrkvička“
2. Továrenské značky všetkých momentálne vypožičaných automobilov
3. Továrenské značky automobilov, ktoré sa včera vrátili z údržby
4. Dátum výroby všetkých áut, ktoré ešte neboli v servise

![ER-diagram autopozicovna riesenie](/labs/files/lab03/autopozicovna_riesenie.png "E-R diagram autopozicovna riesenie")

1. Ceny všetkých ukončených výpožičiek zákazníka s menom „Jozef Mrkvička“
  &Pi;<sub>cena</sub>( &sigma;<sub>name=‘Jozef Mrkvicka‘&and;do != NULL</sub> (Zakaznik &#x22C8; Vypozicka))
2. Továrenské značky všetkých momentálne vypožičaných automobilov
  &Pi;<sub>oznacenie</sub>(&sigma;<sub>do = NULL</sub> (Vypozicka &#x22C8; (Model &#x22C8; Automobil)))
3. Továrenské značky automobilov, ktoré sa včera vrátili z údržby
  &Pi;<sub>oznacenie</sub>(&sigma;<sub>do = "vcera"</sub> (Udrzba &#x22C8; (Model &#x22C8; Automobil)))
4. Dátum výroby všetkých áut, ktoré ešte neboli v servise
  &Pi;<sub>datum-vyroby</sub>(&Pi;<sub>id</sub>(Automobil) - (&rho;<sub>id</sub>(&Pi;<sub>automobil-id</sub>(Udrzba))) &#x22C8;  Automobil)

### Dátové modelovanie #4 - Letisko

V diagrame je zobrazený zjednodušený logický entitno-relačný model letiska.

* A: Vytvorte z tohto modelu fyzický relačný model. Identifikujte potrebné entity, ich vzťahy, a správne do neho umiestnite primárne a cudzie kľúče. Ďalšie atribúty môžete pri riešení zanedbať.
* B: Zavedte do modelu entitu letenky, na základe ktorej pasažier cestuje z počiatočného letiska do svojho cieľa. Uvažujte pritom aj možnosť, že aj po vydaní boarding passu môže byť let zrušený, a pasažier bude musieť cestovať odlišným letom.

![Logický model letisko](/labs/files/lab03/letisko_zadanie.png "Logický model letisko")

Riešenie A:

![Fyzický model letisko A](/labs/files/lab03/letisko_riesenieA.png "Fyzický model letisko A")

Riešenie B:

![Fyzický model letisko B](/labs/files/lab03/letisko_riesenieB.png "Fyzický model letisko B")

### Dátové modelovanie #5 - Morské akvárium

Uvažujme morské akvárium, ktoré návštevníkom umožnuje z blízka sledovať život pod morskou hladinou. 
Akvárium disponuje mnohými nádržami, z ktorých každá nádrž má rôzny objem a teplotu vody. 
Pre účely údržby akvárium tiež eviduje, či je nádrž napustená. Každá nádrž má svojho správcu z radov zamestnancov, 
ktorý v danej nádrži riadi čistenie a kŕmenie, a dozerá na celkový stav zvierat v nádrži. V každej nádrži môže byť umiestnený
ľubovolný počet živočíchov rôznych druhov. Každý živočích je identifikovaný podľa mena a tiež 10-znakového kódu čipu, ktorým je označený. 
O všetkých živočíchoch akvárium eviduje ich dátum narodenia, a či boli narodení v zajatí. 
Každý živočíšny druh má o sebe evidovaný názov, latinský názov, a tiež dlhší opis zobrazovaný návštevníkom na informačných tabuliach. 
Živočíchy môžu byť premiestňované medzi jednotlivými nádržami - napríklad pri čistení celej nádrže - a preto akvárium 
musí evidovať odkedy a dokedy sa kde ktorý živočích nachádzal. Živočíchy v akváriu musia z času na čas prejsť 
veterinárnou prehliadkou. Prehliadky uskutočňuje vždy jeden z veterinárov zamestnaných v akváriu. 
Na základe prehliadky môže byť živočíchovi diagnostikovaný určitý symptóm, ktorý má svoj názov a textový opis. 
K diagnóze je následne evidovaný fakt, či sa z nej živočích úspešne vyliečil.

* Vytvorte najskôr logický model, identifikujte entity, vzťahy medzi entitami a nakreslite ER diagram.
* Pre tento model vytvorte fyzický model, pre ktorý identifikujte potrebné entity, vzťahy medzi nimi, kardinalitu, definujte atribúty a ich typy, primárne a cudzie kľúče.
* Napíšte výrazy relačnej algebry poskytujúce odpovede na nasledujúce dopyty (predpokladajte, že
máte vyplnené tabuľky)
 * Latinské názvy druhov živočíchov, ktoré mali dnes veterinárnu prehliadku:
  &Pi;<sub>latinsky-nazov</sub>(&sigma;<sub>datum = dnes </sub>(Prehliadka  &#x22C8; (Druh &#x22C8; Zivocich)))
 * Názvy nádrží, ktorých správcovia sú veterinári:   &Pi;<sub>nazov</sub>(&sigma;<sub>veterinar = true </sub>(Zamestnanec  &#x22C8; (Nadrz &#x22C8; Spravca)))
 * Mená správcov, ktorí majú v nádrži kosatky: 
&Pi;<sub>meno-spravcu</sub>(&rho;<sub>meno/meno-spravcu</sub>(Zamestnanec) &#x22C8; (Spravca &#x22C8; (&sigma;<sub>nazov = 'kosatka'</sub>(Nadrz &#x22C8; (Umiestnenie &#x22C8; (Zivocich &#x22C8; Druh)))))
 * Názvy symptómov všetkých živočíchov v karanténe (Názov nádrže "Karanténa"):
&Pi;<sub>nazov-nadrze</sub>(&sigma;<sub>nazov-nadrze = 'karantena'</sub>(&rho;<sub>nazov/nazov-nadrze</sub>(Nadrz) &#x22C8; (Umiestnenie &#x22C8; (Zivocich &#x22C8; (Prehliadka &#x22C8; (Diagnoza &#x22C8; Symptom)))))

 
 Riešenie:
 
 ![Fyzický model akvárium](/labs/files/lab03/morsky_svet_riesenieA.png "Fyzický model akvárium")
 
