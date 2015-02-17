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

### Dátové modelovanie M - Centrum voľného času

Centrum voľného času (ďalej CVČ) organizuje detské krúžky s rôznym zameraním (šachový, futbalový, plavecký atď.). 
Stretnutia krúžkov sa počas jedného sa kurzu konajú vždy každý týždeň pravidelne. V prípade veľkého záujmu o niektoré 
krúžky CVČ tiež zvykne organizovať viacero rovnakých kurzov o rôznych časoch, prípadne aj naraz. Po tom čo sa otvorí prázdny kurz,
je možné sa naň zapísať. Rodičia môžu zapísať svoje deti na koľko krúžkov len chcú. Za kurz sa vždy CVČ platí dopredu prostredníctvom platbou z účtu.
Vedenie CVČ sa pri evidovaní platieb nezaujíma o vlastníka účtu, pokiaľ je kurz riadne zaplatený.
Každý kurz vedie vždy minimálne jeden inštruktor. Inštruktori zvyknú tiež viesť viacero kurzov, 
samozrejme pokiaľ sa im pri tom nekolidujú termíny. Kurzom ktoré si to vyžadujú CVČ priraďuje v rozvrhu vhodné priestory 
v ktorých sa môžu do plnej miery venovať svojim aktivitám (miestnosť, ihrisko, plavecká dráha atď.). Niekedy môže rovnaké priestory zdieľať 
aj viacero kurzov. Identifikujte entity, vzťahy medzi entitami a nakreslite ER diagram.

Riešenie:

![ER-diagram centrum volneho casu](/labs/files/lab02/cvc_riesenie.png "E-R centrum volneho casu")

### Dátové modelovanie M - Farmaceutická firma

Doplňte logický model distribúcie vo farmaceutickej firme tak, aby zahŕňal:

* Evidenciu zásielok tovaru, pričom každú objednávku musí byť možné rozdeliť na viac zásielok pokiaľ si to odoberateľ želá
* Evidenciu jázd obchodného reprezentanta. Pre každú jazdu farmaceutickú spoločnosť zaujíma množstvo spotrebovaného paliva a navštívené predajne.
* Zmeniť mapovanie vytvorených objednávok na zodpovedného obchodného reprezentanta z priameho, na založené na regióne, v ktorom
sa predajňa nachádza a reprezentant ho má na starosti

![ER-diagram farmácia](/labs/files/lab02/farmacia_zadanie.png "E-R diagram farmácia")

Riešenie:

![ER-diagram farmácia](/labs/files/lab02/farmacia_riesenie.png "E-R diagram farmácia")