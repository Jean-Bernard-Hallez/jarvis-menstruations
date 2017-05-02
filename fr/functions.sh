#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file

jv_pg_ct_quand_regle() {
fichier_existe_regle
On_est_le_regle
calculdeovulation
erreur_ligne_vide_regle
resultat_date_regle
cycle_moyen_regle
date_utilisateur_regle="$derniere_date_regle_court"
encore_jour_regle=$(($derniere_date_regle_court_sec - $date_aujourdhui_regle_sec ))
encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
say "Vos Prochaines règles devraient être dans environ $encore_jour_regle jours soit vers le $resultat_proch_regle_long"
}


cheminacces_regle() {
cycleemail_chemin="/home/pi/jarvis/plugins_installed/jarvis-menstruations/cycleemail.txt"
cycle_regles_chemin="/home/pi/jarvis/plugins_installed/jarvis-menstruations/date_cycle_regles.txt"
cyclemoyen_chemin="/home/pi/jarvis/plugins_installed/jarvis-menstruations/cyclemoyen.txt"
}

jv_pg_ct_amour() {
fichier_existe_regle
On_est_le_regle
date_utilisateur_regle=""
cycle_moyen_regle
calculdeovulation
erreur_ligne_vide_regle
resultat_date_regle
Test_date_aujourdhui_regle_court=`date "+%m/%d/%Y"`
Test_date_aujourdhui_regle_long=`date "+%A %d %B %Y"`
Test_date_aujourdhui_regle_sec=`date +%s`
derniere_date_regle_sec=`date -d "$derniere_date_regle_court" +%s`


# "Votre période de fertilité sera maximale du $fertilite_min_long au $fertilite_max_long."
if [ "$Souhait_Enfant" = "oui" ]; then

	if [[ $Test_date_aujourdhui_regle_sec -ge $fertilite_min_court_sec && $Test_date_aujourdhui_regle_sec -le $fertilite_max_court_sec  ]] ; then
	encore_jour_regle=$(($fertilite_max_court_sec - $Test_date_aujourdhui_regle_sec ))
	encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
	say "Vous êtes en pleine période pour avoir un bébé, et cela pendant $encore_jour_regle jours jusqu'au $fertilite_max_long"
	fi


	if [[ $Test_date_aujourdhui_regle_sec -le $fertilite_min_court_sec ]]; then
	encore_jour_regle=$(($fertilite_min_court_sec - $Test_date_aujourdhui_regle_sec ))
	encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
	say "Vous êtes pas encore dans la période fertile, il faut attendre encore $encore_jour_regle jours soit jusqu'au $fertilite_min_long"
	fi

	if [[ $Test_date_aujourdhui_regle_sec -gt $fertilite_max_court_sec ]]; then
	say "Vous avez dépassé la période fertile, les prochaines règles commenceront le $resultat_proch_regle_long"
	fi

else

	if [[ $Test_date_aujourdhui_regle_sec -ge $fertilite_min_court_moin2_sec && $Test_date_aujourdhui_regle_sec -le $fertilite_max_court_plus2_sec  ]] ; then
	say "Ne faites surtout pas l'amour maintenant ou elle serra enceinte !! ce n'est pas votre choix actuellement, et cela jusqu'au $fertilite_max_long_plus2"
	encore_jour_regle=$(( $fertilite_max_court_plus2_sec - $Test_date_aujourdhui_regle_sec ))
	encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
	say "patienter encore $encore_jour_regle jour"
	fi


	if [[ $Test_date_aujourdhui_regle_sec -le $fertilite_min_court_moin2_sec ]]; then		   
	encore_jour_regle=$(( $fertilite_min_court_moin2_sec - $Test_date_aujourdhui_regle_sec ))
	encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
	say "Allez-y, vous avez de la marge pendant $encore_jour_regle jours, soit jusqu'au $fertilite_min_long_moin2"
	fi

	if [[ $Test_date_aujourdhui_regle_sec -gt $fertilite_max_court_plus2_sec ]]; then
	encore_jour_regle=$(( $resultat_proch_regle_court_sec - $Test_date_aujourdhui_regle_sec ))
	encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
	say "Super vous avez depassé la date critique, vous pouvez faire l'amour pendant $encore_jour_regle jours, et même pendant les règles qui auront lieu vers le $resultat_proch_regle_long"
	fi
fi

}

