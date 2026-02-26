--------------------------------------------------
-- CONFIG
--------------------------------------------------
local XOR_KEY = 0xA5

--------------------------------------------------
-- BASE ADDRESS
--------------------------------------------------
local function BaseGames(lib)
    local ranges = gg.getRangesList(lib)
    if #ranges == 0 then
        gg.alert("❌ Library not found : " .. lib)
        os.exit()
    end
    return ranges[1].start
end

--------------------------------------------------
-- HEX <-> TABLE
--------------------------------------------------
local function hexToTable(hex)
    local t = {}
    hex:gsub("%S%S", function(b)
        t[#t + 1] = b
    end)
    return t
end

--------------------------------------------------
-- OBFUSCATE
--------------------------------------------------
function OBFUSCATE(hex)
    local out = {}
    for _, b in ipairs(hexToTable(hex)) do
        local v = tonumber(b, 16)
        out[#out + 1] = string.format("%02X", v ~ XOR_KEY)
    end
    return table.concat(out)
end

local function DEOBFUSCATE(hex)
    return OBFUSCATE(hex) -- XOR กลับด้วย key เดิม
end

--------------------------------------------------
-- PATCH HEX
--------------------------------------------------
function PHEX(address, hex)
    local realHex = DEOBFUSCATE(hex)
    local bytes = hexToTable(realHex)

    local set = {}
    for i, b in ipairs(bytes) do
        set[#set + 1] = {
            address = address + i - 1,
            flags = gg.TYPE_BYTE,
            value = b .. "r"
        }
    end

    gg.setValues(set)
end

--------------------------------------------------
-- EXAMPLE
-------------------------------------------------- 

GAME_BASE = BaseGames("libgame.so")

ON = "[🔴]"
OFF = "[🔵]"

-- Code Value LRG

AutoKill = 0xC59468
AutoWinz = 0x181E338

function main()
    menu = gg.multiChoice({ Mul1 .. " ⪩ ตายออโต้ ",
                                    " ⪩ Auto Winz ",
                                    " ⪩ ออก "}, nil,
        "━━━━━━━━━━━━━━━━━━━━━━━━━\n[🕹] ʜᴀᴄᴋ ʟɪɴᴇ ʀᴀɴɢᴇʀs ᴠ11.7.2 [64Bit]\n━━━━━━━━━━━━━━━━━━━━━━━━━")

    if menu == nil then
    else
        if menu[1] == true then
            Meu1()
        end
        if menu[2] == true then
            Meu2()
        end
        if menu[3] == true then
            Meu3()
        end
    end
end


Mul1 = OFF
function Meu1()
    gg.setRanges(gg.REGION_CODE_APP)
    if Mul1 == OFF then
        PHEX(GAME_BASE + AutoKill, OBFUSCATE("E8F30032"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul1 = ON
    elseif Mul1 == ON then
        PHEX(GAME_BASE + AutoKill, OBFUSCATE("0859B852"))
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul1 = OFF
    end
end

function Meu2()
    gg.setRanges(gg.REGION_CODE_APP)
        PHEX(GAME_BASE + AutoWinz, OBFUSCATE("00008052"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
end

function Meu3()
    gg.toast("👋 ᴇxɪᴛ ᴘʀᴏɢʀᴀᴍ")
    os.exit()
end


while true do
    if gg.isVisible(true) then
        Loop = 1
        gg.setVisible(false)
    end
    if Loop == 1 then
        main()
    end
    Loop = 0

end
