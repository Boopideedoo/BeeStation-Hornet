/obj/item/banhammer
	desc = "A banhammer."
	name = "banhammer"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	item_flags = ISWEAPON
	throw_speed = 3
	throw_range = 7
	attack_verb_continuous = list("bans")
	attack_verb_simple = list("ban")
	max_integrity = 200
	armor_type = /datum/armor/item_banhammer
	resistance_flags = FIRE_PROOF


/datum/armor/item_banhammer
	fire = 100
	acid = 70

/obj/item/banhammer/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is hitting [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to ban [user.p_them()]self from life."))
	return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/living/user)
	if(user.is_zone_selected(BODY_ZONE_HEAD, precise_only = FALSE))
		M.visible_message(span_danger("[user] are stroking the head of [M] with a bangammer"), span_userdanger("[user] are stroking the head with a bangammer"), "you hear a bangammer stroking a head");
	else
		M.visible_message(span_danger("[M] has been banned FOR NO REISIN by [user]"), span_userdanger("You have been banned FOR NO REISIN by [user]"), "you hear a banhammer banning someone")
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.combat_mode)
		return ..(M, user)

/obj/item/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 2
	throwforce = 1
	block_upgrade_walk = TRUE
	w_class = WEIGHT_CLASS_LARGE
	item_flags = ISWEAPON
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

/obj/item/sord/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is trying to impale [user.p_them()]self with [src]! It might be a suicide attempt if it weren't so shitty."), \
	span_suicide("You try to impale yourself with [src], but it's USELESS..."))
	return SHAME

/obj/item/sord/on_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", damage = 0, attack_type = MELEE_ATTACK)
	if(isitem(hitby))
		var/obj/item/I = hitby
		owner.attackby(src)
		owner.attackby(src, owner)
		owner.visible_message(span_danger("[owner] can't get a grip, and stabs himself with both the [I] and the[src] while trying to parry the [I]!"))
	return ..()

/obj/item/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = ISWEAPON
	attack_weight = 1
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_power = 40
	block_upgrade_walk = TRUE
	block_level = 1
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY
	sharpness = SHARP_DISMEMBER
	bleed_force = BLEED_DEEP_WOUND
	max_integrity = 200
	armor_type = /datum/armor/item_claymore
	resistance_flags = FIRE_PROOF


/datum/armor/item_claymore
	fire = 100
	acid = 50

/obj/item/claymore/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 40, 105)

/obj/item/claymore/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is falling on [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/claymore/highlander //ALL COMMENTS MADE REGARDING THIS SWORD MUST BE MADE IN ALL CAPS
	desc = "<b><i>THERE CAN BE ONLY ONE, AND IT WILL BE YOU!!!</i></b>\nActivate it in your hand to point to the nearest victim."
	flags_1 = CONDUCT_1
	item_flags = DROPDEL | ISWEAPON //dropdel occurs because you lost an arm
	slot_flags = null
	light_range = 3
	attack_verb_continuous = list("brutalizes", "eviscerates", "disembowels", "hacks", "carves", "cleaves") //ONLY THE MOST VISCERAL ATTACK VERBS
	attack_verb_simple = list("brutalize", "eviscerate", "disembowel", "hack", "carve", "cleave")
	var/notches = 0 //HOW MANY PEOPLE HAVE BEEN SLAIN WITH THIS BLADE
	var/obj/item/disk/nuclear/nuke_disk //OUR STORED NUKE DISK

/obj/item/claymore/highlander/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HIGHLANDER)
	START_PROCESSING(SSobj, src)

/obj/item/claymore/highlander/Destroy()
	if(nuke_disk)
		nuke_disk.forceMove(get_turf(src))
		nuke_disk.visible_message(span_warning("The nuke disk is vulnerable!"))
		nuke_disk = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/claymore/highlander/process()
	if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		loc.layer = LARGE_MOB_LAYER //NO HIDING BEHIND PLANTS FOR YOU, DICKWEED (HA GET IT, BECAUSE WEEDS ARE PLANTS)
		H.cauterise_wounds(0.1)
	else
		if(!(flags_1 & ADMIN_SPAWNED_1))
			qdel(src)


/obj/item/claymore/highlander/pickup(mob/living/user)
	. = ..()
	to_chat(user, span_notice("The power of Scotland protects you! You are shielded from all stuns and knockdowns."))
	user.add_stun_absorption("highlander", INFINITY, 1, " is protected by the power of Scotland!", "The power of Scotland absorbs the stun!", " is protected by the power of Scotland!")
	user.ignore_slowdown(HIGHLANDER)