jv_pg_ct_ovulation() {
fichier_existe_regle
On_est_le_regle
date_utilisateur_regle=""
calculdeovulation
erreur_ligne_vide_regle
resultat_date_regle
cycle_moyen_regle
encore_jour_regle=$(($resultat_ovulation_sec - $date_aujourdhui_regle_sec ))
encore_jour_regle=`date -d @$encore_jour_regle "+%d"`
say "Votre Prochaine Ovulation devrait être dans $encore_jour_regle jours, vers le $resultat_ovulation_long"

if [ "$Souhait_Enfant" = "oui" ]; then
echo "Votre période de fertilité sera maximale du $fertilite_min_long au $fertilite_max_long. En effet, c'est pendant cette période que vos rapports ont le plus de chance d’être fécondants."
else
# echo "Vous ne souhaites pas avoir d'enfant donc ne faites surtout pas l'amour sans protection entre le $fertilite_min_long au $fertilite_max_long"
echo "Vous ne souhaites pas avoir d'enfant donc faites l'amour depuis les dernières règles le $derniere_date_regle_long jusqu'au `date -d "$fertilite_min_court -2 days" "+%A %d %B %Y"`"
echo "puis, vous le pourrez à nouveau après le `date -d "$fertilite_max_court +2 days" "+%A %d %B %Y"` jusqu'au prochaines règles le $resultat_proch_regle_long"
fi
}


jv_pg_ct_enreg_prog_complet_regle() {
On_est_le_regle
date_utilisateur_regle=""
# ################ Je vérifier si le Fichier de date des règles moyen exite:
cycle_moyen_regle
erreur_ligne_vide_regle
echo "Je férifie si la date du $date_cycle_jour_regle $date_cycle_mois_regle_long, correspond avec votre cycle moyen de $cyclemoyen_regle jours"

# ################ Je vérifier si le cycle moyen exite correspond au jour à enregistrer = aujourd'hui :

lignenumero="$nbr_ligne_enregistree_regle"
calculdiffentredeuxdate_regle_addition="0"

while test  "$lignenumero" != "1"
do
nbr_ligne_enregistree_regle_lire3=`grep '' $cycle_regles_chemin | sed -n $lignenumero\p` # 2 ligne Num 3
lignenumero=$(( $lignenumero - 1 ))
nbr_ligne_enregistree_regle_lire2=`grep '' $cycle_regles_chemin | sed -n $lignenumero\p` # 1 ligne Num 2
# Soustrait 2 date pour calculer le nombre de jour entre ces deux
calculdiffentredeuxdate_regle=`echo $((($(date -d "$nbr_ligne_enregistree_regle_lire3" +%s)-$(date -d "$nbr_ligne_enregistree_regle_lire2" +%s))/86400))`
# echo "-- différence entre les dates : $calculdiffentredeuxdate_regle"
calculdiffentredeuxdate_regle_addition=$(( $calculdiffentredeuxdate_regle_addition + $calculdiffentredeuxdate_regle ))
done


# echo "-- l'addition de celle ci = $calculdiffentredeuxdate_regle_addition"

# calcul la moyenne de jour entre plusieurs chiffre
let calculdiffentredeuxdate_regle_addition="$calculdiffentredeuxdate_regle_addition / $(( $nbr_ligne_enregistree_regle - 1 ))"
# echo "-- la moyenne = $calculdiffentredeuxdate_regle_addition"
echo "$calculdiffentredeuxdate_regle_addition" > $cyclemoyen_chemin

# ################ Je regarde si cette date est déja enregistré dans le fichier 
# je dois vérifier si j'ai déja enregistré cette date si non je le fait !
regle_enregistree=`grep -c $date_cycle_mois_regle_court/$date_cycle_jour_regle/$date_cycle_annee_regle $cycle_regles_chemin`
regle_enregistree_moins1=`grep '' $cycle_regles_chemin | sed -n $nbr_ligne_enregistree_regle\p`
regle_enregistree_Test=`echo $((($(date -d "$regle_enregistree_moins1" +%s)-$(date -d "$regle_enregistree" +%s))/86400))`

if [[ "$regle_enregistree_Test" -le "$cyclemoyen_regle" ]]; then
echo "Il doit peut-être y avoir une erreur de date car $regle_enregistree_Test jour de moyenne est plus petit que la moyenne de votre cycle normal de $cyclemoyen_regle Jours "
else
if [[ "$regle_enregistree" -ge "1" ]]; then
echo "date déja enregistrée"
else
echo "---- date NON enregistrée ----"
echo "$date_cycle_mois_regle_court/$date_cycle_jour_regle/$date_cycle_annee_regle" >> $cycle_regles_chemin
fi
fi

# ################  Calcul Ovulation
calculdeovulation
echo "La date présumée de votre prochaine ovulation est le : $resultat_ovulation_long "
echo "Votre période de fertilité sera maximale du $fertilite_min au $fertilite_max. En effet, c'est pendant cette période que vos rapports ont le plus de chance d’être fécondants."
}

