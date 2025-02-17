/mob/living/carbon/alien/get_eye_protection()
	return ..() + 2 //potential cyber implants + natural eye protection

/mob/living/carbon/alien/get_ear_protection()
	return 2 //no ears

/mob/living/carbon/alien/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	..(AM, skipcatch = TRUE, hitpush = FALSE)


/*Code for aliens attacking aliens. Because aliens act on a hivemind, I don't see them as very aggressive with each other.
As such, they can either help or harm other aliens. Help works like the human help command while harm is a simple nibble.
In all, this is a lot like the monkey code. /N
*/
/mob/living/carbon/alien/attack_alien(mob/living/carbon/alien/M)
	if(isturf(loc) && istype(loc.loc, /area/start))
		to_chat(M, "No attacking people at spawn, you jackass.")
		return

	switch(M.a_intent)
		if("help")
			if(M == src && check_self_for_injuries())
				return
			set_resting(FALSE)
			AdjustStun(-60)
			AdjustKnockdown(-60)
			AdjustImmobilized(-60)
			AdjustParalyzed(-60)
			AdjustUnconscious(-60)
			AdjustSleeping(-100)
			visible_message(span_notice("[M.name] nuzzles [src] trying to wake [p_them()] up!"))

		if("grab")
			grabbedby(M)

		else
			if(health > 1)
				M.do_attack_animation(src, ATTACK_EFFECT_BITE)
				playsound(loc, 'sound/weapons/bite.ogg', 50, 1, -1)
				visible_message(span_danger("[M.name] playfully bites [src]!"), \
						span_userdanger("[M.name] playfully bites you!"), null, COMBAT_MESSAGE_RANGE)
				to_chat(M, span_danger("You playfully bite [src]!"))
				adjustBruteLoss(1)
				log_combat(M, src, "attacked", M)
				updatehealth()
			else
				to_chat(M, span_warning("[name] is too injured for that."))


/mob/living/carbon/alien/attack_larva(mob/living/carbon/alien/larva/L)
	return attack_alien(L)

/mob/living/carbon/alien/attack_paw(mob/living/carbon/monkey/M)
	if(!..())
		return
	if(stat != DEAD)
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.get_combat_bodyzone(src)))
		apply_damage(rand(3), BRUTE, affecting)

/mob/living/carbon/alien/attack_hand(mob/living/carbon/human/M)
	if(..())	//to allow surgery to return properly.
		return

	switch(M.a_intent)
		if("harm", "disarm") //harm and disarm will do the same, I doubt trying to shove a xeno would go well for you
			if(HAS_TRAIT(M, TRAIT_PACIFISM))
				to_chat(M, span_notice("You don't want to hurt [src]!"))
				return
			playsound(loc, "punch", 25, 1, -1)
			visible_message(span_danger("[M] punches [src]!"), \
					span_userdanger("[M] punches you!"), null, COMBAT_MESSAGE_RANGE)
			var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.get_combat_bodyzone(src)))
			apply_damage(M.dna.species.punchdamage, BRUTE, affecting)
			log_combat(M, src, "attacked", M)
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)

		if("help")
			M.visible_message(span_notice("[M] hugs [src] to make [src.p_them()] feel better!"), \
								span_notice("You hug [src] to make [src.p_them()] feel better!"))
			playsound(M.loc, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)

		if("grab")
			grabbedby(M)

/mob/living/carbon/alien/attack_animal(mob/living/simple_animal/M)
	if(!..())
		return
	var/damage = M.melee_damage
	switch(M.melee_damage_type)
		if(BRUTE)
			adjustBruteLoss(damage)
		if(BURN)
			adjustFireLoss(damage)
		if(TOX)
			adjustToxLoss(damage)
		if(OXY)
			adjustOxyLoss(damage)
		if(CLONE)
			adjustCloneLoss(damage)
		if(STAMINA)
			adjustStaminaLoss(damage)

/mob/living/carbon/alien/attack_slime(mob/living/simple_animal/slime/M)
	if(!..())
		return //gotta be a successful slime attack
	var/damage = rand(20)
	if(M.is_adult)
		damage = rand(30)
	if(M.transformeffects & SLIME_EFFECT_RED)
		damage *= 1.1
	adjustBruteLoss(damage)
	log_combat(M, src, "attacked", M)
	updatehealth()

/mob/living/carbon/alien/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	. = ..()
	if(QDELETED(src))
		return

	switch(severity)
		if(EXPLODE_DEVASTATE)
			gib()
			return

		if(EXPLODE_HEAVY)
			take_overall_damage(60, 60)
			adjustEarDamage(30,120)

		if(EXPLODE_LIGHT)
			take_overall_damage(30,0)
			if(prob(50))
				Unconscious(20)
			adjustEarDamage(15,60)

/mob/living/carbon/alien/soundbang_act(intensity = 1, stun_pwr = 20, damage_pwr = 5, deafen_pwr = 15)
	return FALSE

/mob/living/carbon/alien/acid_act(acidpwr, acid_volume)
	return FALSE//aliens are immune to acid.
