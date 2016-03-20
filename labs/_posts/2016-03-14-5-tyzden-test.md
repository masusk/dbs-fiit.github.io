---
layout: dbs
categories: labs
title: 5. týždeň - test
published: true
---

## Test v piatom týždni - za 3 body

Hodnotenie
* Netreba 100% správnu syntax, ale správne smerovanie ­- teda za počítačom by oprava bola v sekundách
* DDL všetko OK → 2b
* DML všetko OK → 1b
* inak 0


### Cvičenia v pondelok

1. Napíšte SQL príkazy, ktoré upravia tabuľku s názvom `projekty` nasledovne:
  * odoberie stĺpec `skratka projektu`
  * pridá stĺpec `vlastník_projektu_id` , pričom to má byť cudzí kľúč do tabuľky `používatelia`
2. a napíšte SELECT, ktorý vráti identifikátory všetkých vlastníkov projektov.

### Cvičenia v utorok

1. Napíšte SQL príkaz, ktorý vytvorí tabuľku s názvom `prednášky` s 
  * automaticky generovaným primárnym kľúčom `id` a 
  * cudzím kľúčom `predmet_id`  do tabuľky `predmety`
2. a napíšte SELECT, ktorý vráti všetky prednášky predmetu s id `3`.

### Cvičenia v stredu

1. Napíšte SQL príkaz, ktorý vytvorí tabuľku s názvom `cvičenia` 
  * s automaticky generovaným primárnym kľúčom `id`, 
  * atribútom označujúcim dátum cvičenia
  * cudzím kľúčom  predmet_id  do tabuľky `predmety`
2. a napíšte SELECT, ktorý vráti všetky cvičenia zoradené podľa dátumu od najdávnejšieho po
najnovšie

### Cvičenia vo štvrtok

1. Napíšte SQL príkazy, ktoré upravia tabuľku s názvom  jedlá  nasledovne:
  * pridá stĺpec `názov`, pričom maximálna dĺžka názvu je 20 znakov
  * nastaví štandardnú (default) hodnotu boolean atribútu `vegetariánske` na FALSE
2. a napíšte SELECT, ktorý vráti všetky vegetariánske jedlá
