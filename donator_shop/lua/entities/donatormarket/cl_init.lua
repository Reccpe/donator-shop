surface.CreateFont( "donatorShop1", {
	font = "Tahoma", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 33,
	weight = 200,
} )

surface.CreateFont( "donatorShop192", {
	font = "Tahoma", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 23,
	weight = 200,
} )

include("shared.lua")

local star = Material("materials/star.png", "noclamp")
local close = Material("materials/close.png", "noclamp")
local bicak = Material("materials/knife.png", "noclamp")
local para = Material("materials/para.png", "noclamp")

function ENT:Draw()

    self:DrawModel()
    local Ang = self:GetAngles()
    local Pos = self:GetPos()

    if self:GetPos():Distance(LocalPlayer():GetPos()) > 4000 then return end

    Ang:RotateAroundAxis(Ang:Forward(), 90)
    Ang:RotateAroundAxis(Ang:Right(), -90)

    cam.Start3D2D(Pos,Ang,0.39)
        -- Display
        draw.RoundedBox(30,-160,-185,300,35,Color(43,126,32))
        -- 1.Star
        surface.SetMaterial(star)
        surface.SetDrawColor(211,211,211)
        surface.DrawTexturedRect(-150,-183,30,30)

        -- Mesaj 
        draw.SimpleText("Donator Shop","donatorShop1",-10,-169,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        -- 2. Star
        surface.SetMaterial(star)
        surface.SetDrawColor(211,211,211)
        surface.DrawTexturedRect(100,-183,30,30)

    cam.End3D2D()

end 


local scrw,scrh = ScrW(), ScrH()
local ply = LocalPlayer()

net.Receive("gui_olusturma", function()

    if ( IsValid (DONATORSHOP)) then
        DONATORSHOP:SetVisible( true )
        return 
    end

    DONATORSHOP = vgui.Create("DFrame")
    DONATORSHOP:SetSize(scrw * .35, scrh * .8)
    DONATORSHOP:SetTitle("")
    DONATORSHOP:Center()
    DONATORSHOP:ShowCloseButton(true)
    DONATORSHOP:SetSizable( false )
    DONATORSHOP:SetDraggable( false )
    DONATORSHOP:ShowCloseButton(false)
    DONATORSHOP:MakePopup()
    DONATORSHOP.Paint = function(self,w,h)
        surface.SetDrawColor(32,32,32)
        surface.DrawRect(0,0,w,h)
        draw.SimpleText("DONATOR SHOP","donatorShop1",315,24,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
 
    local custButton = vgui.Create("DButton",DONATORSHOP)
    custButton:SetText("")
    custButton:SetMaterial( close )
    custButton:SetPos(622,11)
    custButton:SetSize(35,35)
    custButton.Paint = function(self,w,h) 
        surface.SetDrawColor(255,255,255)
    end
    
    function custButton:DoClick()
        DONATORSHOP:SetVisible(false)
    end 

    local scrollPanel = vgui.Create("DScrollPanel", DONATORSHOP)
    scrollPanel:Dock(FILL)

    local frameW = DONATORSHOP:GetWide()
    local frameH = DONATORSHOP:GetTall()
    local yspace = frameH * .030
    for k,itemData in pairs(DONATORMARKET.Items) do
       local itemPaneli = vgui.Create("DPanel", scrollPanel)
       itemPaneli:Dock(TOP)
       itemPaneli:GetWide(frameW * .021)
       itemPaneli:DockMargin(0,22,0,20,yspace)
       itemPaneli:SetTall(frameH * .085)
       itemPaneli.Paint = function(self,w,h)
           surface.SetDrawColor(64,64,64)
           surface.DrawRect(0,0,w,h)
           surface.SetMaterial( bicak )
           surface.SetDrawColor(255,255,255)
           surface.DrawTexturedRect(10,3,75,60)
           draw.SimpleText(itemData.isim,"donatorShop192",188,18,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
           draw.SimpleText(DarkRP.formatMoney(itemData.fiyat),"donatorShop192",162,50,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
       end

       local marginBosluk = frameW * .029
       local satinAlButonu = vgui.Create("DButton", itemPaneli)
       satinAlButonu:Dock(RIGHT)
       satinAlButonu:DockMargin(0,marginBosluk,marginBosluk,marginBosluk)
       satinAlButonu:SetWide(130)
       satinAlButonu:SetText("")
       satinAlButonu.Paint = function(self,w,h)
        surface.SetDrawColor(56,107,22)
        surface.DrawRect(0,0,w,h)
        draw.SimpleText("Satın al","donatorShop192",37,8,color_white)
       end  
       satinAlButonu.DoClick = function()
         net.Start("satin_alim_yapim")
         net.WriteInt(k,32)
         net.SendToServer()
       end
    end
end)