/obj/item/claymore/highlander/dropped(mob/living/user)
	. = ..()
	user.unignore_slowdown(HIGHLANDER)

/obj/item/claymore/highlander/examine(mob/user)
	. = ..()
	. += "It has [!notches ? "nothing" : "[notches] notches"] scratched into the blade."
	if(nuke_disk)
		. += span_boldwarning("It's holding the nuke disk!")

/obj/item/claymore/highlander/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!QDELETED(target) && iscarbon(target) && target.stat == DEAD && target.mind && target.mind.special_role == "highlander")
		user.fully_heal() //STEAL THE LIFE OF OUR FALLEN FOES
		add_notch(user)
		target.visible_message(span_warning("[target] crumbles to dust beneath [user]'s blows!"), span_userdanger("As you fall, your body crumbles to dust!"))
		target.investigate_log("has been dusted by a highlander claymore.", INVESTIGATE_DEATHS)
		target.dust()

/obj/item/claymore/highlander/attack_self(mob/living/user)
	var/closest_victim
	var/closest_distance = 255
	for(var/mob/living/carbon/human/H in GLOB.player_list - user)
		if(H.client && H.mind.special_role == "highlander" && (!closest_victim || get_dist(user, closest_victim) < closest_distance))
			closest_victim = H
	if(!closest_victim)
		to_chat(user, span_warning("[src] thrums for a moment and falls dark. Perhaps there's nobody nearby."))
		return
	to_chat(user, span_danger("[src] thrums and points to the [dir2text(get_dir(user, closest_victim))]."))

/obj/item/claymore/highlander/IsReflect()
	return 1 //YOU THINK YOUR PUNY LASERS CAN STOP ME?

/obj/item/claymore/highlander/proc/add_notch(mob/living/user) //DYNAMIC CLAYMORE PROGRESSION SYSTEM - THIS IS THE FUTURE
	notches++
	force++
	var/new_name = name
	switch(notches)
		if(1)
			to_chat(user, span_notice("Your first kill - hopefully one of many. You scratch a notch into [src]'s blade."))
			to_chat(user, span_warning("You feel your fallen foe's soul entering your blade, restoring your wounds!"))
			new_name = "notched claymore"
		if(2)
			to_chat(user, span_notice("Another falls before you. Another soul fuses with your own. Another notch in the blade."))
			new_name = "double-notched claymore"
			add_atom_colour(rgb(255, 235, 235), ADMIN_COLOUR_PRIORITY)
		if(3)
			to_chat(user, "[span_notice("You're beginning to")] [span_danger("<b>relish</b> the <b>thrill</b> of <b>battle.</b>")]")
			new_name = "triple-notched claymore"
			add_atom_colour(rgb(255, 215, 215), ADMIN_COLOUR_PRIORITY)
		if(4)
			to_chat(user, "[span_notice("You've lost count of")] [span_boldannounce("how many you've killed.")]")
			new_name = "many-notched claymore"
			add_atom_colour(rgb(255, 195, 195), ADMIN_COLOUR_PRIORITY)
		if(5)
			to_chat(user, span_boldannounce("Five voices now echo in your mind, cheering the slaughter."))
			new_name = "battle-tested claymore"
			add_atom_colour(rgb(255, 175, 175), ADMIN_COLOUR_PRIORITY)
		if(6)
			to_chat(user, span_boldannounce("Is this what the vikings felt like? Visions of glory fill your head as you slay your sixth foe."))
			new_name = "battle-scarred claymore"
			add_atom_colour(rgb(255, 155, 155), ADMIN_COLOUR_PRIORITY)
		if(7)
			to_chat(user, span_boldannounce("Kill. Butcher. <i>Conquer.</i>"))
			new_name = "vicious claymore"
			add_atom_colour(rgb(255, 135, 135), ADMIN_COLOUR_PRIORITY)
		if(8)
			to_chat(user, span_userdanger("IT NEVER GETS OLD. THE <i>SCREAMING</i>. THE <i>BLOOD</i> AS IT <i>SPRAYS</i> ACROSS YOUR <i>FACE.</i>"))
			new_name = "bloodthirsty claymore"
			add_atom_colour(rgb(255, 115, 115), ADMIN_COLOUR_PRIORITY)
		if(9)
			to_chat(user, span_userdanger("ANOTHER ONE FALLS TO YOUR BLOWS. ANOTHER WEAKLING UNFIT TO LIVE."))
			new_name = "gore-stained claymore"
			add_atom_colour(rgb(255, 95, 95), ADMIN_COLOUR_PRIORITY)
		if(10)
			user.visible_message(span_warning("[user]'s eyes light up with a vengeful fire!"), \
			span_userdanger("YOU FEEL THE POWER OF VALHALLA FLOWING THROUGH YOU! <i>THERE CAN BE ONLY ONE!!!</i>"))
			user.update_icons()
			new_name = "GORE-DRENCHED CLAYMORE OF [pick("THE WHIMSICAL SLAUGHTER", "A THOUSAND SLAUGHTERED CATTLE", "GLORY AND VALHALLA", "ANNIHILATION", "OBLITERATION")]"
			icon_state = "claymore_valhalla"
			item_state = "cultblade"
			remove_atom_colour(ADMIN_COLOUR_PRIORITY)

	name = new_name
	playsound(user, 'sound/items/screwdriver2.ogg', 50, 1)

/obj/item/claymore/bone
	name = "Bone Sword"
	desc = "Jagged pieces of bone are tied to what looks like a goliaths femur."
	icon_state = "bone_sword"
	item_state = "bone_sword"
	worn_icon_state = "claymore"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 15
	throwforce = 10
	armour_penetration = 15
	w_class = WEIGHT_CLASS_LARGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_level = 0
	block_power = 30
	armor_type = /datum/armor/claymore_bone


/datum/armor/claymore_bone
	fire = 100
	acid = 50

/obj/item/katana
	name = "katana"
	desc = "Woefully underpowered in D20."
	icon_state = "katana"
	item_state = "katana"
	worn_icon_state = "katana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ISWEAPON
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_power = 20
	block_level = 1
	block_upgrade_walk = TRUE
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY | BLOCKING_PROJECTILE
	sharpness = SHARP_DISMEMBER
	bleed_force = BLEED_DEEP_WOUND
	max_integrity = 200
	armor_type = /datum/armor/item_katana
	resistance_flags = FIRE_PROOF


/datum/armor/item_katana
	fire = 100
	acid = 50

/obj/item/katana/cursed
	slot_flags = null

/obj/item/katana/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is slitting [user.p_their()] stomach open with [src]! It looks like [user.p_theyre()] trying to commit seppuku!"))
	return BRUTELOSS

/obj/item/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags_1 = CONDUCT_1
	force = 9
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = ISWEAPON
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=75)
	attack_verb_continuous = list("hits", "bludgeons", "whacks", "bonks")
	attack_verb_simple = list("hit", "bludgeon", "whack", "bonk")

