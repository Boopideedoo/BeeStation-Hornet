/datum/antagonist/pirate
	name = "Space Pirate"
	banning_key = ROLE_SPACE_PIRATE
	roundend_category = "space pirates"
	antagpanel_category = "Pirate"
	show_to_ghosts = TRUE
	required_living_playtime = 4
	var/datum/team/pirate/crew

/datum/antagonist/pirate/captain
	name = "Space Pirate Captain"

/datum/antagonist/pirate/captain/on_gain()
	. = ..()
	var/mob/living/current = owner.current
	set_antag_hud(current, "pirate-captain")

/datum/antagonist/pirate/greet()
	to_chat(owner, span_boldannounce("You are a Space Pirate!"))
	to_chat(owner, "<B>The station refused to pay for your protection, protect the ship, siphon the credits from the station and raid it for even more loot.</B>")
	owner.announce_objectives()
	owner.current.client?.tgui_panel?.give_antagonist_popup("Space Pirate",
		"The station refused to pay for your protection, protect the ship, siphon the credits from the station and raid it for even more loot.")

/datum/antagonist/pirate/apply_innate_effects(mob/living/mob_override)
	. = ..()
	//Give pirate appearance on hud (If they are not an antag already)
	var/datum/atom_hud/antag/piratehud = GLOB.huds[ANTAG_HUD_PIRATE]
	piratehud.join_hud(owner.current)
	if(!owner.antag_hud_icon_state)
		set_antag_hud(owner.current, "pirate")

/datum/antagonist/pirate/remove_innate_effects(mob/living/mob_override)
	. = ..()
	//Clear the hud if they haven't become something else and had the hud overwritten
	var/datum/atom_hud/antag/piratehud = GLOB.huds[ANTAG_HUD_PIRATE]
	piratehud.leave_hud(owner.current)
	if(owner.antag_hud_icon_state == "pirate" || owner.antag_hud_icon_state == "pirate-captain")
		set_antag_hud(owner.current, null)

/datum/antagonist/pirate/get_team()
	return crew

/datum/antagonist/pirate/create_team(datum/team/pirate/new_team)
	if(!new_team)
		for(var/datum/antagonist/pirate/P in GLOB.antagonists)
			if(!P.owner)
				continue
			if(P.crew)
				crew = P.crew
				return
		if(!new_team)
			crew = new /datum/team/pirate
			crew.forge_objectives()
			return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	crew = new_team

/datum/antagonist/pirate/on_gain()
	if(crew)
		objectives |= crew.objectives
	. = ..()

/datum/antagonist/pirate/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/piratespeak, source = LANGUAGE_PIRATE)
	holder.selected_language = /datum/language/piratespeak

/datum/antagonist/pirate/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	owner_mob.remove_language(/datum/language/piratespeak, source = LANGUAGE_PIRATE)
	return ..()

/datum/team/pirate
	name = "Space Pirates"

/datum/team/pirate/proc/forge_objectives()
	var/datum/objective/loot/getbooty = new()
	getbooty.team = src
	for(var/obj/machinery/computer/piratepad_control/P in GLOB.machines)
		var/area/A = get_area(P)
		if(istype(A,/area/shuttle/pirate))
			getbooty.cargo_hold = P
			break
	getbooty.update_explanation_text()
	objectives += getbooty
	for(var/datum/mind/M in members)
		var/datum/antagonist/pirate/P = M.has_antag_datum(/datum/antagonist/pirate)
		if(P)
			P.objectives |= objectives


/datum/objective/loot
	var/obj/machinery/computer/piratepad_control/cargo_hold
	explanation_text = "Acquire valuable loot and store it in designated area."
	var/target_value = 50000


/datum/objective/loot/update_explanation_text()
	if(cargo_hold)
		var/area/storage_area = get_area(cargo_hold)
		explanation_text = "Acquire loot and store [target_value] of credits worth in [storage_area.name] cargo hold."

/datum/objective/loot/proc/loot_listing()
	//Lists notable loot.
	if(!cargo_hold || !cargo_hold.total_report)
		return "Nothing"
	cargo_hold.total_report.total_value = sortTim(cargo_hold.total_report.total_value, cmp = GLOBAL_PROC_REF(cmp_numeric_dsc), associative = TRUE)
	var/count = 0
	var/list/loot_texts = list()
	for(var/datum/export/E in cargo_hold.total_report.total_value)
		if(++count > 5)
			break
		loot_texts += E.total_printout(cargo_hold.total_report,notes = FALSE)
	return loot_texts.Join(", ")

/datum/objective/loot/proc/get_loot_value()
	return cargo_hold ? cargo_hold.points : 0

/datum/objective/loot/check_completion()
	return ..() || get_loot_value() >= target_value

/datum/team/pirate/roundend_report()
	var/list/parts = list()

	parts += span_header("Space Pirates were:")

	var/all_dead = TRUE
	for(var/datum/mind/M in members)
		if(considered_alive(M))
			all_dead = FALSE
	parts += printplayerlist(members)

	parts += "Loot stolen: "
	var/datum/objective/loot/L = locate() in objectives
	parts += L.loot_listing()
	parts += "Total loot value : [L.get_loot_value()]/[L.target_value] credits"

	if(L.check_completion() && !all_dead)
		parts += span_greentextbig("The pirate crew was successful!")
	else
		parts += span_redtextbig("The pirate crew has failed.")

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"