jv_pg_ct_enreg_aujourdui_regle() {
date_utilisateur_regle=`date "+%m/%d/%y"`
fichier_existe_enreg_regle
On_est_le_regle
# date_utilisateur_regle="$date_cycle_mois_regle_court/$date_cycle_jour_regle/$date_cycle_annee_regle"
jv_pg_ct_enreg_aujourdui_regle_GO
}

jv_pg_ct_enreg_aujourdui_regle_GO() {
erreur_ligne_vide_regle
cycle_moyen_regle

# say "Je férifie si la date du $date_cycle_jour_regle $date_cycle_mois_regle_long, correspondrai avec votre cycle moyen de $cyclemoyen_regle jours"

# ################ Je vérifier si le cycle moyen exite correspond au jour à enregistrer = aujourd'hui :



# echo "-- l'addition de celle ci = $calculdiffentredeuxdate_regle_addition"

# ################ Je regarde si cette date est déja enregistré dans le fichier 
# je dois vérifier si j'ai déja enregistré cette date si non je le fait !
regle_enregistree=`grep -c $date_utilisateur_regle $cycle_regles_chemin`
regle_enregistree_moins1=`grep '' $cycle_regles_chemin | sed -n $nbr_ligne_enregistree_regle\p`
regle_enregistree_Test=`echo $((($(date -d "$regle_enregistree_moins1" +%s)-$(date -d "$regle_enregistree" +%s))/86400)) | sed -e "s/-//g"`
if [[ "$regle_enregistree" -ge "1" ]]; then
	say "Je l'ai déja enregistré à la date d'aujourd'hui..."
else
	if [[ "$regle_enregistree_Test" -le "$(( $cyclemoyen_regle - 4 ))" ]]; then
	say "Il doit peut-être y avoir une erreur, avec la date du  `date -d $date_utilisateur_regle "+%A %d %B %Y"`, ce qui donnerai une moyenne de  $regle_enregistree_Test jour, au lieu de $cyclemoyen_regle Jours."
	say "Je ne l'enregsitre pas."
	else
	say "Ok, je l'enregistre"
	echo "$date_utilisateur_regle" >> $cycle_regles_chemin
	fi
fi
}

