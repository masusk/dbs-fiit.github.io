---
layout: dbs
categories: labs
title: 4. týždeň - test
published: true
---

## Test v štvrtom týždni - za 2 body

Hodnotenie:

* všetko OK &rarr; 2b (netreba 100% ok syntax, ale správne smerovanie)
* iné prípady: &rarr; 0b

Pokyny:

* Je povolené používať online dokumentáciu

### Cvičenia v pondelok

Napíšte SQL príkazy, ktoré upravia tabuľku s názvom `predmety` nasledovne: 

  * odoberie stĺpec `meno_prednášajúceho`
  * pridá stĺpec `skratka predmetu`, pričom skratka predmetu má max. 6 znakov

### Cvičenia v utorok

Napíšte SQL príkaz, ktorý vytvorí tabuľku s názvom `predmety` s 

  * automaticky generovaným primárnym kľúčom `id`, 
  * cudzím kľúčom `prednášajúci_id` do tabuľky učiteľov
  * číselným atribútom označujúcim počet hodín prednášok do týždňa

### Cvičenia v stredu

1. Napíšte SQL príkaz, ktorý vytvorí tabuľku s názvom `cvičenia` s 
  * automaticky generovaným primárnym kľúčom `id`, 
  * cudzím kľúčom `predmet_id` do tabuľky predmetov
2. a príkaz, ktorý túto tabuľku vymaže
