local component = require("component")
local computer = require("computer")
local event = require("event")
--local detector = component.ir_augment_detector
--local controler = component.ir_augment_control

local arguments_as_a_table = {...}

local stoptime = 0 --停止し始めた時間

function stopping(duration)

    print("set duration = " ..duration)

    while true do
        print("wait train...")
        event_name, net_address, augment_type, stock_uuid = event.pull("ir_train_overhead")
            
        if augment_type == "LOCO_CONTROL" then
            print("come train")
            stoptime = computer.uptime()
            component.proxy(net_address).setThrottle(0)
            component.proxy(net_address).setBrake(1)
            while computer.uptime() - stoptime < duration do
                os.sleep(1)
            end
            print("start train")
            component.proxy(net_address).setThrottle(0.5)
            component.proxy(net_address).setBrake(0)
            print("cool time")
            os.sleep(30) --30秒間クールタイム
        else
            print("--other type augment!!!!--")
        end
    end
end

if #arguments_as_a_table < 1 then
    stopping(20)
else
    stopping(tonumber(arguments_as_a_table[1]) )
end
