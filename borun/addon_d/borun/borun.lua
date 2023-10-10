local addonName = "Borun"
local author = "Treasure"

_G["ADDONS"] = _G["ADDONS"] or {}
_G["ADDONS"][author] = _G["ADDONS"][author] or {}
_G["ADDONS"][author][addonName] = _G["ADDONS"][author][addonName] or {}
local g = _G["ADDONS"][author][addonName];

local acutil = require("acutil");
function BORUN_ON_INIT(addon, frame)
    frame:ShowWindow(1);
    acutil.slashCommand("/x",BORUN_CREATE_TIMER);
    acutil.slashCommand("/boran",BORUN_CREATE_TIMER);
    acutil.slashCommand("/borun",BORUN_CREATE_TIMER);
end

function BORUN_CREATE_TIMER()
    g.comidas = {2180};
    local frame = ui.GetFrame("borun");
    local timer = GET_CHILD(frame, "addontimer", "ui::CAddOnTimer");
	timer:SetUpdateScript("BORUN_UPDATE");
    timer:Start(0.4);
end

function BORUN_UPDATE()
    local buffID = table.remove(g.comidas);
    if buffID ~= nil then
        local handle = session.GetMyHandle();
        local buff = info.GetBuff(handle, buffID) or nil;
            
        if buff ~= nil then
            packet.ReqRemoveBuff(buffID);
        end
    else
        BORUN_END();
    end
end

function BORUN_END()
    local frame = ui.GetFrame("borun");
    local timer = GET_CHILD(frame, "addontimer", "ui::CAddOnTimer");
    timer:Stop();
    CHAT_SYSTEM("Boran removed");
end