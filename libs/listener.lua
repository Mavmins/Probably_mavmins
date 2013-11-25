-- Initialize tables
if not mavmins then mavmins = {} end

ProbablyEngine.listener.register("mavmins", "COMBAT_LOG_EVENT_UNFILTERED", function(...)
	local event			= select(2, ...)
	local source		= select(5, ...)
	local destGUID		= select(8, ...)
	local destination	= select(9, ...)
	local spellID		= select(12, ...)
	local spell			= select(13, ...)
	local damage		= select(15, ...)
	local critical		= select(21, ...)
	
	
end)

ProbablyEngine.listener.register("mavmins", "MODIFIER_STATE_CHANGED", function(...)
	local key			= select(1, ...)
	local isDown		= select(2, ...)
	USE_CDS = ProbablyEngine.config.data.button_states.cooldowns
	oneTarget = ProbablyEngine.config.data.button_states.oneTarget
	twoTarget = ProbablyEngine.config.data.button_states.twoTarget
	threeTarget = ProbablyEngine.config.data.button_states.threeTarget
	sixTarget = ProbablyEngine.config.data.button_states.sixTarget
	
	if  (key == "RSHIFT" and isDown == 1) then --cooldowns toggle
		if USE_CDS then 
			USE_CDS = false 
			print("Cooldowns: |cFFFF0000Disabled")	
			ProbablyEngine.buttons.toggle('cooldowns')
		else 
			USE_CDS = true 
			print("Cooldowns: |cFF00FF00Enabled")
			ProbablyEngine.buttons.toggle('cooldowns')
		end
	end	
	
	
	if  (key == "LCTRL" and isDown == 1) then  --decrease target toggle
		if TARGET_MODE == "SIX" then  
			print("3 Target Mode")	
			TARGET_MODE ="THREE"

		elseif TARGET_MODE == "THREE" then
			print("2 Target Mode")	
			TARGET_MODE ="TWO"
			
		elseif TARGET_MODE == "TWO" then
			print("1 Target Mode")
			ProbablyEngine.buttons.toggle('multitarget')			
			TARGET_MODE = "ONE"

		end
	end	
	
	if  (key == "LSHIFT" and isDown == 1) then --increase target toggle
		if TARGET_MODE == "ONE" then  
			print("2 Target Mode")	
			ProbablyEngine.buttons.toggle('multitarget')
			TARGET_MODE = "TWO"

		elseif TARGET_MODE == "TWO" then
			print("3 Target Mode")	
			TARGET_MODE = "THREE"
			
		elseif TARGET_MODE == "THREE" then
			print("AoE Mode")	
			TARGET_MODE = "SIX"

		end
	end	
end)