/obj/item/wirerod/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/shard))
		var/obj/item/spear/S = new /obj/item/spear

		remove_item_from_storage(user)
		if (!user.transferItemToLoc(I, S))
			return
		S.CheckParts(list(I))
		qdel(src)

		user.put_in_hands(S)
		log_crafting(user, S, TRUE)
		to_chat(user, span_notice("You fasten the glass shard to the top of the rod with the cable."))

	else if(istype(I, /obj/item/assembly/igniter) && !(HAS_TRAIT(I, TRAIT_NODROP)))
		var/obj/item/melee/baton/cattleprod/P = new /obj/item/melee/baton/cattleprod

		remove_item_from_storage(user)

		to_chat(user, span_notice("You fasten [I] to the top of the rod with the cable."))

		qdel(I)
		qdel(src)

		user.put_in_hands(P)
		log_crafting(user, P, TRUE)
	else
		return ..()


/obj/item/throwing_star
	name = "throwing star"
	desc = "An ancient weapon still used to this day, due to its ease of lodging itself into its victim's body parts."
	icon_state = "throwingstar"
	item_state = "eshield0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 2
	throwforce = 24
	throw_speed = 4
	embedding = list("pain_mult" = 4, "embed_chance" = 300, "fall_chance" = 0, "armour_block" = 70)
	armour_penetration = 40
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ISWEAPON
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP
	bleed_force = BLEED_CUT
	custom_materials = list(/datum/material/iron=500, /datum/material/glass=500)
	resistance_flags = FIRE_PROOF

/obj/item/throwing_star/stamina
	name = "shock throwing star"
	desc = "An aerodynamic disc designed to cause excruciating pain when stuck inside fleeing targets, hopefully without causing fatal harm."
	throwforce = 5
	embedding = list("pain_chance" = 5, "embed_chance" = 300, "fall_chance" = 0, "jostle_chance" = 10, "pain_stam_pct" = 0.8, "jostle_pain_mult" = 3, "armour_block" = 70)