jv_pg_ct_enreg_regle_nouvelldate() {
if [[ "`echo $date_utilisateur_regle | sed -e "s/\//^ /g" | grep "\^" |  wc -w`" == "3" ]]; then 
date_utilisateur_regle_jour=`echo "$date_utilisateur_regle" | cut -d"/" -f1`
date_utilisateur_regle_mois_court=`echo "$date_utilisateur_regle" | cut -d"/" -f2`
date_utilisateur_regle_annee=`echo "$date_utilisateur_regle" | cut -d"/" -f3`
date_utilisateur_regle=`echo "$date_utilisateur_regle_mois_court/$date_utilisateur_regle_jour/$date_utilisateur_regle_annee"`
date_utilisateur_regle_mois_long=`date -d "$derniere_date_regle_court" "+%B"`
fichier_existe_enreg_regle
On_est_le_regle
jv_pg_ct_enreg_aujourdui_regle_GO
else
date_utilisateur_regle=`echo "$date_utilisateur_regle" | sed -e "s/le //g"`
date_utilisateur_regle_jour=`echo "$date_utilisateur_regle" | cut -d" " -f1`
date_utilisateur_regle_mois_long=`echo "$date_utilisateur_regle" | cut -d" " -f2`
date_utilisateur_regle_annee=`echo "$date_utilisateur_regle" | cut -d" " -f3`
echo "$date_utilisateur_regle"
testlemoisinverse_regle
testlejourinverse_regle
if [[ "$date_utilisateur_regle_mois_long" == "" ]]; then
say "J'ai un problème de reconnaissance avec le mois énnoncée, veuillez reformuler"
fi

if [[ "$date_utilisateur_regle_annee" == "" ]]; then
date_utilisateur_regle_annee=`date "+%y"`
fi
say "vous me demandez d'enregistrer le $date_utilisateur_regle_mois_court/$date_utilisateur_regle_jour/$date_utilisateur_regle_annee"
date_utilisateur_regle="$date_utilisateur_regle_mois_court/$date_utilisateur_regle_jour/$date_utilisateur_regle_annee"

fichier_existe_enreg_regle
On_est_le_regle
jv_pg_ct_enreg_aujourdui_regle_GO
fi
}


erreur_ligne_vide_regle() {
# corrige erreur ESPACE FIN DU FICHIER: fichier date_cycle_regles.txt
nbr_ligne_enregistree_regle=`grep -n  '' $cycle_regles_chemin | wc -w`
regle_enregistree_moins1=`grep '' $cycle_regles_chemin | sed -n $nbr_ligne_enregistree_regle\p`
if [[ $regle_enregistree_moins1 == "" ]]; then 
sed -i '$d' $cycle_regles_chemin
nbr_ligne_enregistree_regle=`grep -n  '' $cycle_regles_chemin | wc -w`
erreur_ligne_vide_regle
else
return
fi
}


jv_pg_ct_enreg_regle() {
say "enreg règle"
}

calculdeovulation() {
cyclemoyen_regle=`cat $cyclemoyen_chemin`
if [ $cyclemoyen_regle = "21" ]
then
ovulation="7"

elif [ $cyclemoyen_regle = "22" ]
then
ovulation="8"

elif [ $cyclemoyen_regle = "23" ]
then
ovulation="9"

elif [ $cyclemoyen_regle = "24" ]
then
ovulation="10"

elif [ $cyclemoyen_regle = "25" ]
then
ovulation="11"

elif [ $cyclemoyen_regle = "26" ]
then
ovulation="12"

elif [ $cyclemoyen_regle = "27" ]
then
ovulation="13"

elif [ $cyclemoyen_regle = "28" ]
then
ovulation="14"

elif [ $cyclemoyen_regle = "29" ]
then
ovulation="15"

elif [ $cyclemoyen_regle = "30" ]
then
ovulation="16"

elif [ $cyclemoyen_regle = "31" ]
then
ovulation="17"

elif [ $cyclemoyen_regle = "32" ]
then
ovulation="18"

elif [ $cyclemoyen_regle = "33" ]
then
ovulation="19"
fi
}

testlemoisinverse_regle() {
if [[ "$date_utilisateur_regle_mois_long" == "janvier" ]]; then
date_utilisateur_regle_mois_court="01"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "fevrier" ]]; then
date_utilisateur_regle_mois_court="02"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "mars" ]]; then
date_utilisateur_regle_mois_court="03"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "avril" ]]; then
date_utilisateur_regle_mois_court="04"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "mai" ]]; then
date_utilisateur_regle_mois_court="05"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "juin" ]]; then
date_utilisateur_regle_mois_court="06"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "juillet" ]]; then
date_utilisateur_regle_mois_court="07"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "aout" ]]; then
date_utilisateur_regle_mois_court="08"
return
fi


if [[ "$date_utilisateur_regle_mois_long" == "septembre" ]]; then
date_utilisateur_regle_mois_court="09"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "octobre" ]]; then
date_utilisateur_regle_mois_court="10"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "novembre" ]]; then
date_utilisateur_regle_mois_court="11"
return
fi

if [[ "$date_utilisateur_regle_mois_long" == "decembre" ]]; then
date_utilisateur_regle_mois_court="12"
return
fi
}

testlejourinverse_regle() {
if [[ "$date_utilisateur_regle_jour" == "1" ]]; then
date_utilisateur_regle_jour="01"
return
fi

if [[ "$date_utilisateur_regle_jour" == "2" ]]; then
date_utilisateur_regle_jour="02"
return
fi

if [[ "$date_utilisateur_regle_jour" == "3" ]]; then
date_utilisateur_regle_jour="03"
return
fi

if [[ "$date_utilisateur_regle_jour" == "4" ]]; then
date_utilisateur_regle_jour="04"
return
fi

if [[ "$date_utilisateur_regle_jour" == "5" ]]; then
date_utilisateur_regle_jour="05"
return
fi

if [[ "$date_utilisateur_regle_jour" == "6" ]]; then
date_utilisateur_regle_jour="06"
return
fi

if [[ "$date_utilisateur_regle_jour" == "7" ]]; then
date_utilisateur_regle_jour="07"
return
fi

if [[ "$date_utilisateur_regle_jour" == "8" ]]; then
date_utilisateur_regle_jour="08"
return
fi

if [[ "$date_utilisateur_regle_jour" == "9" ]]; then
date_utilisateur_regle_jour="09"
return
fi
}


