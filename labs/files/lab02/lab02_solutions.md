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