/obj/item/throwing_star/toy
	name = "toy throwing star"
	desc = "An aerodynamic disc strapped with adhesive for sticking to people, good for playing pranks and getting yourself killed by security."
	sharpness = BLUNT
	force = 0
	throwforce = 0
	embedding = list("pain_mult" = 0, "jostle_pain_mult" = 0, "embed_chance" = 300, "fall_chance" = 25, "armour_block" = 70)

/obj/item/throwing_star/magspear
	name = "magnetic spear"
	desc = "A reusable spear that is typically loaded into kinetic spearguns."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "magspear"
	throwforce = 40
	force = 15 //can be used in melee- a speargun user may be beat to death with their own spear
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_range = 0 //throwing these invalidates the speargun
	attack_verb_continuous = list("stabs", "rips", "gores", "impales")
	attack_verb_simple = list("stab", "rip", "gore", "impale")
	embedding = list("pain_mult" = 8, "embed_chance" = 1000, "fall_chance" = 0, "armour_block" = 100)

/obj/item/switchblade
	name = "long switchblade"
	icon_state = "switchblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharp, concealable, spring-loaded knife with a long blade."
	flags_1 = CONDUCT_1
	force = 3
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ISWEAPON
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=12000)
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb_continuous = list("stubs", "pokes")
	attack_verb_simple = list("stub", "poke")
	resistance_flags = FIRE_PROOF
	var/extended = 0
	var/extended_force = 20
	var/extended_throwforce = 23
	var/extended_icon_state = "switchblade_ext"