On_est_le_regle() {
date_cycle_jour_regle=`date +%d`
date_aujourdhui_regle_sec=`date +%s`
date_cycle_mois_regle_court=`date +%m`
date_cycle_mois_regle_long=`date +%B`
date_cycle_annee_regle=`date +%y`
}

resultat_date_regle() {
resultat_ovulation_long=`date -d "$date_utilisateur_regle $ovulation days" "+%A %d %B %Y"`
resultat_ovulation_court=`date -d "$date_utilisateur_regle $ovulation days" "+%m/%d/%y"`
resultat_ovulation_sec=`date -d "$resultat_ovulation_court" +%s`
fertilite_min_long=`date -d "$date_utilisateur_regle $resultat_ovulation_court -4 days" "+%A %d %B %Y"`
fertilite_max_long=`date -d "$date_utilisateur_regle $resultat_ovulation_court 1 days" "+%A %d %B %Y"`
fertilite_min_court=`date -d "$date_utilisateur_regle $resultat_ovulation_court -4 days" "+%m/%d/%Y"`
fertilite_max_court=`date -d "$date_utilisateur_regle $resultat_ovulation_court 1 days" "+%m/%d/%Y"`

resultat_proch_regle_long=`date -d "$date_utilisateur_regle $cyclemoyen_regle days" "+%A %d %B %Y"`
resultat_proch_regle_court=`date -d "$date_utilisateur_regle $cyclemoyen_regle days" "+%m/%d/%y"`

fertilite_min_court_moin2_sec=`date -d "$fertilite_min_court -2 days" +%s`
fertilite_min_long_moin2=`date -d "$fertilite_min_court -2 days" "+%A %d %B %Y"`
fertilite_min_court_moin2_sec=`date -d "$fertilite_min_court -2 days" +%s`
fertilite_min_court_sec=`date -d "$fertilite_min_court" +%s`
fertilite_max_court_plus2_sec=`date -d "$fertilite_max_court 2 days" +%s`
fertilite_max_long_plus2=`date -d "$fertilite_max_court 2 days" "+%A %d %B %Y"`
fertilite_max_court_plus2_sec=`date -d "$fertilite_max_court 2 days" +%s`
fertilite_max_court_sec=`date -d "$fertilite_max_court" +%s`
resultat_proch_regle_court_sec=`date -d "$resultat_proch_regle_court" +%s`
}

cycle_moyen_regle() {
derniere_date_regle_court_sec=""
nbr_ligne_enregistree_regle=`grep -n  '' $cycle_regles_chemin | wc -w`
lignenumero="$nbr_ligne_enregistree_regle"
calculdiffentredeuxdate_regle_addition="0"

while test  "$lignenumero" != "1"
do

nbr_ligne_enregistree_regle_lire3=`grep '' $cycle_regles_chemin | sed -n $lignenumero\p` # 2 ligne Num 3
lignenumero=$(( $lignenumero - 1 ))
if [ "$lignenumero" = "0" ]; then return; fi
nbr_ligne_enregistree_regle_lire2=`grep '' $cycle_regles_chemin | sed -n $lignenumero\p` # 1 ligne Num 2
# Soustrait 2 date pour calculer le nombre de jour entre ces deux
calculdiffentredeuxdate_regle=`echo $((($(date -d "$nbr_ligne_enregistree_regle_lire3" +%s)-$(date -d "$nbr_ligne_enregistree_regle_lire2" +%s))/86400))`
# echo "-- différence entre les dates : $calculdiffentredeuxdate_regle"
calculdiffentredeuxdate_regle_addition=$(( $calculdiffentredeuxdate_regle_addition + $calculdiffentredeuxdate_regle ))

done



# calcul la moyenne de jour entre plusieurs chiffre
let calculdiffentredeuxdate_regle_addition="$calculdiffentredeuxdate_regle_addition / $(( $nbr_ligne_enregistree_regle - 1 ))"
# echo "-- la moyenne = $calculdiffentredeuxdate_regle_addition"
echo "$calculdiffentredeuxdate_regle_addition" > $cyclemoyen_chemin
derniere_date_regle_court=`grep '' $cycle_regles_chemin | sed -n $nbr_ligne_enregistree_regle\p`
derniere_date_regle_court_sec=`date -d "$derniere_date_regle_court_sec" +%s`
derniere_date_regle_long=`date -d "$derniere_date_regle_court" "+%A %d %B %Y"`

}

