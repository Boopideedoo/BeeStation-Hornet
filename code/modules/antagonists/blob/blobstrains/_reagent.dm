/datum/blobstrain/reagent // Blobs that mess with reagents, all "legacy" ones // what do you mean "legacy" you never added an alternative
	var/datum/reagent/reagent

/datum/blobstrain/reagent/New(mob/camera/blob/new_overmind)
	. = ..()
	reagent = new reagent()


/datum/blobstrain/reagent/attack_living(mob/living/L)
	var/mob_protection = L.getarmor(null, BIO) * 0.01
	reagent.expose_mob(L, VAPOR, BLOB_REAGENTATK_VOL, 1, mob_protection, overmind)
	send_message(L)

/datum/blobstrain/reagent/blobbernaut_attack(mob/living/L)
	var/mob_protection = L.getarmor(null, BIO) * 0.01
	reagent.expose_mob(L, VAPOR, BLOBMOB_BLOBBERNAUT_REAGENTATK_VOL+blobbernaut_reagentatk_bonus, 0, mob_protection, overmind)//this will do between 10 and 20 damage(reduced by mob protection), depending on chemical, plus 4 from base brute damage.

/datum/blobstrain/reagent/on_sporedeath(mob/living/spore)
	spore.reagents.add_reagent(reagent.type, 10)

// These can only be applied by blobs. They are what (reagent) blobs are made out of.
/datum/reagent/blob
	name = "Unknown"
	description = "shouldn't exist and you should adminhelp immediately."
	color = "#FFFFFF"
	chem_flags = CHEMICAL_NOT_DEFINED
	taste_description = "bad code and slime"


/datum/reagent/blob/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/O)
	if(M.stat == DEAD || istype(M, /mob/living/simple_animal/hostile/blob))
		return 0 //the dead, and blob mobs, don't cause reactions
	return round(reac_volume * min(1.5 - touch_protection, 1), 0.1) //full touch protection means 50% volume, any prot below 0.5 means 100% volume.
