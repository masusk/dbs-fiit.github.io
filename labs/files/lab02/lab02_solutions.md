## Cvičenia v druhom týždni

### Dátové modelovanie #1 - cudzie kľúče

1. Produkt patrí do viacerých kategórií. Kategória obsahuje veľa produktov. Produkt nemôže existovať bez kategórie.

  Každý produkt musí mať kategóriu. Kategória nemusí obsahovať žiaden produkt (ako by sme inak vytvorili kategóriu bez
  produktov.)

  ![Cardinality product category](/labs/files/lab02/produkt_kategoria_kardinality.png "Kardinality pre produkt a kategoriu")

2. Konkrétny produkt sa predáva v najviac jednej krajine. V krajine sa predáva veľa produktov.

  Konkrétny produkt (unikátny kód produktu) sa predáva iba jednej alebo žiadnej krajine. Krajina nemusí predávať žiadne
  produkty.

  ![Cardinality product country](/labs/files/lab02/produkt_krajina_kardinality.png "Kardinality pre produkt a krajinu")

### Dátové modelovanie E - kardinalita

V nasledovných diagramoch vysvetlite kardinalitu vzťahov medzi entitami. Určte, ktorý z týchto vzťahov
je typu 1:1 a vysvetlite, prečo je vždy potrebné zvážiť vhodnosť použitia takéhoto typu vzťahu. Vysvetlite, 
akým typom vzťahu by ho bolo vhodné v tomto prípade nahradiť, a prečo.

![ER-diagram kardinality](/labs/files/lab02/kardinality_zadanie.png "E-R diagram kardinality")

Riešenie:

1. Každý areál môže byť strážený ľubovoľným počtom strážnikov, ale nemusí byť strážený ani jedným.
Strážnik môže strážiť ľubovoľný počet areálov, ale strážiť musí aspoň jeden.
2. Policajt môže byť držiteľom práve jednej zbrane, ktorá môže byť držaná práve jedným policajtom.
3. Každý poistenec má práve jedného obvodného lekára, pričom každý lekár je obvodným lekárom aspoň jedného
alebo viac poistencov.

Druhý vzťah je príkladom vzťahu 1:1. Potrebu takýchto vzťahov je vždy potrebné zvážiť, nakoľko v ich prípade je možné entity zlúčiť
do jednej tabuľky - napríklad v tomto prípade uviesť evidenčné číslo zbrane ako atribút v tabuľke policajtov.
Tento vzťah by mohol byť problémový, pokiaľ by sme chceli viesť evidenciu držania zbraní v čase, pokiaľ by zbrane menili držiteľov,
alebo by policajti dostávali nové zbrane.