fichier_existe_enreg_regle() {
if [ -f "$cycle_regles_chemin" ]; then # Si le fichier existe ? Remise à 0 du compteur si 2 fois Off
cyclemoyen_regle=`cat $cyclemoyen_chemin`
else
say "N'ayant aucune base de donnée, je prends votre cycle moyen enregistrée dans le fichier de configuration de $Votre_cylcemoyen_aujourdhui jours"
say "Que je soustrais à la date $date_utilisateur_regle"
say "Voilà vos fichiers de configurations sont prêt..."
date_cycle_moins_1=`date -d "$date_utilisateur_regle - $(( $Votre_cylcemoyen_aujourdhui +1 )) days" "+%m/%d/%y"`
echo "$date_cycle_moins_1" > $cycle_regles_chemin
date -d $date_utilisateur_regle "+%m/%d/%y" >> $cycle_regles_chemin
echo "$Votre_cylcemoyen_aujourdhui" > $cyclemoyen_chemin
fi
}

fichier_existe_regle() {
cheminacces_regle
if [ -f "$cycle_regles_chemin" ]; then # Si le fichier existe ? Remise à 0 du compteur si 2 fois Off
return
else
say "Je ne peux rien évaluer car je n'ai aucune base de donnée... Veuillez commencer par exécuter la commande: Jarvis enregistre mes règles"
exit
fi
}


jv_pg_ct_liste_regle() {
cheminacces_regle
fichier_existe_regle
nbr_ligne_enregistree_regle=`grep -n  '' $cycle_regles_chemin | wc -w`
say "vous avez enregistré $nbr_ligne_enregistree_regle dates le: "
lignenumero=$nbr_ligne_enregistree_regle
while test  "$lignenumero" != "0"
do
nbr_ligne_enregistree_regle_lire_voix=`grep '' $cycle_regles_chemin | sed -n $lignenumero\p`
date_cycle_jour_regle=`echo "$nbr_ligne_enregistree_regle_lire_voix" | cut -d"/" -f1`
date_cycle_mois_regle_court=`echo "$nbr_ligne_enregistree_regle_lire_voix" | cut -d"/" -f2`
date_cycle_mois_regle_long=`date -d "$nbr_ligne_enregistree_regle_lire_voix" "+%B"`
date_cycle_anne_regle=`echo "$nbr_ligne_enregistree_regle_lire_voix" | cut -d"/" -f3`
say "$date_cycle_jour_regle $date_cycle_mois_regle_long 20$date_cycle_anne_regle"
lignenumero=$(( $lignenumero -1 ))
done

}

jv_pg_ct_cylemoyen_regle() {
cheminacces_regle
fichier_existe_regle
cycle_moyen_regle
cyclemoyen_regle=`cat $cyclemoyen_chemin`
say "Votre cylce moyen enregistré actuellement est de $cyclemoyen_regle jours"
}


jv_pg_ct_envoicyvleemail() {
fichier_existe_regle
On_est_le_regle
calculdeovulation
erreur_ligne_vide_regle
resultat_date_regle
cycle_moyen_regle
echo "" > $cycleemail_chemin
echo "Dernière règle enregistrée le: $derniere_date_regle_long" >> $cycleemail_chemin
echo "Prochaine prévue vers le $resultat_proch_regle_long" >> $cycleemail_chemin
echo "Ovulation vers $resultat_ovulation_long" >> $cycleemail_chemin
echo "Votre choix avoir des enfants: $Souhait_Enfant" >> $cycleemail_chemin
mpack -s "Résumé du cycle menstruel: " $cycleemail_chemin "$votreemail_cycle"
sudo rm $cycleemail_chemin
say "Votre Cylce menstruel a été envoyer par Email à $votreemail_cycle"
}

jv_pg_ct_envoicyvleesms() {
fichier_existe_regle
On_est_le_regle
calculdeovulation
erreur_ligne_vide_regle
resultat_date_regle
cycle_moyen_regle
cheminacces_regle

cycleemail_cheminok_cycle=`echo "Dernière règle le: $derniere_date_regle_long. Prochaine prévue vers le $resultat_proch_regle_long. Votre choix avoir des enfants ? $Souhait_Enfant, attention Ovulation vers $resultat_ovulation_long "`


./jarvis.sh -x "MESSEXTERNE; $nom_sms_cycle; $cycleemail_cheminok_cycle"

say "Votre Cylce menstruel a été envoyer par SMS  $nom_sms_cycle"
}