/obj/item/switchblade/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	if(extended)
		force = extended_force
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb_continuous = list("slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
		attack_verb_simple = list("slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = SHARP
		bleed_force = BLEED_CUT
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_SMALL
		throwforce = initial(throwforce)
		icon_state = initial(icon_state)
		attack_verb_continuous = list("stubs", "pokes")
		attack_verb_simple = list("stub", "poke")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = BLUNT
		bleed_force = 0

/obj/item/switchblade/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is slitting [user.p_their()] own throat with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/switchblade/kitchen
	name = "iron switchblade"
	icon_state = "switchblade_ms"
	desc = "A concealable spring-loaded knife with an iron blade."
	force = 2
	throwforce = 3
	extended_force = 12
	extended_throwforce = 15
	extended_icon_state = "switchblade_ext_ms"

/obj/item/switchblade/plastitanium
	name = "plastitanium switchblade"
	icon_state = "switchblade_msf"
	desc = "A concealable spring-loaded knife with a plastitanium blade."
	force = 3
	throwforce = 4
	extended_force = 15
	extended_throwforce = 17
	extended_icon_state = "switchblade_ext_msf"

/obj/item/phone
	name = "red phone"
	desc = "Should anything ever go wrong..."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ISWEAPON
	attack_verb_continuous = list("calls", "rings")
	attack_verb_simple = list("call", "ring")
	hitsound = 'sound/weapons/ring.ogg'

/obj/item/phone/suicide_act(mob/living/user)
	if(locate(/obj/structure/chair/stool) in user.loc)
		user.visible_message(span_suicide("[user] begins to tie a noose with [src]'s cord! It looks like [user.p_theyre()] trying to commit suicide!"))
	else
		user.visible_message(span_suicide("[user] is strangling [user.p_them()]self with [src]'s cord! It looks like [user.p_theyre()] trying to commit suicide!"))
	return OXYLOSS

/obj/item/cane
	name = "cane"
	desc = "A cane used by a true gentleman. Or a clown."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	block_upgrade_walk = TRUE
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb_continuous = list("bludgeons", "whacks", "disciplines", "thrashes")
	attack_verb_simple = list("bludgeon", "whack", "discipline", "thrash")

/obj/item/staff
	name = "wizard staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	block_upgrade_walk = TRUE
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	item_flags = ISWEAPON
	armour_penetration = 100
	attack_verb_continuous = list("bludgeons", "whacks", "disciplines")
	attack_verb_simple = list("bludgeon", "whack", "discipline")
	resistance_flags = FLAMMABLE

/obj/item/staff/broom
	name = "broom"
	desc = "Used for sweeping, and flying into the night while cackling. Black cat not included."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"
	resistance_flags = FLAMMABLE

/obj/item/staff/stick
	name = "stick"
	desc = "A great tool to drag someone else's drinks across the bar."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ectoplasm
	name = "ectoplasm"
	desc = "Spooky."
	gender = PLURAL
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ectoplasm"

/obj/item/ectoplasm/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is inhaling [src]! It looks like [user.p_theyre()] trying to visit the astral plane!"))
	return OXYLOSS

/obj/item/ectoplasm/angelic
	icon = 'icons/obj/wizard.dmi'
	icon_state = "angelplasm"

/obj/item/ectoplasm/mystic
	icon_state = "mysticplasm"

/obj/item/mounted_chainsaw
	name = "mounted chainsaw template"
	desc = "A chainsaw that has replaced your arm."
	icon_state = "chainsaw_on"
	item_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL | ISWEAPON
	w_class = WEIGHT_CLASS_HUGE
	block_upgrade_walk = 2
	block_power = 20
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY
	force = 24
	attack_weight = 2
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	sharpness = SHARP_DISMEMBER
	bleed_force = BLEED_DEEP_WOUND
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/mounted_chainsaw/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/mounted_chainsaw/normal
	name = "mounted chainsaw"

/obj/item/mounted_chainsaw/normal/Destroy()
	var/obj/item/bodypart/part
	new /obj/item/chainsaw(get_turf(src))
	if(iscarbon(loc))
		var/mob/living/carbon/holder = loc
		var/index = holder.get_held_index_of_item(src)
		if(index)
			part = holder.hand_bodyparts[index]
	. = ..()
	if(part)
		part.drop_limb()

/obj/item/mounted_chainsaw/energy
	name = "mounted energy chainsaw"
	desc = "An energy chainsaw that has replaced your arm."
	force = 40
	armour_penetration = 50
	hitsound = 'sound/weapons/echainsawhit1.ogg'

/obj/item/mounted_chainsaw/energy/Destroy()
	var/obj/item/bodypart/part
	new /obj/item/chainsaw/energy(get_turf(src))
	if(iscarbon(loc))
		var/mob/living/carbon/holder = loc
		var/index = holder.get_held_index_of_item(src)
		if(index)
			part = holder.hand_bodyparts[index]
	. = ..()
	if(part)
		part.drop_limb()

/obj/item/mounted_chainsaw/super
	name = "mounted super energy chainsaw"
	desc = "A super energy chainsaw that has replaced your arm."
	force = 60
	armour_penetration = 75
	hitsound = 'sound/weapons/echainsawhit1.ogg'

/obj/item/mounted_chainsaw/super/Destroy()
	var/obj/item/bodypart/part
	new /obj/item/chainsaw/energy/doom(get_turf(src))
	if(iscarbon(loc))
		var/mob/living/carbon/holder = loc
		var/index = holder.get_held_index_of_item(src)
		if(index)
			part = holder.hand_bodyparts[index]
	. = ..()
	if(part)
		part.drop_limb()

/obj/item/mounted_chainsaw/super/attack(mob/living/target)
	..()
	target.Knockdown(4)

/obj/item/statuebust
	name = "bust"
	desc = "A priceless ancient marble bust, the kind that belongs in a museum." //or you can hit people with it
	icon = 'icons/obj/statue.dmi'
	icon_state = "bust"
	force = 15
	attack_weight = 2
	throwforce = 10
	throw_speed = 5
	throw_range = 2
	attack_verb_continuous = list("busts")
	attack_verb_simple = list("bust")
	var/impressiveness = 45

/obj/item/statuebust/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/art, impressiveness)

/obj/item/statuebust/hippocratic
	name = "hippocrates bust"
	desc = "A bust of the famous Greek physician Hippocrates of Kos, often referred to as the father of western medicine."
	icon_state = "hippocratic"
	impressiveness = 50

/obj/item/melee/chainofcommand/tailwhip
	name = "liz o' nine tails"
	desc = "A whip fashioned from the severed tails of lizards."
	icon_state = "tailwhip"
	item_flags = NONE

/obj/item/melee/chainofcommand/tailwhip/kitty
	name = "cat o' nine tails"
	desc = "A whip fashioned from the severed tails of cats."
	icon_state = "catwhip"

/obj/item/melee/skateboard
	name = "improvised skateboard"
	desc = "A skateboard. It can be placed on its wheels and ridden, or used as a strong weapon."
	icon_state = "skateboard"
	item_state = "skateboard"
	block_upgrade_walk = TRUE
	force = 12
	throwforce = 4
	w_class = WEIGHT_CLASS_LARGE
	attack_verb_continuous = list("smacks", "whacks", "slams", "smashes")
	attack_verb_simple = list("smack", "whack", "slam", "smash")
	///The vehicle counterpart for the board
	var/board_item_type = /obj/vehicle/ridden/scooter/skateboard

/obj/item/melee/skateboard/attack_self(mob/user)
	var/obj/vehicle/ridden/scooter/skateboard/S = new board_item_type(get_turf(user))//this probably has fucky interactions with telekinesis but for the record it wasn't my fault
	S.buckle_mob(user)
	qdel(src)

/obj/item/melee/skateboard/pro
	name = "skateboard"
	desc = "A RaDSTORMz brand professional skateboard. It looks sturdy and well made."
	icon_state = "skateboard2"
	item_state = "skateboard2"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/pro
	custom_premium_price = 300

/obj/item/melee/skateboard/hoverboard
	name = "hoverboard"
	desc = "A blast from the past, so retro!"
	icon_state = "hoverboard_red"
	item_state = "hoverboard_red"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard
	custom_premium_price = 2015

/obj/item/melee/skateboard/hoverboard/admin
	name = "\improper Board Of Directors"
	desc = "The engineering complexity of a spaceship concentrated inside of a board. Just as expensive, too."
	icon_state = "hoverboard_nt"
	item_state = "hoverboard_nt"
	board_item_type = /obj/vehicle/ridden/scooter/skateboard/hoverboard/admin

/obj/item/melee/baseball_bat
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baseball_bat"
	item_state = "baseball_bat"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	block_upgrade_walk = TRUE
	attack_weight = 2
	force = 13
	throwforce = 6
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 3.5)
	w_class = WEIGHT_CLASS_HUGE
	var/homerun_ready = 0
	var/homerun_able = 0
	var/click_delay = 2

