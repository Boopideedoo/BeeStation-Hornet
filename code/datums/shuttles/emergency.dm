/datum/map_template/shuttle/emergency
	port_id = "emergency"
	name = "Base Shuttle Template (Emergency)"
	untowable = TRUE

/datum/map_template/shuttle/emergency/backup
	suffix = "backup"
	name = "Backup Shuttle"
	can_be_bought = FALSE

/datum/map_template/shuttle/emergency/construction
	suffix = "construction"
	name = "Build your own shuttle kit"
	description = "For the enterprising shuttle engineer! The chassis will dock upon purchase, but launch will have to be authorized as usual via shuttle call. Comes stocked with construction materials."
	admin_notes = "No brig, no medical facilities, no shuttle console."
	credit_cost = -2500

/datum/map_template/shuttle/emergency/airless/prerequisites_met()
	// first 10 minutes only
	return world.time - SSticker.round_start_time < 6000

/datum/map_template/shuttle/emergency/airless/post_load()
	. = ..()
	//enable buying engines from cargo
	var/datum/supply_pack/P = SSsupply.supply_packs[/datum/supply_pack/engineering/shuttle_engine]
	P.special_enabled = TRUE


/datum/map_template/shuttle/emergency/asteroid
	suffix = "asteroid"
	name = "Asteroid Station Emergency Shuttle"
	description = "A respectable mid-sized shuttle that first saw service shuttling Nanotrasen crew to and from their asteroid belt embedded facilities."
	credit_cost = 3000

/datum/map_template/shuttle/emergency/bar
	suffix = "bar"
	name = "The Emergency Escape Bar"
	description = "Features include sentient bar staff (a Bardrone and a Barmaid), bathroom, a quality lounge for the heads, and a large gathering table."
	admin_notes = "Bardrone and Barmaid are GODMODE, will be automatically sentienced by the fun balloon at 60 seconds before arrival. \
	Has medical facilities."
	credit_cost = 5000

/datum/map_template/shuttle/emergency/theatre
	suffix = "theatre"
	name = "The Emergency Fancy Theatre"
	description = "Put on your best show with the emergency theatre on the couple minutes it takes you to get to CentCom! Includes a medbay, cockpit, brig and tons of fancy stuff for the crew"
	admin_notes = "Theatre with seats, brig, cockpit and medbay included, for shows or improvisation by the crewmembers"
	credit_cost = 5000

/datum/map_template/shuttle/emergency/pod
	suffix = "pod"
	name = "Emergency Pods"
	description = "We did not expect an evacuation this quickly. All we have available is two escape pods."
	admin_notes = "For player punishment."
	can_be_bought = FALSE

/datum/map_template/shuttle/emergency/russiafightpit
	suffix = "russiafightpit"
	name = "Mother Russia Bleeds"
	description = "Dis is a high-quality shuttle, da. Many seats, lots of space, all equipment! Even includes entertainment! Such as lots to drink, and a fighting arena for drunk crew to have fun! If arena not fun enough, simply press button of releasing bears. Do not worry, bears trained not to break out of fighting pit, so totally safe so long as nobody stupid or drunk enough to leave door open. Try not to let asimov babycons ruin fun!"
	admin_notes = "Includes a small variety of weapons. And bears. Only captain-access can release the bears. Bears won't smash the windows themselves, but they can escape if someone lets them."
	credit_cost = 5000 // While the shuttle is rusted and poorly maintained, trained bears are costly.
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/meteor
	suffix = "meteor"
	name = "Asteroid With Engines Strapped To It"
	description = "A hollowed out asteroid with engines strapped to it, the hollowing procedure makes it very difficult to hijack but is very expensive. Due to its size and difficulty in steering it, this shuttle may damage the docking area."
	admin_notes = "This shuttle will likely crush escape, killing anyone there."
	credit_cost = 15000
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	danger_level = SHUTTLE_DANGER_HIGH

