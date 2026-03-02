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

NoCooldown = 0xC1CD44
CrystalSpeed = 0xB2E0FC
AutoKill = 0xC59468
AutoWinz = 0x181E338
AntiReport = 0x6F8680

function main()
    menu = gg.multiChoice({ Mul1 .. " ⪩ ปล่อยตัว 0วิ ",
                            Mul2 .. " ⪩ แร่อันเชิญ x99 ",
                            Mul3 .. " ⪩ ตายออโต้ ",
                                    " ⪩ Auto Winz ",
                            Mul4 .. " ⪩ กันรีพอร์ต PVP",
                            Mul5 .. " ⪩ เร่งเวลาเกม",
                                    " ⪩ ออก "}, nil,
        "━━━━━━━━━━━━━━━━━━━━━━━━━\n[🕹] ʜᴀᴄᴋ ʟɪɴᴇ ʀᴀɴɢᴇʀs ᴠ12.0.0 [64Bit]\n━━━━━━━━━━━━━━━━━━━━━━━━━")

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
        if menu[4] == true then
            Meu4()
        end
        if menu[5] == true then
            Meu5()
        end
        if menu[6] == true then
            Meu6()
        end
        if menu[7] == true then
            Meu7()
        end
    end
end


-- No Cooldown
Mul1 = OFF
function Meu1()
    gg.setRanges(gg.REGION_CODE_APP)
    if Mul1 == OFF then
        PHEX(GAME_BASE + NoCooldown, OBFUSCATE("1F2003D5"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul1 = ON
    elseif Mul1 == ON then
        PHEX(GAME_BASE + NoCooldown, OBFUSCATE("CD000054"))
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul1 = OFF
    end
end

-- Crystal Speed
Mul2 = OFF
function Meu2()
    gg.setRanges(gg.REGION_CODE_APP)
    if Mul2 == OFF then
        PHEX(GAME_BASE + CrystalSpeed, OBFUSCATE("1FBC02B1"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul2 = ON
    elseif Mul2 == ON then
        PHEX(GAME_BASE + CrystalSpeed, OBFUSCATE("0008211E"))
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul2 = OFF
    end
end

-- Auto Kill
Mul3 = OFF
function Meu3()
    gg.setRanges(gg.REGION_CODE_APP)
    if Mul3 == OFF then
        PHEX(GAME_BASE + AutoKill, OBFUSCATE("E8F30032"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul3 = ON
    elseif Mul3 == ON then
        PHEX(GAME_BASE + AutoKill, OBFUSCATE("0859B852"))
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul3 = OFF
    end
end

-- Auto Winz
function Meu4()
    gg.setRanges(gg.REGION_CODE_APP)
        PHEX(GAME_BASE + AutoWinz, OBFUSCATE("00008052"))
        gg.sleep(500)
        PHEX(GAME_BASE + AutoWinz, OBFUSCATE("52A40D94"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
end

-- Anti Report PVP
Mul4 = OFF
function Meu5()
    gg.setRanges(gg.REGION_CODE_APP)
    if Mul4 == OFF then
        PHEX(GAME_BASE + AntiReport, OBFUSCATE("00000000"))
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul4 = ON
    elseif Mul4 == ON then
        PHEX(GAME_BASE + AntiReport, OBFUSCATE("496E666F"))
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul4 = OFF
    end
end

-- Speed Hack
Mul5 = OFF
function Meu6()
    if Mul5 == OFF then
        gg.getResults(gg.getResultsCount())
        gg.editAll("3.0", gg.TYPE_FLOAT)
        gg.toast("✅ ᴅᴏɴᴇ : ON")
        Mul5 = ON
    elseif Mul5 == ON then
        gg.getResults(gg.getResultsCount())
        gg.editAll("1.12000000477", gg.TYPE_FLOAT)
        gg.toast("❌ ᴅᴏɴᴇ : OFF")
        Mul5 = OFF
    end
end

function Meu7()
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