local timer = 0;

local function botdetector()

if (gamerules.IsMatchTypeCasual() and timer <= os.time()) then

timer = os.time() + 2;
local resources = entities.GetPlayerResources();
local me = entities.GetLocalPlayer( );
if (resources ~= nil and me ~= nil) then

local teams = resources:GetPropDataTableInt("m_iTeam")
local userids = resources:GetPropDataTableInt("m_iUserID")
local accounts = resources:GetPropDataTableInt("m_iAccountID")

local priority = 0~10;
if playerlist.GetPriority( userids[i] ) ~= 0 then
    playerlist.SetPriority( userids[i], 0);
    playerlist.SetPriority( me, -1 )


for i, m in pairs ( teams ) do
local steamid = "[U:1:" .. accounts[i] .. "]";
local playername = client.GetPlayerNameByUserID(userids[i]);

if (
me:GetTeamNumber( ) == m
and userids[i] ~= 0
and steamid ~= "[U:1:0]"
and not steam.IsFriend( steamid )
and playerlist.GetPriority(userids[i]) == priority
) then

printc( 0,255,0,255,"Rage votekicking " .. playername .. " " .. steamid)
client.Command( "callvote kick \"" .. userids[i] .. " cheating\"", true ); goto CalledVote; end
end


end
end
::CalledVote::
end
end



local function botdetector_event(event)
if (event:GetName() == 'game_newmap') then timer = 0 end
end


local function botdetector_message(msg)

if (msg:GetID() == CallVoteFailed) then

local reason = msg:ReadByte()
local cooldown = msg:ReadInt( 16 )

if(cooldown > 0) then 
printc( 255,0,0,255,"Vote Cooldown " .. cooldown .. " Seconds");
timer = os.time() + cooldown
end

end
end




callbacks.Unregister("Draw", "bd")
callbacks.Unregister("FireGameEvent", "bd_event" );
callbacks.Unregister("DispatchUserMessage", "bd_message")
callbacks.Register("Draw", "bd", botdetector)
callbacks.Register("FireGameEvent", "bd_event", botdetector_event );
callbacks.Register("DispatchUserMessage", "bd_message", botdetector_message)
