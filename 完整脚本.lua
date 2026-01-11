-- 测试版本
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- 测试配置保存
local savedConfig = {
    flySpeed = 50,
    walkSpeed = 16
}

local function saveConfig()
    local success, err = pcall(function()
        writefile("Test_Config.json", HttpService:JSONEncode(savedConfig))
        print("✅ 配置已保存: " .. HttpService:JSONEncode(savedConfig))
    end)
    if not success then
        print("❌ 保存失败: " .. tostring(err))
    end
end

local function loadConfig()
    local success, err = pcall(function()
        if isfile("Test_Config.json") then
            local data = readfile("Test_Config.json")
            print("📄 读取到的数据: " .. data)
            savedConfig = HttpService:JSONDecode(data)
            print("✅ 配置已加载: flySpeed=" .. savedConfig.flySpeed .. ", walkSpeed=" .. savedConfig.walkSpeed)
        else
            print("⚠️ 配置文件不存在")
        end
    end)
    if not success then
        print("❌ 加载失败: " .. tostring(err))
    end
end

print("=== 开始测试 ===")
loadConfig()
print("当前配置: flySpeed=" .. savedConfig.flySpeed .. ", walkSpeed=" .. savedConfig.walkSpeed)

-- 修改配置
savedConfig.walkSpeed = 200
savedConfig.flySpeed = 100
print("修改后配置: flySpeed=" .. savedConfig.flySpeed .. ", walkSpeed=" .. savedConfig.walkSpeed)

-- 保存配置
saveConfig()

-- 重新加载
savedConfig = {flySpeed = 50, walkSpeed = 16}
print("重置配置: flySpeed=" .. savedConfig.flySpeed .. ", walkSpeed=" .. savedConfig.walkSpeed)
loadConfig()
print("最终配置: flySpeed=" .. savedConfig.flySpeed .. ", walkSpeed=" .. savedConfig.walkSpeed)
print("=== 测试完成 ===")
