<!---
IMPORTANT
=========
This README.md is displayed in the WebStore as well as within Jarvis app
Please do not change the structure of this file
Fill-in Description, Usage & Author sections
Make sure to rename the [en] folder into the language code your plugin is written in (ex: fr, es, de, it...)
For multi-language plugin:
- clone the language directory and translate commands/functions.sh
- optionally write the Description / Usage sections in several languages
-->
## Description
Vous avez envie d'avoir des enfants ou peut-être pas... la contraception vous n'y tenait pas...
MAIS VOUS AVEZ ENVI DE FAIRE L'AMOUR !!!!

Dans le fichier de configuration vous pourrez:
Souhait_Enfant="non"
Votre_cylcemoyen_aujourdhui="28"
votreemail_cycle="super@gmail.com"

Un fichier serra généré au nom de date_cycle_regles.txt.
Si vous connaissez les dates des dernières règles vous devrez les rentrer comme ceci:
mois/jour/année plus ancien (par groupe de 2 chiffres à chaque fois)
..
..
mois/jour/année plus récent

Ensuite pour l'envoie par Email il faut configurer le service SMTP
Faire: sudo nano /etc/ssmtp/ssmtp.conf
root=username@gmail.com
mailhub=smtp.gmail.com:465
rewriteDomain=gmail.com
AuthUser=username
AuthPass=password
FromLineOverride=YES
UseTLS=YES

Et c'est ptêt... à votre lit !! lol

PS: Si vous avez le plugins 'jarvis-FREE-sms' vous pourrez envoyer un rapport sur votre téléphone mobile

## Languages

* Français

## Usage
```
You:mes prochaines règles
Jarvis: Vos Prochaines règles devraient être dans environ 31 jours soit vers le mercredi 03 mai 2017

You: ma prochaine ovulation
Jarvis: Votre Prochaine Ovulation devrait être dans 14 jours, vers le mercredi 19 avril 2017
Vous ne souhaites pas avoir d'enfant donc faites l'amour depuis les dernières règles le vendredi 31 mars 2017 jusqu'au jeudi 13 avril 2017
puis, vous le pourrez à nouveau après le samedi 22 avril 2017 jusqu'au prochaines règles le mercredi 03 mai 2017

You: liste mes règles
Jarvis: vous avez enregistré 3 dates le:
Jarvis: 03 mars 2017
Jarvis: 02 février 2017
Jarvis: 01 janvier 2017

You: puis-je faire l'amour ?
Jarvis: Allez-y, vous avez de la marge pendant 08 jours, soit jusqu'au jeudi 13 avril 2017

You: quel est mon cycle moyen ?
Jarvis: Votre cylce moyen enregistré actuellement est de 28 jours

You: Envoie mon cycle par sms (ou Email)
Jarvis: Cycle envoyé par SMS (ou Email)

You: enregistre mes règles
Jarvis: Est-ce votre premier jour de règle ?
*OUI*                   *NON*
jYouibé: non
Jarvis: Quelle date j'enregistre
*
You: le 5 avril
Jarvis: le 5 avril, ai-je bien compris ?
*OUI*                   *NON*
You: oui
Jarvis: vous me demandez d'enregistrer le 04/05/17
Jarvis: Il doit peut-être y avoir une erreur, avec la date du  mercredi 05 avril 2017, ce qui donnerai une moyenne de  5 jour, au lieu de 28 Jours.
Jarvis: Je ne l'enregsitre pas.

```
## Author
[Jean-Bernard Hallez](https://github.com/Jean-Bernard-Hallez/jarvis-mentruations)
