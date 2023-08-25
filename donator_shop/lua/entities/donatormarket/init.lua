AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

    self:SetModel("models/props_interiors/VendingMachineSoda01a.mdl")
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
       phys:Wake() 
    end
end 

util.AddNetworkString("gui_olusturma")

function ENT:Use(activator,caller)
    if ( activator:IsValid() ) then
        if ( caller:IsPlayer() ) then
            net.Start("gui_olusturma")
            net.Send( caller )
        end
    end
end

util.AddNetworkString("satin_alim_yapim")

net.Receive("satin_alim_yapim", function( len, ply )

    local silahID = net.ReadInt(32)
    local itemData = DONATORMARKET.Items[silahID]
    if not itemData then return end

    local canAfford = ply:canAfford(itemData.fiyat)
    if not canAfford then
       ply:ChatPrint("[-] You cant afford to buy that weapon")
       return  
    end
    if itemData.donator and not DONATORMARKET.VIPGruplar[ply:GetUserGroup()] then
        ply:ChatPrint("[+] This weapon only VIP accessable")
        return 
    end
    ply:addMoney(-itemData.fiyat)
    ply:ChatPrint("[+] You successfully bought")
    ply:Give(itemData.silahID)
end)