/datum/map_template/shuttle/emergency/luxury
	suffix = "luxury"
	name = "Luxury Shuttle"
	description = "A luxurious golden shuttle complete with an indoor swimming pool. Each crewmember wishing to board must bring 500 credits, payable in cash and mineral coin."
	extra_desc = "This shuttle costs 500 credits to board."
	admin_notes = "Due to the limited space for non paying crew, this shuttle may cause a riot."
	credit_cost = 10000
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/funnypod
	suffix = "funnypod"
	name = "Comically Large Escape Pod"
	description = "A bunch of scrapped escape pods glued together."
	admin_notes = "This shuttle will 100% cause mayhem, as the space avaiable is 1x23 and anyone can open the door in the end."
	credit_cost = 2000
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/discoinferno
	suffix = "discoinferno"
	name = "Disco Inferno"
	description = "The glorious results of centuries of plasma research done by Nanotrasen employees. This is the reason why you are here. Get on and dance like you're on fire, burn baby burn!"
	admin_notes = "Flaming hot. The main area has a dance machine as well as plasma floor tiles that will be ignited by players every single time."
	credit_cost = 10000
	danger_level = SHUTTLE_DANGER_HIGH

/datum/map_template/shuttle/emergency/arena
	suffix = "arena"
	name = "The Arena"
	description = "The crew must pass through an otherworldy arena to board this shuttle. Expect massive casualties. The source of the Bloody Signal must be tracked down and eliminated to unlock this shuttle."
	admin_notes = "RIP AND TEAR. Creates an entire internal Z-level where you have to kill each other in a massive battle royale to get to the actual shuttle."
	credit_cost = 10000
	danger_level = SHUTTLE_DANGER_HIGH
	/// Whether the arena z-level has been created
	var/arena_loaded = FALSE

