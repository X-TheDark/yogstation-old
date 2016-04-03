/obj/screen/blob
	icon = 'icons/mob/blob.dmi'

/obj/screen/blob/MouseEntered(location,control,params)
	openToolTip(usr,src,params,title = name,content = desc, theme = "blob")

/obj/screen/blob/MouseExited()
	closeToolTip(usr)

/obj/screen/blob/BlobHelp
	icon_state = "ui_help"
	name = "Blob Help"
	desc = "Help on playing blob!"

/obj/screen/blob/BlobHelp/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.blob_help()

/obj/screen/blob/JumpToNode
	icon_state = "ui_tonode"
	name = "Jump to Node"
	desc = "Moves your camera to a selected blob node."

/obj/screen/blob/JumpToNode/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.jump_to_node()

/obj/screen/blob/JumpToCore
	icon_state = "ui_tocore"
	name = "Jump to Core"
	desc = "Moves your camera to your blob core."

/obj/screen/blob/JumpToCore/MouseEntered(location,control,params)
	if(isovermind(usr))
		..()

/obj/screen/blob/JumpToCore/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.transport_core()

/obj/screen/blob/Blobbernaut
	icon_state = "ui_blobbernaut"
	name = "Produce Blobbernaut (30)"
	desc = "Produces a strong, semi-smart blobbernaut from a factory blob for 30 points.<br>The factory blob used will become fragile and fall apart."

/obj/screen/blob/Blobbernaut/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_blobbernaut()

/obj/screen/blob/ResourceBlob
	icon_state = "ui_resource"
	name = "Produce Resource Blob (40)"
	desc = "Produces a resource blob for 40 points.<br>Resource blobs will give you points every few seconds."

/obj/screen/blob/ResourceBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_resource()

/obj/screen/blob/NodeBlob
	icon_state = "ui_node"
	name = "Produce Node Blob (60)"
	desc = "Produces a node blob for 60 points.<br>Node blobs will expand and activate nearby resource and factory blobs."

/obj/screen/blob/NodeBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_node()

/obj/screen/blob/FactoryBlob
	icon_state = "ui_factory"
	name = "Produce Factory Blob (60)"
	desc = "Produces a factory blob for 60 points.<br>Factory blobs will produce spores every few seconds."

/obj/screen/blob/FactoryBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_factory()

/obj/screen/blob/ReadaptChemical
	icon_state = "ui_chemswap"
	name = "Readapt Chemical (40)"
	desc = "Randomly rerolls your chemical for 40 points."

/obj/screen/blob/ReadaptChemical/MouseEntered(location,control,params)
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		if(B.free_chem_rerolls)
			openToolTip(usr,src,params,title = "Readapt Chemical (FREE)",content = "Randomly rerolls your chemical for free.", theme = "blob")
		else
			..()

/obj/screen/blob/ReadaptChemical/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.chemical_reroll()

/obj/screen/blob/RelocateCore
	icon_state = "ui_swap"
	name = "Relocate Core (80)"
	desc = "Swaps a node and your core for 80 points."

/obj/screen/blob/RelocateCore/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.relocate_core()

/datum/hud/proc/blob_hud(ui_style = 'icons/mob/blob.dmi')
	adding = list()
	other = list()

	var/obj/screen/using

	blobpwrdisplay = new /obj/screen()
	blobpwrdisplay.name = "blob power"
	blobpwrdisplay.icon_state = "block"
	blobpwrdisplay.screen_loc = ui_health
	blobpwrdisplay.layer = 20

	blobhealthdisplay = new /obj/screen()
	blobhealthdisplay.name = "blob health"
	blobhealthdisplay.icon_state = "block"
	blobhealthdisplay.screen_loc = ui_internal
	blobhealthdisplay.layer = 20

	mymob.client.screen = list()
	mymob.client.screen += list(blobpwrdisplay, blobhealthdisplay)
	mymob.client.screen += mymob.client.void

	using = new /obj/screen/blob/BlobHelp()
	using.screen_loc = "WEST:6,NORTH:-3"
	adding += using

	using = new /obj/screen/blob/JumpToNode()
	using.screen_loc = ui_inventory
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/JumpToCore()
	using.screen_loc = ui_zonesel
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/Blobbernaut()
	using.screen_loc = ui_belt
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/ResourceBlob()
	using.screen_loc = ui_back
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/NodeBlob()
	using.screen_loc = ui_lhand
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/FactoryBlob()
	using.screen_loc = ui_rhand
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/ReadaptChemical()
	using.screen_loc = ui_storage1
	using.icon = ui_style
	adding += using

	using = new /obj/screen/blob/RelocateCore()
	using.screen_loc = ui_storage2
	using.icon = ui_style
	adding += using

	mymob.zone_sel = new /obj/screen/zone_sel()
	mymob.zone_sel.icon = 'icons/mob/screen_midnight.dmi'
	mymob.zone_sel.update_icon()

	mymob.client.screen += adding

	return