/obj/item/melee/baseball_bat/homerun
	name = "home run bat"
	desc = "This thing looks dangerous... Dangerously good at baseball, that is."
	homerun_able = 1

/obj/item/melee/baseball_bat/attack_self(mob/user)
	if(!homerun_able)
		..()
		return
	if(homerun_ready)
		to_chat(user, span_notice("You're already ready to do a home run!"))
		..()
		return
	to_chat(user, span_warning("You begin gathering strength..."))
	playsound(get_turf(src), 'sound/magic/lightning_chargeup.ogg', 65, 1)
	if(do_after(user, 90, target = src))
		to_chat(user, span_userdanger("You gather power! Time for a home run!"))
		homerun_ready = 1
	..()

/obj/item/melee/baseball_bat/attack(mob/living/target, mob/living/user)
	. = ..()
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(homerun_ready)
		user.visible_message(span_userdanger("It's a home run!"))
		target.throw_at(throw_target, rand(8,10), 14, user)
		SSexplosions.medturf += throw_target
		playsound(get_turf(src), 'sound/weapons/homerun.ogg', 100, 1)
		homerun_ready = 0
		return
	else if(!target.anchored)
		target.throw_at(throw_target, rand(1,2), 7, user, force = MOVE_FORCE_WEAK)
	user.changeNext_move(CLICK_CD_MELEE * click_delay)
	return


/obj/item/melee/baseball_bat/ablative
	name = "metal baseball bat"
	desc = "This bat is made of highly reflective, highly armored material."
	icon_state = "baseball_bat_metal"
	item_state = "baseball_bat_metal"
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY | BLOCKING_PROJECTILE
	block_level = 1
	force = 12
	throwforce = 15

/obj/item/melee/baseball_bat/ablative/IsReflect()//some day this will reflect thrown items instead of lasers
	var/picksound = rand(1,2)
	var/turf = get_turf(src)
	if(picksound == 1)
		playsound(turf, 'sound/weapons/effects/batreflect1.ogg', 50, 1)
	if(picksound == 2)
		playsound(turf, 'sound/weapons/effects/batreflect2.ogg', 50, 1)
	return 1

/obj/item/melee/flyswatter
	name = "flyswatter"
	desc = "Useful for killing insects of all sizes."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "flyswatter"
	item_state = "flyswatter"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	throwforce = 1
	attack_verb_continuous = list("swats", "smacks")
	attack_verb_simple = list("swat", "smack")
	hitsound = 'sound/effects/snap.ogg'
	w_class = WEIGHT_CLASS_SMALL
	//Things in this list will be instantly splatted.  Flyman weakness is handled in the flyman species weakness proc.
	var/list/strong_against

/obj/item/melee/flyswatter/Initialize(mapload)
	. = ..()
	strong_against = typecacheof(list(
		/mob/living/simple_animal/hostile/poison/bees/,
		/mob/living/simple_animal/butterfly,
		/mob/living/basic/cockroach,
		/obj/item/queen_bee
	))


/obj/item/melee/flyswatter/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!proximity_flag || HAS_TRAIT(user, TRAIT_PACIFISM))
		return

	if(is_type_in_typecache(target, strong_against))
		new /obj/effect/decal/cleanable/insectguts(target.drop_location())
		to_chat(user, span_warning("You easily splat the [target]."))
		if(istype(target, /mob/living/))
			var/mob/living/bug = target
			bug.investigate_log("has been splatted by a flyswatter.", INVESTIGATE_DEATHS)
			bug.death(1)
		else
			qdel(target)

/obj/item/circlegame
	name = "circled hand"
	desc = "If somebody looks at this while it's below your waist, you get to bop them."
	icon_state = "madeyoulook"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | ISWEAPON
	attack_verb_continuous = list("bops")
	attack_verb_simple = list("bop")

/obj/item/slapper
	name = "slapper"
	desc = "This is how real men fight."
	icon_state = "latexballon"
	item_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | ISWEAPON
	attack_verb_continuous = list("slaps")
	attack_verb_simple = list("slap")
	hitsound = 'sound/effects/snap.ogg'
	/// How many smaller table smacks we can do before we're out
	var/table_smacks_left = 3

/obj/item/slapper/attack(mob/living/M, mob/living/carbon/human/user)
	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(L && L.dna && L.dna.species)
			L.dna.species.stop_wagging_tail(M)
	user.do_attack_animation(M)

	var/slap_volume = 50
	if(user.is_zone_selected(BODY_ZONE_HEAD, precise_only = TRUE) || user.is_zone_selected(BODY_ZONE_PRECISE_MOUTH, simplified_probability = 50))
		user.visible_message(span_danger("[user] slaps [M] in the face!"),
			span_notice("You slap [M] in the face!"),
			span_hear("You hear a slap."))
	else
		user.visible_message(span_danger("[user] slaps [M]!"),
			span_notice("You slap [M]!"),
			span_hear("You hear a slap."))
	playsound(M, 'sound/weapons/slap.ogg', slap_volume, TRUE, -1)
	return

/obj/item/slapper/afterattack(atom/target, mob/living/user, proximity_flag, click_parameters)
	if(!istype(target, /obj/structure/table))
		return ..()

	var/obj/structure/table/the_table = target

	if(!proximity_flag)
		return

	if(user.combat_mode && table_smacks_left == initial(table_smacks_left)) // so you can't do 2 weak slaps followed by a big slam
		transform = transform.Scale(5) // BIG slap
		if(HAS_TRAIT(user, TRAIT_HULK))
			transform = transform.Scale(2)
			color = COLOR_GREEN
		user.do_attack_animation(the_table)
		//Uncomment if we ever port table slam signals
		//SEND_SIGNAL(user, COMSIG_LIVING_SLAM_TABLE, the_table)
		//SEND_SIGNAL(the_table, COMSIG_TABLE_SLAMMED, user)
		playsound(get_turf(the_table), 'sound/effects/tableslam.ogg', 110, TRUE)
		user.visible_message("<b>[span_danger("[user] slams [user.p_their()] fist down on [the_table]!")]</b>", "<b>[span_danger("You slam your fist down on [the_table]!")]</b>")
		qdel(src)
	else
		user.do_attack_animation(the_table)
		playsound(get_turf(the_table), 'sound/effects/tableslam.ogg', 40, TRUE)
		user.visible_message(span_notice("[user] slaps [user.p_their()] hand on [the_table]."), span_notice("You slap your hand on [the_table]."), vision_distance=COMBAT_MESSAGE_RANGE)
		table_smacks_left--
		if(table_smacks_left <= 0)
			qdel(src)

/obj/item/proc/can_trigger_gun(mob/living/user)
	if(!user.can_use_guns(src))
		return FALSE
	return TRUE

/obj/item/extendohand
	name = "extendo-hand"
	desc = "Futuristic tech has allowed these classic spring-boxing toys to essentially act as a fully functional hand-operated hand prosthetic."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "extendohand"
	item_state = "extendohand"
	item_flags = ISWEAPON
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 0
	throwforce = 5
	reach = 2

/obj/item/extendohand/acme
	name = "\improper ACME Extendo-Hand"
	desc = "A novelty extendo-hand produced by the ACME corporation. Originally designed to knock out roadrunners."

/obj/item/extendohand/attack(atom/M, mob/living/carbon/human/user, params)
	var/dist = get_dist(M, user)
	if(dist < reach)
		to_chat(user, span_warning("[M] is too close to use [src] on."))
		return
	var/list/modifiers = params2list(params)
	M.attack_hand(user, modifiers)


/obj/item/highfive
	name = "raised hand"
	desc = "Slap my hand."
	icon_state = "latexballon"
	item_state = "nothing"
	hitsound = 'sound/weapons/punchmiss.ogg'
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | ISWEAPON
	attack_verb_simple = list("is left hanging by")

/obj/item/highfive/attack(mob/target, mob/user)
	if(target == user)
		to_chat(user, span_notice("You can't high-five yourself! Go get a friend!"))
	else if(ishuman(target) && (target.stat == CONSCIOUS) && (istype(target.get_active_held_item(), /obj/item/highfive)) )
		var/obj/item/highfive/downlow = target.get_active_held_item()
		user.visible_message("[user] and [target] high five!", span_notice("You high five with [target]!"), span_italics("You hear a slap!"))
		user.do_attack_animation(target)
		target.do_attack_animation(user)
		playsound(src, 'sound/weapons/punch2.ogg', 50, 0)
		qdel(src)
		qdel(downlow)
	else
		user.visible_message("[user] is left hanging by [target].", span_notice("[target] leaves you hanging."))
		playsound(src, 'sound/weapons/punchmiss.ogg', 50, 0)

/obj/item/club
	name = "Billy club"
	desc = "A club designed for breaching enclosed spaces, with an insulated handle-guard to prevent shocks."
	icon_state = "billyclub"
	item_state = "classic_baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	force = 12
	throwforce = 5
	attack_verb_continuous = list("clubs", "bludgeons")
	attack_verb_simple = list("club", "bludgeon")
	item_flags = ISWEAPON
	siemens_coefficient = 0
	var/breakforce = 30
	var/stamforce = 15

/obj/item/club/attack(mob/living/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.check_shields(src, breakforce))
			return
		else
			var/def_check = H.getarmor(type = MELEE)
			H.apply_damage(stamforce, STAMINA, blocked = def_check)
	return ..()

/obj/item/club/pre_attack(atom/A, mob/living/user, params)
	force = initial(force)
	armour_penetration = initial(armour_penetration)
	if(isstructure(A) || ismachinery(A))
		force *= 2.5
		armour_penetration += 50
		// To prevent unnecessary force string calculation (we want this to be treated
		// as if it wasn't changed)
		last_force_string_check = force
		return ..()
	else if(isturf(A))
		force *= 1.5
		armour_penetration += 50
		last_force_string_check = force
		return ..()

/obj/item/club/set_force_string()
	// If we do need to calculate the new force string, make sure we are using the original force
	force = initial(force)
	return ..()

/obj/item/club/tailclub
	name = "tail club"
	desc = "For the beating to death of lizards with their own tails."
	icon_state = "tailclub"
	force = 14
	breakforce = 40

/obj/item/club/ghettoclub
	name = "improvised maul"
	desc = "A bundle of heavy stuff on a stick."
	icon_state = "ghettoclub"
	force = 14
	breakforce = 25
	stamforce = 5

/obj/item/melee/hydraulic_blade
	name = "hydraulic blade"
	desc = "Extremely sharp and dangerous weapon."
	icon_state = "hydraulic_blade"
	item_state = "hydraulic_blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 20
	block_upgrade_walk = TRUE
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY
	sharpness = SHARP_DISMEMBER
	bleed_force = BLEED_CUT
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

//HF blade
/obj/item/vibro_weapon
	icon_state = "hfrequency0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "vibro sword"
	desc = "A potent weapon capable of cutting through nearly anything. Wielding it in two hands will allow you to deflect gunfire."
	armour_penetration = 100
	block_level = 1
	block_upgrade_walk = 2
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY | BLOCKING_PROJECTILE
	block_sound = 'sound/weapons/genhit.ogg'
	force = 20
	throwforce = 20
	throw_speed = 4
	sharpness = SHARP_DISMEMBER
	bleed_force = BLEED_CUT
	attack_verb_continuous = list("cuts", "slices", "dices")
	attack_verb_simple = list("cut", "slice", "dice")
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ISWEAPON
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/vibro_weapon/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 105)
	AddComponent(/datum/component/two_handed, force_multiplier=2, block_power_wielded=40, icon_wielded="hfrequency1")

/obj/item/vibro_weapon/update_icon()
	icon_state = "hfrequency0"
	..()
