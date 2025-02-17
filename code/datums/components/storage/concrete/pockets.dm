/datum/component/storage/concrete/pockets
	max_items = 2
	max_w_class = WEIGHT_CLASS_SMALL
	max_combined_w_class = 50
	rustle_sound = FALSE

/datum/component/storage/concrete/pockets/handle_item_insertion(obj/item/I, prevent_warning, mob/user)
	. = ..()
	if(. && silent && !prevent_warning)
		if(quickdraw)
			to_chat(user, span_notice("You discreetly slip [I] into [parent]. Alt-click [parent] to remove it."))
		else
			to_chat(user, span_notice("You discreetly slip [I] into [parent]."))

/datum/component/storage/concrete/pockets
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/pockets/small
	max_items = 1
	max_w_class = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/tiny
	max_items = 1
	max_w_class = WEIGHT_CLASS_TINY
	attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/exo
	max_items = 2
	max_w_class = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE
	quickdraw = FALSE
	silent = FALSE

/datum/component/storage/concrete/pockets/exo/cloak
	max_items = 1
	quickdraw = TRUE

/datum/component/storage/concrete/pockets/exo/large
	max_items = 3

/datum/component/storage/concrete/pockets/small/detective
	attack_hand_interact = TRUE // so the detectives would discover pockets in their hats

/datum/component/storage/concrete/pockets/shoes
	max_items = 2
	attack_hand_interact = FALSE
	max_w_class = WEIGHT_CLASS_SMALL
	quickdraw = TRUE
	silent = TRUE

/datum/component/storage/concrete/pockets/shoes/clown

/datum/component/storage/concrete/pockets/pocketprotector
	max_items = 3
	max_w_class = WEIGHT_CLASS_TINY
	var/atom/original_parent

/datum/component/storage/concrete/pockets/pocketprotector/Initialize()
	original_parent = parent
	. = ..()
	set_holdable(
		list( //Same items as a PDA
			/obj/item/pen,
			/obj/item/toy/crayon,
			/obj/item/lipstick,
			/obj/item/flashlight/pen,
			/obj/item/clothing/mask/cigarette
		)
	)

/datum/component/storage/concrete/pockets/pocketprotector/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/holster
	max_items = 2
	max_w_class = WEIGHT_CLASS_LARGE
	var/atom/original_parent

/datum/component/storage/concrete/pockets/holster/Initialize()
	original_parent = parent
	. = ..()
	set_holdable(
		list(
			/obj/item/gun/ballistic/automatic/pistol,
			/obj/item/gun/ballistic/revolver,
			/obj/item/ammo_box,
			/obj/item/ammo_casing
		)
	)

/datum/component/storage/concrete/pockets/holster/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/holster/detective/Initialize()
	original_parent = parent
	. = ..()
	set_holdable(list(
		/obj/item/gun/ballistic/revolver/detective,
		/obj/item/ammo_box/c38,
		/obj/item/ammo_casing/c38))

/datum/component/storage/concrete/pockets/helmet
	quickdraw = TRUE
	max_combined_w_class = 6

/datum/component/storage/concrete/pockets/helmet/Initialize()
	. = ..()
	set_holdable(
		list(
			/obj/item/reagent_containers/cup/glass/bottle/vodka,
			/obj/item/reagent_containers/cup/glass/bottle/molotov,
			/obj/item/reagent_containers/cup/glass/drinkingglass,
			/obj/item/ammo_box/a762
			)
		)

/datum/component/storage/concrete/pockets/void_cloak
	quickdraw = TRUE
	max_items = 3

/datum/component/storage/concrete/pockets/void_cloak/Initialize()
	. = ..()
	var/static/list/exception_cache = typecacheof(list(/obj/item/clothing/neck/heretic_focus,/obj/item/codex_cicatrix))
	exception_hold = exception_cache
