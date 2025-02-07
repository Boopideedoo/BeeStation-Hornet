/datum/map_template/shuttle
	name = "Base Shuttle Template"
	var/prefix = "_maps/shuttles/"
	var/suffix
	var/port_id
	var/shuttle_id

	var/description
	var/prerequisites
	var/admin_notes

	var/credit_cost = INFINITY
	var/can_be_bought = TRUE
	var/illegal_shuttle = FALSE	//makes you able to buy the shuttle at a hacked/emagged comms console even if can_be_bought is FALSE

	/// How dangerous this shuttle is, used for alerting foolish captains not to buy it (or traitors to buy it)
	var/danger_level = SHUTTLE_DANGER_SAFE

	var/list/movement_force // If set, overrides default movement_force on shuttle
	var/untowable = FALSE // If set, the shuttle becomes untowable

	var/port_x_offset
	var/port_y_offset
	var/extra_desc = ""

/datum/map_template/shuttle/proc/prerequisites_met()
	return TRUE

/datum/map_template/shuttle/New(path = null, rename = null, cache = FALSE, admin_load = null)
	if(admin_load)//This data must be populated for the system to not shit itself apparently
		suffix = admin_load
		port_id = "custom"
		can_be_bought = FALSE
	shuttle_id = "[port_id]_[suffix]"
	if(!admin_load)
		mappath = "[prefix][port_id]/[shuttle_id].dmm"
	. = ..()

/datum/map_template/shuttle/preload_size(path, cache)
	. = ..(path, TRUE) // Done this way because we still want to know if someone actualy wanted to cache the map
	if(!cached_map)
		return

	discover_port_offset()

	if(!cache)
		cached_map = null

/datum/map_template/shuttle/proc/discover_port_offset()
	var/key
	var/list/models = cached_map.grid_models
	for(key in models)
		if(findtext(models[key], "[/obj/docking_port/mobile]")) // Yay compile time checks
			break // This works by assuming there will ever only be one mobile dock in a template at most

	for(var/i in cached_map.gridSets)
		var/datum/grid_set/gset = i
		var/ycrd = gset.ycrd
		for(var/line in gset.gridLines)
			var/xcrd = gset.xcrd
			for(var/j in 1 to length(line) step cached_map.key_len)
				if(key == copytext(line, j, j + cached_map.key_len))
					port_x_offset = xcrd
					port_y_offset = ycrd
					return
				++xcrd
			--ycrd

/datum/map_template/shuttle/load(turf/T, centered, init_atmos, finalize = TRUE, register = TRUE)
	if(centered)
		T = locate(T.x - round(width/2) , T.y - round(height/2) , T.z)
		centered = FALSE
	//This assumes a non-multi-z shuttle. If you are making a multi-z shuttle, you'll need to change the z bounds for this block. Good luck.
	var/list/turfs = block(locate(max(T.x, 1), max(T.y, 1),  T.z),
							locate(min(T.x+width-1, world.maxx), min(T.y+height-1, world.maxy), T.z))
	for(var/turf/turf in turfs)
		turfs[turf] = turf.loc
	. = ..(T, centered, init_atmos, finalize, register, turfs)

/datum/map_template/shuttle/on_placement_completed(datum/async_map_generator/map_place/map_gen, turf/T, init_atmos, datum/parsed_map/parsed, finalize = TRUE, register = TRUE, list/turfs)
	. = ..(map_gen, T, TRUE, parsed, FALSE)
	if(!.)
		log_runtime("Failed to load shuttle [map_gen.get_name()].")
		return

	var/obj/docking_port/mobile/my_port
	for(var/turf/place in turfs)
		if(place.loc == turfs[place] || !istype(place.loc, /area/shuttle)) //If not part of the shuttle, ignore it
			turfs -= place
			continue
		for(var/obj/docking_port/mobile/port in place)
			my_port = port
			port.untowable = untowable
			if(register)
				port.register()
			if(isnull(port_x_offset))
				continue
			switch(port.dir) // Yeah this looks a little ugly but mappers had to do this in their head before
				if(NORTH)
					port.width = width
					port.height = height
					port.dwidth = port_x_offset - 1
					port.dheight = port_y_offset - 1
				if(EAST)
					port.width = height
					port.height = width
					port.dwidth = height - port_y_offset
					port.dheight = port_x_offset - 1
				if(SOUTH)
					port.width = width
					port.height = height
					port.dwidth = width - port_x_offset
					port.dheight = height - port_y_offset
				if(WEST)
					port.width = height
					port.height = width
					port.dwidth = port_y_offset - 1
					port.dheight = width - port_x_offset

	for(var/turf/shuttle_turf in turfs)
		var/area/shuttle/turf_loc = turfs[shuttle_turf]
		my_port.underlying_turf_area[shuttle_turf] = turf_loc
		if(istype(turf_loc) && turf_loc.mobile_port)
			turf_loc.mobile_port.towed_shuttles |= my_port

		//Getting the amount of baseturfs added
		var/z_offset = shuttle_turf.z - T.z
		var/y_offset = shuttle_turf.y - T.y
		var/x_offset = shuttle_turf.x - T.x
		//retrieving our cache
		var/line
		var/list/cache
		for(var/datum/grid_set/gset as() in cached_map.gridSets)
			if(gset.zcrd - 1 != z_offset) //Not our Z-level
				continue
			if((gset.ycrd - 1 < y_offset) || (gset.ycrd - length(gset.gridLines) > y_offset)) //Our y coord isn't in the bounds
				continue
			line = gset.gridLines[length(gset.gridLines) - y_offset] //Y goes from top to bottom
			if((gset.xcrd - 1 < x_offset) || (gset.xcrd + (length(line)/cached_map.key_len) - 2 > x_offset)) ///Our x coord isn't in the bounds
				continue
			cache = map_gen.placing_template.modelCache[copytext(line, 1+((x_offset-gset.xcrd+1)*cached_map.key_len), 1+((x_offset-gset.xcrd+2)*cached_map.key_len))]
			break
		if(!cache) //Our turf isn't in the cached map, something went very wrong
			continue

		//How many baseturfs were added to this turf by the mapload
		var/baseturf_length
		var/turf/P //Typecasted for the initial call
		for(P as() in cache[1])
			if(ispath(P, /turf))
				var/list/added_baseturfs = GLOB.created_baseturf_lists[initial(P.baseturfs)] //We can assume that our turf type will be included here because it was just generated in the mapload.
				if(!islist(added_baseturfs))
					added_baseturfs = list(added_baseturfs)
				baseturf_length = length(added_baseturfs - GLOB.blacklisted_automated_baseturfs)
				break
		if(ispath(P, /turf/template_noop)) //No turf was added, don't add a skipover
			continue

		if(!islist(shuttle_turf.baseturfs))
			shuttle_turf.baseturfs = list(shuttle_turf.baseturfs)

		var/list/sanity = shuttle_turf.baseturfs.Copy()
		sanity.Insert(shuttle_turf.baseturfs.len + 1 - baseturf_length, /turf/baseturf_skipover/shuttle)
		shuttle_turf.baseturfs = baseturfs_string_list(sanity, shuttle_turf)

	//If this is a superfunction call, we don't want to initialize atoms here, let the subfunction handle that
	if(finalize)
		maps_loading --

		//initialize things that are normally initialized after map load
		initTemplateBounds(., init_atmos)

		log_game("[name] loaded at [T.x],[T.y],[T.z]")


//Whatever special stuff you want
/datum/map_template/shuttle/proc/post_load(obj/docking_port/mobile/M)
	if(movement_force)
		M.movement_force = movement_force.Copy()
	M.linkup()