/datum/map_template/shuttle/emergency/arena/prerequisites_met()
	if(SHUTTLE_UNLOCK_BUBBLEGUM in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE

/datum/map_template/shuttle/emergency/arena/post_load(obj/docking_port/mobile/M)
	. = ..()
	if(!arena_loaded)
		arena_loaded = TRUE
		var/datum/map_template/arena/arena_template = new()
		arena_template.load_new_z()

/datum/map_template/arena
	name = "The Arena"
	mappath = "_maps/templates/the_arena.dmm"

/datum/map_template/shuttle/emergency/birdboat
	suffix = "birdboat"
	name = "Birdboat Station Emergency Shuttle"
	description = "Though a little on the small side, this shuttle is feature complete, which is more than can be said for the pattern of station it was commissioned for."
	credit_cost = 1000

/datum/map_template/shuttle/emergency/shelter
	suffix = "shelter"
	name = "BSP Collapsable Emergency Shuttle"
	description = "A new product by a Nanotrasen subsidary, designed to be quick to construct and employ, with the amenities of a small emergency shuttle, including sleepers. Luckily, the shuttle is indeed deployed faster. Un-luckily, that time is supplemented by construction time, so it won't make the transit any faster."
	credit_cost = 2500

/datum/map_template/shuttle/emergency/box
	suffix = "box"
	name = "Box Station Emergency Shuttle"
	credit_cost = 2000
	description = "The gold standard in emergency exfiltration, this tried and true design is equipped with everything the crew needs for a safe flight home."

/datum/map_template/shuttle/emergency/clown
	suffix = "clown"
	name = "Snappop(tm)!"
	description = "Hey kids and grownups! \
	Are you bored of DULL and TEDIOUS shuttle journeys after you're evacuating for probably BORING reasons. Well then order the Snappop(tm) today! \
	We've got fun activities for everyone, an all access cockpit, and no boring security brig! Boo! Play dress up with your friends! \
	Collect all the bedsheets before your neighbour does! Check if the AI is watching you with our patent pending \"Peeping Tom AI Multitool Detector\" or PEEEEEETUR for short. \
	Have a fun ride!"
	admin_notes = "Brig is replaced by anchored greentext book surrounded by lavaland chasms, stationside door has been removed to prevent accidental dropping. No brig."
	credit_cost = 8000
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/cramped
	suffix = "cramped"
	name = "Secure Transport Vessel 5 (STV5)"
	description = "Well, looks like CentCom only had this ship in the area, they probably weren't expecting you to need evac for a while. \
	Probably best if you don't rifle around in whatever equipment they were transporting. I hope you're friendly with your coworkers, because there is very little space in this thing.\n\
	\n\
	Contains contraband armory guns, some random stuff we found in maintenance, and potentially explosive abandoned crates!"
	admin_notes = "Due to origin as a solo piloted secure vessel, has an active GPS onboard labeled STV5. Has roughly as much space as Hi Daniel, except with explosive crates."
	danger_level = SHUTTLE_DANGER_HIGH

/datum/map_template/shuttle/emergency/meta
	suffix = "meta"
	name = "Meta Station Emergency Shuttle"
	credit_cost = 4000
	description = "A fairly standard shuttle, though larger and slightly better equipped than the Box Station variant."

/datum/map_template/shuttle/emergency/kilo
	suffix = "kilo"
	name = "Kilo Station Emergency Shuttle"
	credit_cost = 5000
	description = "A fully functional shuttle including a complete infirmary, storage facilties and regular amenities."

/datum/map_template/shuttle/emergency/corg
	suffix = "corg"
	name = "Corg Station Emergency Shuttle"
	credit_cost = 4000
	description = "A smaller shuttle with area for cargo, medical and security personnel."

/datum/map_template/shuttle/emergency/fland
	suffix = "fland"
	name = "Flandstation Wide shuttle"
	description = "It's a fat shuttle for a rather unusual station... huh..."
	admin_notes = "It's big to spawn, it may or may not collide with the surrounding stuff on other maps that don't have a massive emergency docking area."
	credit_cost = 8000

/datum/map_template/shuttle/emergency/mini
	suffix = "mini"
	name = "Ministation emergency shuttle"
	credit_cost = 1000
	description = "Despite its namesake, this shuttle is actually only slightly smaller than standard, and still complete with a brig and medbay."

/datum/map_template/shuttle/emergency/scrapheap
	suffix = "scrapheap"
	name = "Standby Evacuation Vessel \"Scrapheap Challenge\""
	credit_cost = -1000
	description = "Due to a lack of functional emergency shuttles, we bought this second hand from a scrapyard and pressed it into service. Please do not lean too heavily on the exterior windows, they are fragile."
	admin_notes = "An abomination with no functional medbay, sections missing, and some very fragile windows. Surprisingly airtight."
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/narnar
	suffix = "narnar"
	name = "Shuttle 667"
	description = "Looks like this shuttle may have wandered into the darkness between the stars on route to the station. Let's not think too hard about where all the bodies came from."
	admin_notes = "Contains real cult ruins, mob eyeballs, and inactive constructs. Cult mobs will automatically be sentienced by fun balloon. \
	Cloning pods in 'medbay' area are showcases and nonfunctional."
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/narnar/prerequisites_met()
	if(SHUTTLE_UNLOCK_NARNAR in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE

/datum/map_template/shuttle/emergency/pubby
	suffix = "pubby"
	name = "Pubby Station Emergency Shuttle"
	description = "A train but in space! Complete with a first, second class, brig and storage area."
	admin_notes = "Choo choo motherfucker!"
	credit_cost = 1000

/datum/map_template/shuttle/emergency/tiny
	suffix = "tiny"
	name = "Echo Station Emergency Shuttle"
	description = "A small emergancy escape shuttle"
	admin_notes = "A *very* small shuttle"
	credit_cost = 1000

/datum/map_template/shuttle/emergency/cere
	suffix = "cere"
	name = "Cere Station Emergency Shuttle"
	description = "The large, beefed-up version of the box-standard shuttle. Includes an expanded brig, fully stocked medbay, enhanced cargo storage with mech chargers, \
	an engine room stocked with various supplies, and a crew capacity of 80+ to top it all off. Live large, live Cere."
	admin_notes = "Seriously big, even larger than the Delta shuttle."
	credit_cost = 10000

/datum/map_template/shuttle/emergency/supermatter
	suffix = "supermatter"
	name = "Hyperfractal Gigashuttle"
	description = "\"I dunno, this seems kinda needlessly complicated.\"\n\
	\"This shuttle has very a very high safety record, according to CentCom Officer Cadet Yins.\"\n\
	\"Are you sure?\"\n\
	\"Yes, it has a safety record of N-A-N, which is apparently larger than 100%.\""
	admin_notes = "Supermatter that spawns on shuttle is special anchored 'hugbox' supermatter that cannot take damage and does not take in or emit gas. \
	Outside of admin intervention, it cannot explode. \
	It does, however, still dust anything on contact, emits high levels of radiation, and induce hallucinations in anyone looking at it without protective goggles. \
	Emitters spawn powered on, expect admin notices, they are harmless."
	credit_cost = 100000
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	danger_level = SHUTTLE_DANGER_HIGH

/datum/map_template/shuttle/emergency/imfedupwiththisworld
	suffix = "imfedupwiththisworld"
	name = "Oh, Hi Daniel"
	description = "How was space work today? Oh, pretty good. We got a new space station and the company will make a lot of money. What space station? I cannot tell you; it's space confidential. \
	Aw, come space on. Why not? No, I can't. Anyway, how is your space life?"
	admin_notes = "Tiny, with a single airlock and wooden walls. What could go wrong?"
	credit_cost = -5000
	movement_force = list("KNOCKDOWN" = 3, "THROW" = 2)
	danger_level = SHUTTLE_DANGER_SUBPAR

/datum/map_template/shuttle/emergency/goon
	suffix = "goon"
	name = "NES Port"
	description = "The Nanotrasen Emergency Shuttle Port(NES Port for short) is a shuttle used at other less known Nanotrasen facilities and has a more open inside for larger crowds, but fewer onboard shuttle facilities."
	credit_cost = 500

/datum/map_template/shuttle/emergency/wabbajack
	suffix = "wabbajack"
	name = "NT Lepton Violet"
	description = "The research team based on this vessel went missing one day, and no amount of investigation could discover what happened to them. \
	The only occupants were a number of dead rodents, who appeared to have clawed each other to death. \
	Needless to say, no engineering team wanted to go near the thing, and it's only being used as an Emergency Escape Shuttle because there is literally nothing else available."
	admin_notes = "If the crew can solve the puzzle, they will wake the wabbajack statue. It will likely not end well. There's a reason it's boarded up. Maybe they should have just left it alone."
	credit_cost = 15000
	danger_level = SHUTTLE_DANGER_HIGH

/datum/map_template/shuttle/emergency/omega
	suffix = "omega"
	name = "Omegastation Emergency Shuttle"
	description = "On the smaller size with a modern design, this shuttle is for the crew who like the cosier things, while still being able to stretch their legs."
	credit_cost = 1000

/datum/map_template/shuttle/emergency/delta
	suffix = "delta"
	name = "Delta Station Emergency Shuttle"
	description = "A large shuttle for a large station, this shuttle can comfortably fit all your overpopulation and crowding needs. Complete with all facilities plus additional equipment."
	admin_notes = "Go big or go home."
	credit_cost = 7500

/datum/map_template/shuttle/emergency/raven
	suffix = "raven"
	name = "CentCom Raven Cruiser"
	description = "The CentCom Raven Cruiser is a former high-risk salvage vessel, now repurposed into an emergency escape shuttle. \
	Once first to the scene to pick through warzones for valuable remains, it now serves as an excellent escape option for stations under heavy fire from outside forces. \
	This escape shuttle boasts shields and numerous anti-personnel turrets guarding its perimeter to fend off meteors and enemy boarding attempts."
	admin_notes = "Comes with turrets that will target anything without the neutral faction (nuke ops, xenos etc, but not pets)."
	credit_cost = 30000

/datum/map_template/shuttle/emergency/zeta
	suffix = "zeta"
	name = "Tr%nPo2r& Z3TA"
	description = "A glitch appears on your monitor, flickering in and out of the options laid before you. \
	It seems strange and alien, you may need a special technology to access the signal.."
	admin_notes = "Has an on-board experimental cloner that creates copies of its user, alien surgery tools, and a void core that provides unlimited power."
	credit_cost = 8000

/datum/map_template/shuttle/emergency/ragecage
	suffix = "ragecage"
	name = "THE RAGE CAGE"
	description = "An abandoned underground electrified fight arena turned into a shuttle. Comes with a Brig, Medbay and Cockpit included."
	admin_notes = "It's a normal shuttle but it has a rage cage with baseball bats in the middle powered by a PACMAN, plasma included."
	credit_cost = 7500
	danger_level = SHUTTLE_DANGER_SUBPAR


/datum/map_template/shuttle/emergency/zeta/prerequisites_met()
	if(SHUTTLE_UNLOCK_ALIENTECH in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE

