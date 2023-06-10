local function botdetector()
local active = 0
 
if (gamerules.IsMatchTypeCasual() == true or gamerules.IsMatchTypeCasual() == false) then
 
local resources = entities.GetPlayerResources();
local me = entities.GetLocalPlayer();
if (resources ~= nil and me ~= nil) then
 
local teams = resources:GetPropDataTableInt("m_iTeam")
local userids = resources:GetPropDataTableInt("m_iUserID")
local accounts = resources:GetPropDataTableInt("m_iAccountID")
local partymembers = party.GetMembers();
 
local prio0 = 0
local prio1 = 1
local prio2 = 2
local prio3 = 3
local prio4 = 4
local prio5 = 5
local prio6 = 6
local prio7 = 7
local prio8 = 8
local prio9 = 9
local prio10 = 10
playerlist.SetPriority( me, -1 )
 
for i, m in pairs ( teams ) do
local steamid = "[U:1:" .. accounts[i] .. "]";
local playername = client.GetPlayerNameByUserID(userids[i]);
active = active + 0.00001
 
if (
me:GetTeamNumber( ) == m
and userids[i] ~= 0
and steamid ~= "[U:1:0]"
and userids[i] ~= "[U:1:0]"
or playerlist.GetPriority(userids[i]) == prio0
or playerlist.GetPriority(userids[i]) == prio1
or playerlist.GetPriority(userids[i]) == prio2
or playerlist.GetPriority(userids[i]) == prio3
or playerlist.GetPriority(userids[i]) == prio4
or playerlist.GetPriority(userids[i]) == prio5
or playerlist.GetPriority(userids[i]) == prio6
or playerlist.GetPriority(userids[i]) == prio7
or playerlist.GetPriority(userids[i]) == prio8
or playerlist.GetPriority(userids[i]) == prio9
or playerlist.GetPriority(userids[i]) == prio10
or active >= 100
) then
printc( 0,255,0,255,"Rage votekicking " .. playername .. " " .. steamid)
active = 0
client.Command( "callvote kick \"" .. playername .. " cheating\"", true ); goto CalledVote; end
end
 
 
end
::CalledVote::
end
end
 

 
local function botdetector_message(msg)
 
if (msg:GetID() == CallVoteFailed) then
 
local reason = msg:ReadByte()
local cooldown = msg:ReadInt( 16 )
 
if(cooldown > 0) then 
printc( 255,0,0,255,"Vote Cooldown " .. cooldown .. " Seconds");
end
 
end
end
 
 
 
 
callbacks.Unregister("Draw", "bd")
callbacks.Unregister("FireGameEvent", "bd_event" );
callbacks.Unregister("DispatchUserMessage", "bd_message")
callbacks.Register("Draw", "bd", botdetector)
callbacks.Register("FireGameEvent", "bd_event", botdetector_event );
callbacks.Register("DispatchUserMessage", "bd_message", botdetector_message)
