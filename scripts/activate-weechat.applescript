set found to false
set target_name to "WeeChat"

tell application "iTerm"
	repeat with mysession in sessions
	try
		if name of mysession contains target_name then
			set found to true
			-- select mywin
			exit repeat
		end if
		end try
	end repeat
	
	
	repeat with mywin in windows
		repeat with mytab in tabs of mywin
			if name of mytab contains target_name then
				set found to true
				select mywin
				exit repeat
			end if
			
			
			repeat with mysession in sessions of mytab
				if name of mysession contains target_name then
					set found to true
					select mywin
					exit repeat
				end if
			end repeat
			
			if found then exit repeat
		end repeat
	end repeat
	
	if not found then
		activate
		set answer to the button returned of (display dialog "No WeeChat window found.  Should I launch one?" buttons {"Yes", "No"} default button 1 cancel button 2 with icon note)
		
		if answer = "Yes" then
			create window with profile "weechat"
		end if
	end if
	
	activate
	
end tell
