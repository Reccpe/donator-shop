ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Donator Marketi"
ENT.Category = "Reccpe Entities"

ENT.Spawnable = true

DONATORMARKET = DONATORMARKET or {}
DONATORMARKET.VIPGruplar = {
    ["donator"] = true,
}
DONATORMARKET.Items = {
    {
        isim = "Bayonet Fade", // this is name of the category
        fiyat = 65000, // this is price of category
        silahID = "csgo_bayonet_fade", // This is Weapon ID
        donator = true // if u wanna turn off the accessable of donators u can type the 'false'
    },
}