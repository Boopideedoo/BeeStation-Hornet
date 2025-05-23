
//sets you on fire, does burn damage, explodes into flame when burnt, weak to water
/datum/blobstrain/reagent/blazing_oil
	name = "Blazing Oil"
	description = "will do medium burn damage and set targets on fire."
	effectdesc = "will also release bursts of flame when burnt, but takes damage from water."
	analyzerdescdamage = "Does medium burn damage and sets targets on fire."
	analyzerdesceffect = "Releases fire when burnt, but takes damage from water and other extinguishing liquids."
	color = "#B68D00"
	complementary_color = "#BE5532"
	blobbernaut_message = "splashes"
	message = "The blob splashes you with burning oil"
	message_living = ", and you feel your skin char and melt"
	reagent = /datum/reagent/blob/blazing_oil
	fire_based = TRUE

/datum/blobstrain/reagent/blazing_oil/extinguish_reaction(obj/structure/blob/B)
	B.take_damage(1.5, BURN, ENERGY)

/datum/blobstrain/reagent/blazing_oil/damage_reaction(obj/structure/blob/B, damage, damage_type, damage_flag)
	if(damage_type == BURN && damage_flag != ENERGY)
		for(var/turf/open/T in RANGE_TURFS(1, B))
			var/obj/structure/blob/C = locate() in T
			if(!(C?.overmind && C.overmind.blobstrain.type == B.overmind.blobstrain.type) && prob(80))
				new /obj/effect/hotspot(T)
	if(damage_flag == FIRE)
		return 0
	return ..()

/datum/reagent/blob/blazing_oil
	name = "Blazing Oil"
	taste_description = "burning oil"
	color = "#B68D00"
	chem_flags = CHEMICAL_NOT_SYNTH | CHEMICAL_RNG_FUN

/datum/reagent/blob/blazing_oil/expose_mob(mob/living/M, method=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/O)
	reac_volume = ..()
	M.adjust_fire_stacks(round(reac_volume/10))
	M.IgniteMob()
	if(M)
		M.apply_damage(0.8*reac_volume, BURN)
	if(iscarbon(M))
		M.emote("scream")
